import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/common/widgets/crowdsale/background/crowdsale_background.dart';
import 'package:sapiency_app/common/widgets/crowdsale/crowdsale_avatar.dart';
import 'package:sapiency_app/screen/crowdsale/state/crowdsale_screen_state.dart';
import 'package:sapiency_app/screen/crowdsale/widgets/crowdsale_details_grid.dart';
import 'package:sapiency_app/screen/crowdsale/widgets/crowdsale_details_progress.dart';
import 'package:sapiency_app/screen/crowdsale/widgets/crowdsale_token_price_text.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class CrowdsaleScreenView extends StatelessWidget {
  final CrowdsaleScreenState state;
  final GlobalKey scaffoldContainingKey;

  const CrowdsaleScreenView({required this.state, required this.scaffoldContainingKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.postBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: SvgPicture.asset(AppImages.textLogo),
        // actions: [
        //   IconButton(
        //     icon: SvgPicture.asset(
        //       AppImages.bellIcon,
        //       height: 18,
        //       width: 18,
        //     ),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: ListView(
        key: scaffoldContainingKey,
        children: [
          _buildImage(state.user.crowdsaleOrNull!.cover),
          _buildBody(context),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          _buildDescription(context),
          _buildInfo(),
          _buildContributeButton(context),
          SizedBox(height: 24),
          CrowdsaleDetailsGrid(
            user: state.user,
          )
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CrowdsaleAvatar(
                user: state.user,
              ),
              CrowdsaleTokenPriceText(user: state.user),
            ],
          ),
          SizedBox(height: 26),
          CrowdsaleDetailsProgress(state: state),
        ],
      ),
    );
  }

  Widget _buildImage(String url) {
    return CrowdsaleBackground(
      imgUrl: url,
    );
  }

  Widget _buildDescription(BuildContext context) {
    return ReadMoreText(
      state.user.crowdsaleOrNull!.description,
      style: AppText.tileTitle.copyWith(
        fontWeight: FontWeight.normal,
        color: AppColors.grey,
      ),
      trimLength: 100,
      trimExpandedText: context.strings.common.readLess,
      trimCollapsedText: context.strings.common.readMore,
      moreStyle: AppText.tileTitle.copyWith(
        fontWeight: FontWeight.normal,
        color: AppColors.grey,
      ),
      lessStyle: AppText.tileTitle.copyWith(
        fontWeight: FontWeight.normal,
        color: AppColors.grey,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      state.user.crowdsaleOrNull!.title,
      style: AppText.text.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: 20,
        color: AppColors.textDarker,
      ),
    );
  }

  Widget _buildContributeButton(BuildContext context) {
    return Button(
      text: context.strings.crowdsale.button.contribute,
      onPressed: state.onContributePressed,
      enabled: state.user.crowdsaleOrNull!.timeLeft.inDays < 7,
    );
  }
}
