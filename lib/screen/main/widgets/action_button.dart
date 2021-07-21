import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_images.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ActionButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.accent,
              AppColors.primary,
            ],
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Center(
              child: SvgPicture.asset(
                AppImages.actionButtonIcon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
