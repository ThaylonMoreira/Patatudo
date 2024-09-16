import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';

import '../extensions/extensions.dart';

/// Print message in debug console when is debug mode
void dprint(Object? message,
    {bool? warning, bool? error, String name = 'log'}) {
  if (kDebugMode) {
    if (kIsWeb) {
      if (warning.isNotNull && warning!) {
        print('\x1B[33m[$name] $message\x1B[0m');
      } else if (error.isNotNull && error!) {
        print('\x1B[31m[$name] $message\x1B[0m');
      } else {
        print('\x1B[36m[$name] $message\x1B[0m');
      }
    } else {
      if (warning.isNotNull && warning!) {
        log('\x1B[33m$message\x1B[0m', name: name);
      } else if (error.isNotNull && error!) {
        log('\x1B[31m$message\x1B[0m', name: name);
      } else {
        log('\x1B[36m$message\x1B[0m', name: name);
      }
    }
  }
}

/// Waits for a time in seconds defined in [duration]
///
/// Example:
/// ```dart
/// sleep(2);
/// sleep(0.5);
/// ```
Future<void> sleep(num duration) async {
  await Future.delayed(Duration(milliseconds: (duration * 1000).toInt()));
}

Future<T> runAndCaptureAsyncStacks<T>(Future<T> Function() callback) {
  final Completer<T> completer = Completer<T>();
  Chain.capture(
    () => callback(),
    onError: (error, chain) => completer.completeError(error, chain.toTrace()),
  ).then((value) => completer.complete(value));
  return completer.future;
}
