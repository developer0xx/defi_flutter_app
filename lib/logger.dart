import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';

final logger = Logger();

void logError(String message, [dynamic error, StackTrace? stackTrace]) async {
  logger.e(message, error, stackTrace);
  await FirebaseCrashlytics.instance.recordError(error, stackTrace);
  await FirebaseCrashlytics.instance.sendUnsentReports();
}
