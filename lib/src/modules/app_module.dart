import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/services/firestore_service.dart';
import 'auth/auth_module.dart';
import 'home/home_module.dart';
import 'splash_page.dart';
import 'auth/domain/states/auth_state.dart';

class AppModule extends Module {
  final AuthState initialAuthState;

  AppModule({required this.initialAuthState});

  @override
  void binds(Injector i) {
    i.addInstance<FirebaseFirestore>(FirebaseFirestore.instance);
    i.addLazySingleton<FirestoreService>(FirestoreService.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (context) => SplashPage(initialAuthState: initialAuthState));
    r.module('/auth', module: AuthModule());
    r.module('/home', module: HomeModule());
    super.routes(r);
  }
}
