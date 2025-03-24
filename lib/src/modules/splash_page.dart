import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'auth/domain/states/auth_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key, required this.initialAuthState});

  final AuthState initialAuthState;
  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      if (initialAuthState.status == AuthStatus.successAuthenticating) {
        Modular.to.navigate('/home/');
      } else {
        Modular.to.navigate('/auth/');
      }
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
