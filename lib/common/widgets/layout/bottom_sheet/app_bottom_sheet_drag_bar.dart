import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';

class AppBottomSheetDragBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 46,
        height: 3,
        decoration: ShapeDecoration(
          color: AppColors.lighter,
          shape: StadiumBorder(),
        ),
      ),
    );
  }
}
