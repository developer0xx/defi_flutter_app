import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/app_hint_card.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/common/widgets/input/app_code_input.dart';
import 'package:sapiency_app/common/widgets/layout/auth_layout.dart';
import 'package:sapiency_app/common/widgets/submit/submit_wrapper.dart';
import 'package:sapiency_app/screen/auth/sign_up/confirm_email/state/use_auth_sign_up_confirm_email_screen_state.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class AuthSignUpConfirmEmailScreenView extends HookWidget {
  final AuthSignUpConfirmEmailScreenState state;

  const AuthSignUpConfirmEmailScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return SubmitWrapper(
      state: state.confirmSubmitState,
      child: AuthLayout(
        withNavigationBack: false,
        columnAlignment: CrossAxisAlignment.center,
        imgPath: AppImages.confirmEmail,
        title: context.strings.auth.signUp.confirmEmail.title,
        subtitle: context.strings.auth.signUp.confirmEmail.subtitle,
        contentWidget: Column(
          children: [
            AppCodeInput(
              state: state.pinState,
              errorStream: state.pinErrorStream.map((event) => ErrorAnimationType.shake),
            ),
            _buildConfirmButton(context),
            _buildCodeNotReceivedSection(context),
          ],
        ),
        bottomWidget: AppHintCard(context.strings.auth.signUp.confirmEmail.hint),
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return Button(
      text: context.strings.auth.signUp.confirmEmail.confirmMyEmail,
      enabled: state.isConfirmButtonEnabled,
      onPressed: state.confirmSubmitState.onSubmitPressed,
    );
  }

  Widget _buildCodeNotReceivedSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.strings.auth.signUp.confirmEmail.codeNotReceived,
          style: AppText.text,
        ),
        IntrinsicWidth(
          child: Button(
            text: context.strings.common.resend,
            onPressed: state.resendSubmitState.onSubmitPressed,
            enabled: !state.resendSubmitState.isSubmitInProgress,
            buttonType: ButtonType.secondary,
            elevated: true,
            loading: state.resendSubmitState.isSubmitInProgress,
          ),
        ),
      ],
    );
  }
}
