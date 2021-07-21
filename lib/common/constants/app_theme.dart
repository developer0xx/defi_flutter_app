import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';

import 'app_values.dart';

class AppTheme {
  // Provide sensible defaults for material components. In other cases, use constants from AppText/AppColors
  static final defaultTheme = ThemeData(
    primaryColor: AppColors.primary,
    accentColor: AppColors.accent,
    scaffoldBackgroundColor: AppColors.background,
    iconTheme: IconThemeData(color: AppColors.textParagraph),
    appBarTheme: AppBarTheme(
      titleTextStyle: AppText.text,
      brightness: Brightness.light,
      backgroundColor: AppColors.background,
      iconTheme: IconThemeData(color: AppColors.textParagraph),
    ),
    textTheme: TextTheme(
      headline6: AppText.title,
      subtitle1: AppText.label.copyWith(color: AppColors.textPrimary),
      subtitle2: AppText.title,
      bodyText2: AppText.text,
      button: AppText.button,
    ),
    buttonTheme: ButtonThemeData(disabledColor: AppColors.primary.withOpacity(0.2)),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppText.text,
      isCollapsed: true,
      contentPadding: const EdgeInsets.all(16),
      filled: true,
      fillColor: Colors.white,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: AppValues.smallBorderRadius,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: AppValues.smallBorderRadius,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: AppValues.smallBorderRadius,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: AppValues.smallBorderRadius,
      ),
    ),
  );
}
