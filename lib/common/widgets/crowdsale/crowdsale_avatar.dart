import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/avatar/user_avatar.dart';
import 'package:sapiency_app/common/widgets/crowdsale/rahim_profile_picture.dart';
import 'package:sapiency_app/model/influencer/influencer.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/profile/profile_screen_args.dart';
import 'package:sapiency_app/screen/profile/profile_screen.dart';

class CrowdsaleAvatar extends HookWidget {
  final PublicUserInfluencer user;

  const CrowdsaleAvatar({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();

    return InkWell(
      child: GestureDetector(
        onTap: () => navigator.pushNamed(ProfileScreen.route, arguments: ProfileScreenArgs(user: user)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserAvatar(
              avatarUrl: user.imageUrl,
              size: 45,
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.influencerOrNull!.fullName,
                  style: AppText.text.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    color: AppColors.textDarker,
                  ),
                ),
                Text(
                  user.influencerOrNull!.token,
                  style: AppText.label.copyWith(
                    fontWeight: FontWeight.normal,
                    height: 1.2,
                    color: AppColors.textParagraph,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
