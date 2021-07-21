import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/snackbar/snackbars.dart';

class WalletIcon extends StatelessWidget {
  final String iconPath;
  final String? title;
  final TextStyle? titleStyle;
  final double size;
  final Function()? onPressed;

  const WalletIcon({
    Key? key,
    required this.iconPath,
    this.onPressed,
    this.titleStyle,
    this.title,
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildImageIcon(context),
        if (title != null) _buildTitle(),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      title!,
      style: titleStyle ?? AppText.label.copyWith(color: Colors.white),
    );
  }

  Widget _buildImageIcon(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: InkWell(
        onTap: () {
          if (onPressed != null)
            onPressed!();
          else
            SnackBars.showComingSoon(context);
        },
        child: Card(
          elevation: 3,
          color: Colors.white,
          shape: CircleBorder(),
          child: Padding(
            padding: EdgeInsets.all(size / 5),
            child: SvgPicture.asset(
              iconPath,
              height: 10,
              width: 10,
            ),
          ),
        ),
      ),
    );
  }
}
