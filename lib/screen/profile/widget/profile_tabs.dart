import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/screen/profile/state/use_profile_screen_state.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class ProfileScreenTabs extends StatelessWidget {
  final ProfileScreenState state;

  const ProfileScreenTabs({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Material(
            color: Colors.white,
            elevation: 3,
            child: TabBar(
              indicatorColor: AppColors.primary,
              tabs: [
                Tab(child: Text(context.strings.profile.tab.home, style: AppText.text2)),
                Tab(child: Text(context.strings.profile.tab.giveaways, style: AppText.text2)),
                Tab(child: Text(context.strings.profile.tab.holders, style: AppText.text2)),
              ],
            ),
          ),
          Container(
            color: AppColors.background,
            height: 200,
            child: TabBarView(
              children: [
                //TODO remove mock ups
                Center(child: Container(child: Text(context.strings.snackbar.comingSoon))),
                Center(child: Container(child: Text(context.strings.snackbar.comingSoon))),
                Center(child: Container(child: Text(context.strings.snackbar.comingSoon))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
