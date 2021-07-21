import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:sapiency_app/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(
    () => runApp(App()),
    (e, s) => FirebaseCrashlytics.instance.recordError(e, s),
  );
}
