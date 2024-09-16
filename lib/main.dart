import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/core/state_management/simple_bloc_observer.dart';
import 'src/modules/app_module.dart';
import 'src/modules/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = SimpleBlocObserver();

  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
