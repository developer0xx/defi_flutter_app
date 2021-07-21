import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/widgets/input/app_phone_input.dart';
import 'package:sapiency_app/common/widgets/layout/auth_layout.dart';
import 'package:sapiency_app/common/widgets/submit/submit_wrapper.dart';
import '../state/use_auth_sign_up_phone_screen_state.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class AuthSignUpPhoneScreenView extends StatelessWidget {
  final AuthSignUpPhoneScreenState state;

  const AuthSignUpPhoneScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return SubmitWrapper(
      state: state.submitState,
      child: AuthLayout(
        withNavigationBack: true,
        columnAlignment: CrossAxisAlignment.center,
        imgPath: AppImages.typePhoneNumber,
        title: context.strings.auth.signUp.phone.title,
        subtitle: context.strings.auth.signUp.phone.subtitle,
        contentWidget: AppPhoneInput(
          state: state.phoneState,
          label: context.strings.auth.signUp.phone.yourNumber,
          hintText: context.strings.auth.signUp.phone.typeYourNumber,
        ),
        buttonText: context.strings.common.next,
        isButtonEnabled: state.isProceedButtonEnabled,
        onProceed: state.submitState.onSubmitPressed,
      ),
    );
  }
}
