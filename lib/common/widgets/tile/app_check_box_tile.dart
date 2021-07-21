import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';

class AppCheckBoxTile extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;

  const AppCheckBoxTile({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      activeColor: AppColors.primary,
      dense: true,
      title: Text(
        title,
        style: AppText.button.copyWith(color: AppColors.primary),
      ),
      value: value,
      onChanged: (value) => value != null ? onChanged(value) : null,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
