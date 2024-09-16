import 'package:flutter_modular/flutter_modular.dart';

sealed class Find {
  static T i<T extends Object>() {
    return Modular.get<T>();
  }
}
