import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sapiency_app/common/constants/app_values.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text.dart';

enum ButtonType { primary, secondary }

class Button extends StatelessWidget {
  final String text;
  final ButtonType buttonType;
  final Function()? onPressed;
  final FontWeight fontWeight;
  final bool enabled;
  final EdgeInsets? padding;
  final bool elevated;
  final bool loading;
  final bool dense;

  Button({
    key,
    required this.text,
    this.onPressed,
    this.padding,
    this.enabled = true,
    this.fontWeight = FontWeight.w700,
    this.buttonType = ButtonType.primary,
    this.elevated = false,
    this.loading = false,
    this.dense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = (buttonType == ButtonType.primary) ? AppColors.primary : Colors.white;
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              elevation: elevated ? 1 : 0,
              color: backgroundColor,
              disabledColor: AppColors.primary.withOpacity(0.5),
              onPressed: enabled ? onPressed : null,
              shape: RoundedRectangleBorder(borderRadius: AppValues.smallBorderRadius),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: dense ? 0 : 10.0),
                child: _buildTitle(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final textColor = (buttonType == ButtonType.primary) ? Colors.white : AppColors.primary;
    return Padding(
      padding: const EdgeInsets.all(4),
      child: loading
          ? SpinKitThreeBounce(
              color: textColor,
              size: 20,
            )
          : Text(
              text,
              style: AppText.button.copyWith(color: textColor),
            ),
    );
  }
}
