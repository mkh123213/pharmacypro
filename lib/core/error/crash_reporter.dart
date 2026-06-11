import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashReporter {
  static Future<void> initialize() async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  static void log(String message) {
    FirebaseCrashlytics.instance.log(message);
  }

  static void recordError(dynamic exception, StackTrace? stack) {
    FirebaseCrashlytics.instance.recordError(exception, stack);
  }
}
