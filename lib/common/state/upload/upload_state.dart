import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/service/storage/storage_service.dart';

import '../../../logger.dart';

enum UploadMode { basic, uploading, error }

class UploadState {
  final bool isInProgress;
  final File? pickedFile;
  final String? pickedUrl;
  final Function() onUploadPressed;
  final Function() onRetryPressed;
  final Function() onResetState;

  const UploadState({
    required this.isInProgress,
    required this.pickedFile,
    required this.pickedUrl,
    required this.onUploadPressed,
    required this.onRetryPressed,
    required this.onResetState,
  });

  UploadMode get mode {
    if (pickedFile == null && !isInProgress)
      return UploadMode.basic;
    else if (pickedFile != null && isInProgress)
      return UploadMode.uploading;
    else if (pickedFile != null && !isInProgress)
      return UploadMode.basic;
    else
      return UploadMode.error;
  }
}

UploadState useUploadState({
  required String uploadPrefix,
  required Future<File?> Function() pickFile,
  Function(String url)? afterUpload,
  String? initialUrl,
}) {
  final storageService = useInjected<StorageService>();

  final pickedFileState = useState<File?>(null);
  final uploadedUrlState = useState<String?>(initialUrl);
  final isInProgressState = useState<bool>(false);

  Future upload() async {
    try {
      isInProgressState.value = true;
      uploadedUrlState.value = await storageService.uploadFile(
        pickedFileState.value!, // note: file must be already picked here
        prefix: uploadPrefix,
      );
      isInProgressState.value = false;
    } catch (error, stacktrace) {
      isInProgressState.value = false;
      logger.w('Upload image error: ', error, stacktrace);
    }
  }

  return UploadState(
    isInProgress: isInProgressState.value,
    pickedFile: pickedFileState.value,
    pickedUrl: uploadedUrlState.value,
    onResetState: () {
      uploadedUrlState.value = null;
      pickedFileState.value = null;
      isInProgressState.value = false;
    },
    onUploadPressed: () async {
      final result = await pickFile();
      if (result != null) {
        pickedFileState.value = result;
        await upload();
      }
      if (afterUpload != null) afterUpload(uploadedUrlState.value!);
    },
    onRetryPressed: () async => await upload(), // note: file must be already picked here
  );
}
