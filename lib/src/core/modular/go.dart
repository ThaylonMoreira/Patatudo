import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

sealed class Go {
  static Future<void> to(
    String routeName, {
    Object? arguments,
  }) {
    return Modular.to.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  static Future<void> toReplacement(
    String routeName, {
    Object? arguments,
  }) {
    return Modular.to.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  static Future<void> navigate(
    String routeName, {
    Object? arguments,
  }) async {
    await Future.delayed(Duration.zero);
    return Modular.to.navigate(
      routeName,
      arguments: arguments,
    );
  }

  static void pop() {
    Modular.to.pop();
  }

  static void popOutlet(BuildContext context) {
    Navigator.pop(context);
  }
}
