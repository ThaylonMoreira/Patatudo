import 'package:flutter/material.dart';

void disposeAll(List<ChangeNotifier> controllers) {
  for (final ChangeNotifier controller in controllers) {
    controller.dispose();
  }
}
