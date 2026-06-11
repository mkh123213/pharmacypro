import 'package:flutter/foundation.dart';
import 'crash_reporter.dart';

class ErrorLogger {
  static void log(String message, [dynamic error, StackTrace? stack]) {
    if (kDebugMode) {
      debugPrint('ERROR: $message');
      if (error != null) debugPrint('Exception: $error');
      if (stack != null) debugPrint('StackTrace: $stack');
    }
    
    CrashReporter.log(message);
    if (error != null) {
      CrashReporter.recordError(error, stack);
    }
  }
}
