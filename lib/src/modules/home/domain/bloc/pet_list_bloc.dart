import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/pet_list_event.dart';
import '../repositories/pet_repository.dart';
import '../states/pet_list_state.dart';

class PetListBloc extends Bloc<PetListEvent, PetListState> {
  PetListBloc({required this.repository}) : super(const PetListInitial()) {
    on<PetFetched>(_onPetFetched);
  }

  final PetRepository repository;

  FutureOr<void> _onPetFetched(
      PetFetched event, Emitter<PetListState> emit) async {
    await emit.forEach(
      repository.fetch(),
      onData: (pets) => pets,
      onError: (error, _) => (error as PetListLoadFailure),
    );
  }
}
