import 'dart:developer';

import 'package:flutter/foundation.dart';

logMessage(String message, {String? tag}) {
  if (!kDebugMode) return;
  log('${tag ?? 'WoAuto'}: $message');
}
