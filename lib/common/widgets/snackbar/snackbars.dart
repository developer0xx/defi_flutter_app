import 'package:flutter/material.dart';
import 'package:sapiency_app/common/widgets/snackbar/app_snack_bar.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class SnackBars {
  static showComingSoon(BuildContext context) {
    AppSnackBar.show(context, content: Text(context.strings.snackbar.comingSoon));
  }

  static showCopied(BuildContext context) {
    AppSnackBar.show(context, content: Text(context.strings.snackbar.copied));
  }
}
