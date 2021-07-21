import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/common/widgets/snackbar/snackbars.dart';
import 'package:sapiency_app/common/widgets/tags/metatags_display.dart';
import 'package:sapiency_app/screen/profile/state/use_profile_screen_state.dart';
import 'package:sapiency_app/screen/profile/widget/profile_avatar.dart';
import 'package:sapiency_app/screen/profile/widget/profile_buttons.dart';
import 'package:sapiency_app/screen/profile/widget/profile_tabs.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class ProfileScreenView extends StatelessWidget {
  final ProfileScreenState state;

  const ProfileScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    final bool isInfluencer = state.user.influencerOrNull != null;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SvgPicture.asset(AppImages.textLogo),
        elevation: 1,
      ),
      body: Container(
        color: isInfluencer ? AppColors.background : Colors.white,
        child: ListView(
          children: [
            _buildTop(context),
            if (isInfluencer) ProfileScreenTabs(state: state),
          ],
        ),
      ),
    );
  }

  Widget _buildTop(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: AppValues.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileAvatar(
            name: state.user.influencerOrNull?.fullName ?? state.user.nickname,
            url: state.user.imageUrl,
            tokenName: state.user.influencerOrNull?.token,
          ),
          SizedBox(height: 16),
          if (state.user.description != null)
            ReadMoreText(
              state.user.description!,
              style: AppText.text2,
              trimLength: 200,
              trimExpandedText: context.strings.common.readLess,
              trimCollapsedText: context.strings.common.readMore,
              moreStyle: AppText.text.copyWith(
                fontWeight: FontWeight.normal,
                color: AppColors.grey,
              ),
              lessStyle: AppText.text.copyWith(
                fontWeight: FontWeight.normal,
                color: AppColors.grey,
              ),
            ),
          SizedBox(height: 12),
          if (state.user.influencerOrNull?.metaTags != null)
            MetatagsDisplay(
              tags: state.user.influencerOrNull!.metaTags,
              removeLabel: true,
            ),
          ProfileScreenButtons(state: state),
        ],
      ),
    );
  }
}
