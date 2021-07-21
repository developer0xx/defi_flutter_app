import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/state/submit/use_submit_state.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

import 'influencer_progress_bar.dart';

class InfluencerViewLayout extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String progressTitle;
  final String? buttonTitle;
  final int step;
  final Widget child;
  final bool buttonEnabled;
  final bool buttonLoading;
  final bool hasButton;
  final Function() onProceed;

  const InfluencerViewLayout({
    Key? key,
    this.title,
    this.subtitle,
    required this.progressTitle,
    required this.step,
    required this.child,
    required this.onProceed,
    this.buttonEnabled = true,
    this.buttonLoading = false,
    this.buttonTitle,
    this.hasButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _buildAppBar(context),
        backgroundColor: AppColors.background,
        body: ListView(
          padding: AppValues.screenPadding,
          children: [
            if (title != null) _buildTitle(),
            if (subtitle != null) _buildSubtitle(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: child,
            ),
            if (hasButton) _buildButton(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Hero(
        tag: 'appbar',
        child: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.light),
          backgroundColor: AppColors.background,
          title: Text(
            context.strings.inf.flow.appbar,
            style: AppText.subtitle,
          ),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: InfluencerProgressBar(
              step: step,
              title: progressTitle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Text(
        title!,
        style: AppText.title,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      subtitle!,
      style: AppText.subtitle,
    );
  }

  Widget _buildButton(BuildContext context) {
    return Button(
      text: buttonTitle ?? context.strings.common.next,
      onPressed: () => onProceed(),
      enabled: buttonEnabled,
      loading: buttonLoading,
    );
  }
}
