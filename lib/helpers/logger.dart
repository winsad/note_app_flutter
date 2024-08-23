import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

class Logger {
  static void d(String message) {
    if (kDebugMode) dev.log(message, name: 'LOG D');
  }

  static void e(String message) {
    if (kDebugMode) dev.log(message, name: 'LOG E', error: message);
  }
}
