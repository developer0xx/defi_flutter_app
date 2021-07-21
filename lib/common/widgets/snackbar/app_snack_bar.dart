import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';

class AppSnackBar {
  static void show(BuildContext context, {required Widget content}) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 1000),
        backgroundColor: AppColors.textPrimary,
        content: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flag, color: AppColors.primary, size: 20),
            SizedBox(width: 16),
            DefaultTextStyle(
              style: AppText.text2.copyWith(color: AppColors.primary, fontWeight: FontWeight.w500),
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
