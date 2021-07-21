import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/state/submit/use_submit_state.dart';
import 'package:sapiency_app/util/hook/use_stream_subscription.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class SubmitWrapper<E> extends HookWidget {
  final SubmitState<E> state;
  final Widget child;

  SubmitWrapper({
    required this.state,
    required this.child,
  });

  Widget build(BuildContext context) {
    // show retry popup when error
    _useErrorPopup(context);

    return WillPopScope(
      onWillPop: () async => !state.isSubmitInProgress,
      child: Stack(
        children: [
          child,
          if (state.isSubmitInProgress)
            Container(
              color: AppColors.textPrimary.withOpacity(0.95),
              child: Center(
                child: SpinKitThreeBounce(
                  color: AppColors.primary,
                  size: 40,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _useErrorPopup(BuildContext context) {
    useStreamSubscription<Null>(
      state.unknownErrorStream,
      (error) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(context.strings.errorDialog.title),
            content: Text(context.strings.errorDialog.subtitle),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  context.strings.common.cancel,
                  style: AppText.label.copyWith(color: AppColors.light),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  state.onSubmitPressed();
                },
                child: Text(
                  context.strings.errorDialog.button,
                  style: AppText.label.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
