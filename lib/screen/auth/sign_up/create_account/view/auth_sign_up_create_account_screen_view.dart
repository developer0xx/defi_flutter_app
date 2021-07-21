import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/app_link.dart';
import 'package:sapiency_app/common/widgets/input/app_text_input.dart';
import 'package:sapiency_app/common/widgets/layout/auth_layout.dart';
import 'package:sapiency_app/common/widgets/submit/submit_wrapper.dart';
import 'package:sapiency_app/screen/auth/sign_up/create_account/state/use_auth_sign_up_create_account_screen_state.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class AuthSignUpCreateAccountScreenView extends StatelessWidget {
  final AuthSignUpCreateAccountScreenState state;

  const AuthSignUpCreateAccountScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return SubmitWrapper(
      state: state.submitState,
      child: AuthLayout(
        columnAlignment: CrossAxisAlignment.start,
        imgPath: AppImages.logo,
        imgHeight: 48,
        title: context.strings.auth.signUp.createAccount.title,
        subtitle: context.strings.auth.signUp.createAccount.subtitle,
        contentWidget: _buildForm(context),
        bottomWidget: _buildSignInSection(context),
        buttonText: context.strings.common.next,
        onProceed: () => state.showTermsBottomSheet(context),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextInput(
          state: state.emailState,
          label: context.strings.common.form.email,
          keyboardType: TextInputType.emailAddress,
          onSubmitFocusChanged: state.nicknameState.requestFocus,
        ),
        AppTextInput(
          state: state.nicknameState,
          label: context.strings.common.form.nickname,
          keyboardType: TextInputType.text,
          onSubmitFocusChanged: state.passwordState.requestFocus,
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[@& ]'))],
        ),
        AppTextInput(
          state: state.passwordState,
          label: context.strings.common.form.password,
          keyboardType: TextInputType.visiblePassword,
        ),
      ],
    );
  }

  Widget _buildSignInSection(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text(
          context.strings.auth.signUp.createAccount.alreadyHaveAnAccount,
          style: AppText.text,
        ),
        AppLink(
          label: context.strings.auth.signUp.createAccount.signIn,
          onTap: () => state.onSignInPressed(),
        ),
      ],
    );
  }
}
