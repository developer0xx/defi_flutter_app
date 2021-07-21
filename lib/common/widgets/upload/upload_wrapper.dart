import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/state/upload/upload_state.dart';

enum FileUploadWrapperShape { rectangular, circular }

class FileUploadWrapper extends HookWidget {
  final UploadState state;
  final Widget child;
  final double height;
  final double width;
  final FileUploadWrapperShape shape;

  const FileUploadWrapper({
    required this.state,
    required this.child,
    this.shape = FileUploadWrapperShape.circular,
    this.height = 300,
    this.width = 300,
  });

  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(shape == FileUploadWrapperShape.circular ? width * 2 : 0),
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              child,
              if (state.mode == UploadMode.uploading) _buildImageLoader(),
              if (state.mode == UploadMode.error) _buildRetryButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageLoader() {
    return Container(
      color: AppColors.textPrimary.withOpacity(0.95),
      child: Center(
        child: SpinKitThreeBounce(
          color: AppColors.primary,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.35),
      child: Center(
        child: GestureDetector(
          onTap: () => state.onRetryPressed(),
          child: Icon(
            Icons.refresh,
          ),
        ),
      ),
    );
  }
}
