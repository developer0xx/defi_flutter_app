import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/model/user/wallet/user_wallet.dart';
import 'package:sapiency_app/screen/wallet/state/wallet_page_state.dart';
import 'package:sapiency_app/screen/wallet/widgets/slidable/wallet_slidable_overlay.dart';
import 'package:sapiency_app/screen/wallet/widgets/slidable/wallet_tile.dart';

class WalletSlidable extends HookWidget {
  final WalletPageState state;
  final UserWallet wallet;

  static const double slideValue = 180;

  WalletSlidable({
    required this.state,
    required this.wallet,
  });

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: Duration(milliseconds: 300));
    final offsetController = useState<double>(0);
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, animation) {
        return _buildGestureWrapper(
          animationController: animationController,
          offsetController: offsetController,
          child: Column(
            children: [
              Container(
                color: AppColors.background,
                height: 80,
                child: Stack(
                  children: [
                    WalletTile(state: state, wallet: wallet),
                    WalletSlidableOverlay(
                      resetController: () {
                        animationController.reverse();
                        offsetController.value = 0;
                      },
                      state: state,
                      controllerValue: animationController.value,
                      wallet: wallet,
                    ),
                  ],
                ),
              ),
              Divider(height: 0, thickness: 0.5),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGestureWrapper({
    required ValueNotifier<double> offsetController,
    required AnimationController animationController,
    required Widget child,
  }) {
    return GestureDetector(
      dragStartBehavior: DragStartBehavior.start,
      onHorizontalDragEnd: (details) {
        double controllerValue = animationController.value;
        double velocity = details.velocity.pixelsPerSecond.dx;
        double value = controllerValue * velocity;
        if (value < -40) {
          animationController.forward();
          offsetController.value = slideValue;
        } else if (value > 40) {
          animationController.reverse();
          offsetController.value = 0;
        } else if (controllerValue < 0.5) {
          animationController.reverse();
          offsetController.value = 0;
        } else if (controllerValue >= 0.5) {
          animationController.forward();
          offsetController.value = slideValue;
        }
      },
      onHorizontalDragUpdate: (details) {
        offsetController.value -= details.delta.dx;
        final value = offsetController.value / slideValue;

        animationController.value = value;
      },
      child: child,
    );
  }
}
