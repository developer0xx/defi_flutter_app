import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/widgets/input/app_text_input.dart';
import 'package:sapiency_app/common/widgets/layout/auth_layout.dart';
import 'package:sapiency_app/common/widgets/submit/submit_wrapper.dart';

import 'package:sapiency_app/screen/auth/reset_password/enter_email/state/use_auth_reset_password_enter_email_screen_state.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class AuthResetPasswordEnterEmailScreenView extends StatelessWidget {
  final AuthResetPasswordEnterEmailScreenState state;

  const AuthResetPasswordEnterEmailScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return SubmitWrapper(
      state: state.submitState,
      child: AuthLayout(
        withNavigationBack: true,
        columnAlignment: CrossAxisAlignment.start,
        imgPath: AppImages.resetPassword,
        title: context.strings.auth.resetPassword.enterEmail.title,
        subtitle: context.strings.auth.resetPassword.enterEmail.subtitle,
        contentWidget: AppTextInput(
          state: state.emailState,
          label: context.strings.common.form.email,
          keyboardType: TextInputType.emailAddress,
        ),
        buttonText: context.strings.common.next,
        onProceed: state.submitState.onSubmitPressed,
        isButtonEnabled: state.isSubmitButtonEnabled,
      ),
    );
  }
}
