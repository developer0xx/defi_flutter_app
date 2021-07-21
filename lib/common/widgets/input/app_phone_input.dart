import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/input/stateless_text_controller_wrapper.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';

class AppPhoneInput extends HookWidget {
  final FieldState state;
  final String? label;
  final EdgeInsets? padding;
  final List<String>? countries;
  final String? hintText;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final String? initialCountryCode;
  final String? Function(String?)? validator;

  const AppPhoneInput({
    required this.state,
    this.label,
    this.padding,
    this.countries = const ['PL'],
    this.hintText,
    this.textInputAction,
    this.inputFormatters,
    this.readOnly,
    this.initialCountryCode = 'PL',
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    useListenable(state.focusNode); // subscribe to hasFocus changes
    return Padding(
      padding: padding ?? EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) _buildLabel(state.focusNode),
          Material(
            shape: RoundedRectangleBorder(borderRadius: AppValues.smallBorderRadius),
            color: Colors.transparent,
            elevation: 1,
            child: StatelessTextEditingControllerWrapper(
              value: state.value,
              onChanged: state.onChanged,
              child: _buildPhoneField,
            ),
          ),
          if (state.errorMessage != null) _buildError(context),
        ],
      ),
    );
  }

  Widget _buildPhoneField(TextEditingController controller) {
    return IntlPhoneField(
        countries: countries,
        showDropdownIcon: false,
        controller: controller,
        initialCountryCode: initialCountryCode,
        textInputAction: textInputAction ?? TextInputAction.done,
        focusNode: state.focusNode,
        onSubmitted: (text) => state.onSubmit?.call(text),
        onChanged: (phone) => (phone.completeNumber),
        readOnly: readOnly ?? false,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          counterText: '',
          hintText: hintText,
        ),
        style: AppText.text,
        validator: validator,
    );
  }

  Widget _buildLabel(node) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        label!,
        style: AppText.label.copyWith(
          color: node.hasFocus ? AppColors.primary : AppColors.textParagraph,
        ),
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
}
