import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/common/widgets/layout/top_bottom_layout.dart';

class AuthLayout extends StatelessWidget {
  final CrossAxisAlignment columnAlignment;
  final String imgPath;
  final double imgHeight;
  final String title;
  final String subtitle;
  final String? buttonText;
  final bool isButtonEnabled;
  final Widget contentWidget;
  final Widget? bottomWidget;
  final bool withNavigationBack;
  final Function()? onProceed;

  const AuthLayout({
    Key? key,
    required this.columnAlignment,
    required this.imgPath,
    this.imgHeight = 60,
    required this.title,
    required this.subtitle,
    required this.contentWidget,
    this.buttonText,
    this.onProceed,
    this.withNavigationBack = true,
    this.bottomWidget,
    this.isButtonEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.light),
          automaticallyImplyLeading: withNavigationBack,
          elevation: 0,
        ),
        backgroundColor: AppColors.background,
        body: TopBottomLayout(
          top: Column(
            crossAxisAlignment: columnAlignment,
            children: [
              _buildIcon(),
              _buildTitle(),
              _buildSubtitle(),
              contentWidget,
              if (buttonText != null && onProceed != null) _buildButton(),
            ],
          ),
          bottom: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: bottomWidget,
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Container(
        height: imgHeight,
        child: SvgPicture.asset(imgPath),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.0),
      child: Text(
        title,
        style: AppText.title,
        textAlign: toggleTextAlign,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Text(
        subtitle,
        style: AppText.subtitle,
        textAlign: toggleTextAlign,
      ),
    );
  }

  Widget _buildButton() {
    return Button(
      text: buttonText!,
      onPressed: () => onProceed!(),
      enabled: isButtonEnabled,
    );
  }

  TextAlign get toggleTextAlign => columnAlignment == CrossAxisAlignment.center ? TextAlign.center : TextAlign.start;
}
