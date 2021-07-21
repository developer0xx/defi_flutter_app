import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/app_link.dart';
import 'package:sapiency_app/common/widgets/input/date_input/date_input_helper.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';

import '../../../../util/widget/wrapper/stateless_text_controller_wrapper.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_text.dart';

class AppDateInput extends HookWidget {
  final FieldState state;
  final String? label;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final String? linkText;
  final Function()? onLinkPressed;
  final Function()? onSubmitFocusChanged;

  const AppDateInput({
    required this.state,
    this.label,
    this.readOnly = true,
    this.textInputAction,
    this.linkText,
    this.onSubmitFocusChanged,
    this.onLinkPressed,
  });

  @override
  Widget build(BuildContext context) {
    useListenable(state.focusNode); // subscribe to hasFocus changes
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null || linkText != null) _buildLabelWithLink(context),
          Material(
            shape: RoundedRectangleBorder(borderRadius: AppValues.smallBorderRadius),
            color: Colors.transparent,
            elevation: 1,
            child: StatelessTextEditingControllerWrapper(
              value: state.value,
              onChanged: state.onChanged,
              child: _buildTextField,
            ),
          ),
          if (state.errorMessage != null) _buildError(context),
        ],
      ),
    );
  }

  Widget _buildLabelWithLink(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: [
          if (label != null) _buildLabel(state.focusNode),
          Spacer(),
          if (linkText != null)
            AppLink(
              fontSize: 12,
              label: linkText!,
              onTap: onLinkPressed?.call(),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return TextFormField(
      textInputAction: textInputAction ?? TextInputAction.done,
      inputFormatters: [TextInputMask(mask: '99-99-9999', reverse: false)],
      focusNode: state.focusNode,
      onFieldSubmitted: (text) {
        state.onSubmit?.call(text);
        onSubmitFocusChanged?.call();
      },
      controller: controller,
      readOnly: readOnly,
      onChanged: (text) => state.onChanged(text),
      maxLength: 10,
      keyboardType: TextInputType.number,
      decoration: _buildInputDecoration(state.focusNode),
      style: AppText.text,
      obscureText: state.isObscured ?? false,
    );
  }

  Widget _buildLabel(node) {
    return Text(
      label!,
      style: AppText.label.copyWith(
        color: node.hasFocus ? AppColors.primary : AppColors.textPrimary,
      ),
    );
  }

  Widget _buildError(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 4),
      child: Text(
        state.errorMessage!(context),
        style: AppText.label.copyWith(
          color: Colors.redAccent,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(FocusNode node) {
    return InputDecoration(
      counterText: "",
      hintText: DateHelper.dateFormat.toUpperCase(),
      suffixIcon: state.isObscured != null
          ? IconButton(
              padding: const EdgeInsets.only(right: 16),
              icon: Icon(Icons.remove_red_eye, color: node.hasFocus ? AppColors.primary : AppColors.textParagraph),
              onPressed: () => state.onIsObscuredChanged(),
            )
          : SizedBox.shrink(),
    );
  }
}
