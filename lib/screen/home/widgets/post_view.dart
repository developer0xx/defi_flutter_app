import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/crowdsale/background/crowdsale_background.dart';
import 'package:sapiency_app/common/widgets/crowdsale/crowdsale_avatar.dart';
import 'package:sapiency_app/common/widgets/crowdsale_progress_bar.dart';
import 'package:sapiency_app/common/widgets/input/date_input/date_input_helper.dart';
import 'package:sapiency_app/model/crowdsale/crowdsale.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';
import 'package:sapiency_app/screen/crowdsale/crowdsale_screen.dart';
import 'package:sapiency_app/screen/crowdsale/state/crowdsale_screen_args.dart';
import 'package:sapiency_app/screen/crowdsale/widgets/crowdsale_days_left.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import 'package:sapiency_app/util/extension/decimal_extension.dart';

class PostView extends StatelessWidget {
  final PublicUserInfluencer user;

  PostView({Key? key, required this.user}) : super(key: key);

  Crowdsale get crowdsale => user.crowdsaleOrNull!;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        CrowdsaleScreen.route,
        arguments: CrowdsaleScreenArgs(user: user),
      ),
      child: Column(
        children: [
          _buildImage(),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildInfluencerRow(),
                SizedBox(height: 24),
                _buildContent(context),
                SizedBox(height: 30),
                _buildCrowdsaleStatus(context),
              ],
            ),
          ),
          Container(height: 4, color: Color(0xFAFBFB)),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return CrowdsaleBackground(imgUrl: crowdsale.cover);
  }

  Widget _buildInfluencerRow() {
    return Row(
      children: [
        CrowdsaleAvatar(
          user: user,
        ),
        Spacer(),
        // SvgPicture.asset(
        //   AppImages.heartFullIcon,
        //   height: 16,
        //   width: 16,
        // )
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          crowdsale.title,
          style: AppText.tileTitle.copyWith(
            fontWeight: FontWeight.normal,
            color: AppColors.textDarker,
          ),
        ),
        ReadMoreText(
          crowdsale.description,
          style: AppText.text.copyWith(
            fontWeight: FontWeight.normal,
            color: AppColors.grey,
          ),
          trimLength: 100,
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
      ],
    );
  }

  Widget _buildCrowdsaleStatus(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!DateHelper.isCrowdsaleUpcoming(crowdsale.timeLeft)) ...[
          _buildTopProgressInfo(context),
          _buildProgressBar(),
        ],
        _buildBottomProgressInfo(context),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 24),
      child: CrowdsaleProgressBar(
        percentRaised: crowdsale.sold.percent,
      ),
    );
  }

  Widget _buildTopProgressInfo(BuildContext context) {
    return Row(
      children: [
        Text(
          crowdsale.sold.value.toCashDisplay(),
          style: AppText.text.copyWith(
            fontWeight: FontWeight.normal,
            color: AppColors.textDarker,
          ),
        ),
        SizedBox(width: 4),
        Text(context.strings.crowdsale.raised),
        Spacer(),
        Text(
          "${crowdsale.sold.percent.round()}%",
          style: AppText.text.copyWith(
            fontWeight: FontWeight.normal,
            color: AppColors.textDarker,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomProgressInfo(BuildContext context) {
    return Row(
      children: [
        CrowdsaleDaysLeft(daysLeft: DateHelper.timeLeftFromDuration(crowdsale.timeLeft, context)),
        Spacer(),
        Text(
          crowdsale.price.toCashDisplay(),
          style: AppText.text.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
