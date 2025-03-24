import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/core/state_management/simple_bloc_observer.dart';
import 'src/modules/app_module.dart';
import 'src/modules/app_widget.dart';
import 'src/modules/auth/data/services/firebase_auth_service.dart';
import 'src/modules/auth/domain/states/auth_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase
  await Firebase.initializeApp();

  if (kDebugMode) {
    Bloc.observer = SimpleBlocObserver();
  }

  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  const FirebaseAuthService authService =
      FirebaseAuthService(localStorage: secureStorage);

  // Verifica o estado de autenticação do usuário
  final AuthState authState = await authService.checkUserLoggedIn();

  // Passa o estado inicial para o AppModule
  runApp(ModularApp(
    module: AppModule(initialAuthState: authState),
    child: const AppWidget(),
  ));
}
