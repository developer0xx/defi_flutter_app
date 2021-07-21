import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/common/widgets/input/app_text_input.dart';
import 'package:sapiency_app/common/widgets/layout/auth_layout.dart';
import 'package:sapiency_app/common/widgets/submit/submit_wrapper.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import 'package:sapiency_app/screen/auth/sign_in/state/use_auth_sign_in_screen_state.dart';

class AuthSignInScreenView extends StatelessWidget {
  final AuthSignInScreenState state;

  const AuthSignInScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return SubmitWrapper(
      state: state.submitState,
      child: AuthLayout(
        withNavigationBack: true,
        columnAlignment: CrossAxisAlignment.start,
        imgPath: AppImages.logo,
        imgHeight: 48,
        title: context.strings.auth.signIn.title,
        subtitle: context.strings.auth.signIn.subtitle,
        contentWidget: _buildForm(context),
        bottomWidget: _buildSignUpSection(context),
        buttonText: context.strings.common.next,
        onProceed: state.submitState.onSubmitPressed,
        isButtonEnabled: !state.submitState.isSubmitInProgress,
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (state.errorMessage != null) _buildError(context),
        AppTextInput(
          state: state.emailState,
          label: context.strings.common.form.email,
          keyboardType: TextInputType.emailAddress,
          onSubmitFocusChanged: state.passwordState.requestFocus,
        ),
        AppTextInput(
          state: state.passwordState,
          label: context.strings.common.form.password,
          linkText: context.strings.auth.signIn.forgotPassword,
          keyboardType: TextInputType.visiblePassword,
          onLinkPressed: state.onForgottenPasswordPressed,
        ),
      ],
    );
  }

  Widget _buildSignUpSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.strings.auth.signIn.alreadyHaveAccount,
          style: AppText.text,
        ),
        Button (
          text: context.strings.auth.signIn.createNewAccount,
          onPressed: state.onSignUpPressed,
          buttonType: ButtonType.secondary,
          elevated: true,
        ),
      ],
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
}