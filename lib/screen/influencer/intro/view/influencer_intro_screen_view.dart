import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/common/widgets/layout/top_bottom_layout.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

import '../state/influencer_intro_screen_state.dart';

class InfluencerIntroScreenView extends StatelessWidget {
  final InfluencerIntroScreenState state;

  const InfluencerIntroScreenView({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.light),
          elevation: 0,
        ),
        body: TopBottomLayout(
          top: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIcon(),
              _buildTitle(context),
              _buildSubtitle(context),
              _buildLevelsSection(context),
            ],
          ),
          bottom: _buildButton(context),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Container(
        height: 80,
        child: SvgPicture.asset(AppImages.influencerRegistrationAddPerson),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Text(
        context.strings.inf.intro.title,
        style: AppText.title,
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      context.strings.inf.intro.subtitle,
      style: AppText.subtitle,
    );
  }

  Widget _buildButton(BuildContext context) {
    return Button(
      text: context.strings.common.next,
      onPressed: () => state.onProceed(),
    );
  }

  Widget _buildLevelsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildLevel(
            title: context.strings.inf.intro.level1.title,
            info: context.strings.inf.intro.level1.information,
          ),
          SizedBox(height: 12),
          _buildLevel(
            title: context.strings.inf.intro.level2.title,
            info: context.strings.inf.intro.level2.information,
          ),
        ],
      ),
    );
  }

  Widget _buildLevel({required String title, required String info}) {
    return Column(
      children: [
        Text(title, style: AppText.subtitle),
        SizedBox(height: 2),
        _buildLevelInfo(info),
      ],
    );
  }

  Widget _buildLevelInfo(String text) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SvgPicture.asset(AppImages.checkIcon),
        ),
        Text(
          text,
          style: AppText.subtitle,
        )
      ],
    );
  }
}
