import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/modular/bind_config.dart';
import 'data/services/firebase_auth_service.dart';
import 'domain/bloc/auth_bloc.dart';
import 'domain/services/auth_service.dart';
import 'ui/auth_page.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<FlutterSecureStorage>(FlutterSecureStorage.new);
    i.add<AuthService>(FirebaseAuthService.new);
    i.addSingleton<AuthBloc>(AuthBloc.new, config: blocBindConfig());
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      transition: TransitionType.rightToLeft,
      child: (context) => BlocProvider.value(
        value: Modular.get<AuthBloc>(),
        child: const AuthPage(),
      ),
    );
  }
}
