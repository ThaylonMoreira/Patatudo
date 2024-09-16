import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/modular/bind_config.dart';
import '../../core/services/firestore_service.dart';
import 'data/services/firestore_pet_repository.dart';
import 'domain/bloc/pet_list_bloc.dart';
import 'domain/events/pet_list_event.dart';
import 'domain/repositories/pet_repository.dart';
import 'ui/home_page.dart';
import 'ui/pages/pet/pet_detail_page.dart';
import 'ui/pages/pet/pet_list_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addInstance<FirebaseFirestore>(FirebaseFirestore.instance);
    i.addLazySingleton<FirestoreService>(FirestoreService.new);

    i.addLazySingleton<PetRepository>(FirestorePetRepository.new);

    i.addLazySingleton<PetListBloc>(PetListBloc.new, config: blocBindConfig());

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: Modular.get<PetListBloc>()..add(const PetFetched()),
          )
        ],
        child: const HomePage(),
      ),
    );
    r.child(
      '/pet-list',
      child: (context) => PetListPage(pets: r.args.data),
    );
    r.child(
      '/pet-detail',
      child: (context) => PetDetailPage(pet: r.args.data),
    );
  }
}
