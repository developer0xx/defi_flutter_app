import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/input/stateless_text_controller_wrapper.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/screen/influencer/metatags/state/influencer_metatags_screen_state.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class MetatagsField extends StatelessWidget {
  final List<String> tags;
  final FieldState fieldState;
  final String label;
  final Function(String) onTagAdded;
  final Function(String) onTagRemoved;
  final bool isEnabled;

  const MetatagsField({
    Key? key,
    required this.tags,
    required this.fieldState,
    required this.label,
    required this.onTagRemoved,
    required this.onTagAdded,
    required this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppText.label,
        ),
        SizedBox(height: 4),
        Container(
          constraints: BoxConstraints(
            minHeight: 100,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: AppValues.smallBorderRadius),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Wrap(
                children: [
                  for (final tag in tags) _buildTag(tag),
                  _buildTextField(context),
                ],
              ),
            ),
          ),
        ),
        if (fieldState.errorMessage != null)
          Text(
            fieldState.errorMessage!(context),
            style: AppText.label.copyWith(color: Colors.redAccent),
          ),
      ],
    );
  }

  Widget _buildTextField(BuildContext context) {
    return StatelessTextEditingControllerWrapper(
      value: fieldState.value,
      onChanged: fieldState.onChanged,
      child: (controller) => TextField(
        focusNode: fieldState.focusNode,
        controller: controller,
        enabled: isEnabled,
        autofocus: false,
        onSubmitted: (tag) {
          onTagAdded(tag);
          fieldState.onChanged('');
          FocusScope.of(context).requestFocus(fieldState.focusNode);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: AppText.label,
          hintText: context.strings.inf.metatags.hint,
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(300),
          color: AppColors.tagBackground,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 12, top: 3, bottom: 3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: Text(
                    tag,
                    style: AppText.label,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => onTagRemoved(tag),
                child: Icon(
                  Icons.cancel_sharp,
                  color: AppColors.light,
                  size: 18,
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
