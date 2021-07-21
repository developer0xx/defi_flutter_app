import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:sapiency_app/common/state/submit/use_submit_state.dart';

import '../upload_state.dart';

class UploadWithSubmitState {
  final SubmitState<void> submitState;
  final UploadState uploadState;

  const UploadWithSubmitState({
    required this.submitState,
    required this.uploadState,
  });
}

UploadWithSubmitState useUploadWithSubmitState({
  required String uploadPrefix,
  required Future<File?> Function() pickFile,
  required Future<void> Function(String? url) performSubmit,
  Function(Function() onConfirm)? showConfirmCancelDialog,
  Function()? afterSubmit,
}) {
  final uploadState = useUploadState(uploadPrefix: uploadPrefix, pickFile: pickFile);

  bool shouldShowConfirmDialog = (uploadState.mode == UploadMode.uploading && showConfirmCancelDialog != null);

  final submitState = useSubmitStateSimple<void>(
    performSubmit: () async {
      await performSubmit(uploadState.pickedUrl);
    },
    afterSubmit: (_) => afterSubmit?.call(),
  );

  return UploadWithSubmitState(submitState: submitState, uploadState: uploadState);
}
