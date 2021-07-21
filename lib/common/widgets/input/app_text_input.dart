import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/app_link.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';

import '../../../util/widget/wrapper/stateless_text_controller_wrapper.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text.dart';

class AppTextInput extends HookWidget {
  final FieldState state;
  final String? label;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int maxLines;
  final int? minLines;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? linkText;
  final String? hintText;
  final Function()? onLinkPressed;
  final Function()? onSubmitFocusChanged;
  final Function()? onTap;
  final String? suffixText;
  final Widget? customSuffix;

  const AppTextInput({
    required this.state,
    this.label,
    this.onTap,
    this.inputFormatters,
    this.maxLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.readOnly = false,
    this.hintText,
    this.textInputAction,
    this.keyboardType,
    this.linkText,
    this.onSubmitFocusChanged,
    this.onLinkPressed,
    this.suffixText,
    this.customSuffix,
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
              onTap: () => onLinkPressed?.call(),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return TextFormField(
      textInputAction: textInputAction ?? TextInputAction.done,
      inputFormatters: inputFormatters,
      focusNode: state.focusNode,
      onFieldSubmitted: (text) {
        state.onSubmit?.call(text);
        onSubmitFocusChanged?.call();
      },
      scrollPhysics: BouncingScrollPhysics(),
      controller: controller,
      readOnly: readOnly,
      onChanged: (text) => state.onChanged(text),
      onTap: () => onTap?.call(),
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      decoration: _buildInputDecoration(state.focusNode),
      style: AppText.text.copyWith(color: Colors.black),
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

  Widget _buildError(BuildContext context) {
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

  Widget _buildSuffix(FocusNode node) {
    if (customSuffix != null) return customSuffix!;
    if (suffixText != null) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(suffixText!, style: AppText.text),
      );
    }
    if (state.isObscured != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: IconButton(
          icon: Icon(Icons.remove_red_eye, color: node.hasFocus ? AppColors.primary : AppColors.textParagraph),
          onPressed: () => state.onIsObscuredChanged(),
        ),
      );
    }
    return SizedBox.shrink();
  }

  InputDecoration _buildInputDecoration(FocusNode node) {
    return InputDecoration(
      counterText: "",
      hintText: hintText,
      suffixIcon: _buildSuffix(node),
    );
  }
}
