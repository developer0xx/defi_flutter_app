import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_images.dart';

class RahimProfilePicture extends StatelessWidget {
  //TODO delete asap
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: 30,
        width: 30,
        child: Image.asset(
          AppImages.mockRahimProfile,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
