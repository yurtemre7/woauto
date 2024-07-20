import 'dart:developer';

import 'package:flutter/foundation.dart';

void logMessage(String message, {String? tag}) {
  if (!kDebugMode) return;
  log('${tag ?? 'WoAuto'}: $message');
}
