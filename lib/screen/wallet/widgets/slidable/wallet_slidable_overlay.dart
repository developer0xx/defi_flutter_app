import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/snackbar/snackbars.dart';
import 'package:sapiency_app/model/user/wallet/user_wallet.dart';
import 'package:sapiency_app/screen/wallet/state/wallet_page_state.dart';
import 'package:sapiency_app/screen/wallet/widgets/slidable/wallet_slidable.dart';
import 'package:sapiency_app/screen/wallet/widgets/wallet_icon.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class WalletSlidableOverlay extends StatelessWidget {
  final WalletPageState state;
  final UserWallet wallet;
  final double controllerValue;
  final Function() resetController;

  WalletSlidableOverlay({
    required this.state,
    required this.controllerValue,
    required this.wallet,
    required this.resetController,
  });

  @override
  Widget build(BuildContext context) {
    return _buildSlidable(context);
  }

  Widget _buildSlidable(BuildContext context) {
    final double slideContent = MediaQuery.of(context).size.width - (WalletSlidable.slideValue * controllerValue);

    return Transform(
      transform: Matrix4.identity()..translate(slideContent),
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: AppValues.smallBorderRadius,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.accent,
              AppColors.primary,
            ],
          ),
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSlidableIcon(
                iconPath: AppImages.send2Icon,
                title: context.strings.wallet.slideable.send,
                onPressed: () => state.onSendPressed(wallet),
                context: context,
              ),
              _buildSlidableIcon(
                iconPath: AppImages.currencyIcon,
                title: context.strings.wallet.slideable.trade,
                context: context,
              ),
              _buildSlidableIcon(
                iconPath: AppImages.personIcon,
                title: context.strings.wallet.slideable.profile,
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlidableIcon({
    required String iconPath,
    required String title,
    Function()? onPressed,
    required BuildContext context,
  }) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: WalletIcon(
          onPressed: () {
            if (onPressed != null)
              onPressed();
            else
              SnackBars.showComingSoon(context);
            resetController();
          },
          iconPath: iconPath,
          title: title,
          size: 38,
          titleStyle: AppText.caption,
        ),
      ),
    );
  }
}
