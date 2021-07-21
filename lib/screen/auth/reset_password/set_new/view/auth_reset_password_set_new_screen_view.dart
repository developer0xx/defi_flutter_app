import 'package:flutter/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/input/app_code_input.dart';
import 'package:sapiency_app/common/widgets/input/app_text_input.dart';
import 'package:sapiency_app/common/widgets/layout/auth_layout.dart';
import 'package:sapiency_app/common/widgets/submit/submit_wrapper.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import 'package:sapiency_app/screen/auth/reset_password/set_new/state/use_auth_reset_password_set_new_screen_state.dart';

class AuthResetPasswordSetNewScreenView extends StatelessWidget {
  final AuthResetPasswordSetNewScreenState state;

  const AuthResetPasswordSetNewScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return SubmitWrapper(
      state: state.submitState,
      child: AuthLayout(
        columnAlignment: CrossAxisAlignment.start,
        imgPath: AppImages.resetPassword,
        title: context.strings.auth.resetPassword.setNew.title,
        subtitle: context.strings.auth.resetPassword.setNew.subtitle,
        contentWidget: _buildForm(context),
        buttonText: context.strings.auth.resetPassword.setNew.resetMyPassword,
        onProceed: state.submitState.onSubmitPressed,
        isButtonEnabled: state.isSubmitButtonEnabled,
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.strings.auth.resetPassword.setNew.typeCode,
          style: AppText.label,
        ),
        AppCodeInput(
          state: state.pinState,
          errorStream: state.pinErrorStream.map((event) => ErrorAnimationType.shake),
        ),
        AppTextInput(
          state: state.passwordState,
          label: context.strings.auth.resetPassword.setNew.password,
          keyboardType: TextInputType.visiblePassword,
          onSubmitFocusChanged: state.confirmPasswordState.requestFocus,
        ),
        AppTextInput(
          state: state.confirmPasswordState,
          label: context.strings.auth.resetPassword.setNew.confirm,
          keyboardType: TextInputType.visiblePassword,
        ),
      ],
    );
  }

}