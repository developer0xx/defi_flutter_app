import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/common/widgets/snackbar/snackbars.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';
import 'package:sapiency_app/screen/profile/state/use_profile_screen_state.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class ProfileScreenButtons extends StatelessWidget {
  final ProfileScreenState state;

  const ProfileScreenButtons({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return state.isCurrentUser ? _buildThisUserButtons(context) : _buildOtherUserButtons(context);
  }

  Widget _buildThisUserButtons(BuildContext context) {
    bool isInfluencer = state.user is PublicUserInfluencer;
    if (isInfluencer && !state.user.influencerOrNull!.approved) {
      return ClipRRect(
        borderRadius: AppValues.smallBorderRadius,
        child: Container(
          padding: EdgeInsets.all(12),
          width: MediaQuery.of(context).size.width,
          color: AppColors.primary,
          child: Text(
            context.strings.profile.information.influencerProcessed,
            style: AppText.button,
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: Button(
            padding: EdgeInsets.all(0),
              dense: true,
              text: context.strings.profile.button.edit,
              onPressed: state.onEditTap,
            ),
          ),
          if (!isInfluencer) SizedBox(width: 16),
          if (!isInfluencer)
            Expanded(
              child: Button(
                padding: EdgeInsets.all(0),
                dense: true,
                text: context.strings.profile.button.tokenize,
                onPressed: state.onTokenizeTap,
              ),
            ),
        ],
      );
    }
  }

  Widget _buildOtherUserButtons(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 10,
          child: Button(
            padding: EdgeInsets.all(0),
            dense: true,
            text: context.strings.profile.button.trade,
            onPressed: () => SnackBars.showComingSoon(context),
          ),
        ),
        Spacer(flex: 1),
        Flexible(
          flex: 10,
          child: Button(
            padding: EdgeInsets.all(0),
            dense: true,
            text: context.strings.profile.button.buy,
            onPressed: () => SnackBars.showComingSoon(context),
          ),
        ),
      ],
    );
  }
}
