import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import '../state/welcome_screen_state.dart';

class WelcomeScreenView extends StatelessWidget {
  final WelcomeScreenState state;

  const WelcomeScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //if the image is to small white should extend it
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildBackground(context),
          _buildForeground(context),
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        AppImages.welcomeBackground,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildForeground(BuildContext context) {
    return Padding(
      padding: AppValues.screenPadding,
      child: SafeArea(
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.strings.welcome.text1,
                style: AppText.text2.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                  height: 0.7,
                ),
              ),
              Text(
                context.strings.welcome.text2,
                style: AppText.text2.copyWith(
                  color: Color(0xffFFC8B0),
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
              SizedBox(height: 24),
              Text(
                context.strings.welcome.text3,
                style: AppText.text.copyWith(color: Color(0xffFFF7E5).withOpacity(0.7), fontWeight: FontWeight.w500),
              ),
              _buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: Row(
        children: [
          Flexible(
            flex: 8,
            child: Button(
              text: context.strings.welcome.button.signUp,
              onPressed: state.onSignUpPressed,
            ),
          ),
          SizedBox(width: 16),
          Flexible(
            flex: 5,
            child: Button(
              buttonType: ButtonType.secondary,
              text: context.strings.welcome.button.signIn,
              onPressed: state.onSignInPressed,
            ),
          ),
          Spacer(flex: 4),
        ],
      ),
    );
  }
}
