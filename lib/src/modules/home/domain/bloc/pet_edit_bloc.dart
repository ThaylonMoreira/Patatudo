import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/pet_edit_event.dart';
import '../repositories/pet_repository.dart';
import '../states/pet_edit_state.dart';

class PetEditBloc extends Bloc<PetEditEvent, PetEditState> {
  PetEditBloc({required this.repository})
      : super(const PetEditState.initial()) {
    on<PetCreateStarted>(_onPetCreateStarted);
    on<PetUpdateStarted>(_onPetUpdateStarted);
    on<PetNameChanged>(_onPetNameChanged);
    on<PetTypeChanged>(_onPetTypeChanged);
    on<PetPhotoChanged>(_onPetPhotoChanged);
    on<PetBreedChanged>(_onPetBreedChanged);
    on<PetAgeChanged>(_onPetAgeChanged);
    on<PetWeightChanged>(_onPetWeightChanged);
    on<PetBirthdayChanged>(_onPetBirthdayChanged);
    on<PetGenderChanged>(_onPetGenderChanged);
    on<PetNotesChanged>(_onPetNotesChanged);
    on<PetEditSubmitted>(_onPetEditSubmitted);
  }

  final PetRepository repository;

  FutureOr<void> _onPetCreateStarted(
      PetCreateStarted event, Emitter<PetEditState> emit) {
    emit(const PetEditState.initial());
  }

  FutureOr<void> _onPetUpdateStarted(
      PetUpdateStarted event, Emitter<PetEditState> emit) {
    emit(PetEditState(pet: event.pet, status: PetEditStatus.initial));
  }

  FutureOr<void> _onPetNameChanged(
      PetNameChanged event, Emitter<PetEditState> emit) {
    emit(state.copyWith(
      pet: state.pet.copyWith(name: event.value),
      status: PetEditStatus.typing,
    ));
  }

  FutureOr<void> _onPetTypeChanged(
      PetTypeChanged event, Emitter<PetEditState> emit) {
    emit(state.copyWith(
      pet: state.pet.copyWith(type: event.type),
      status: PetEditStatus.typing,
    ));
  }

  FutureOr<void> _onPetPhotoChanged(
      PetPhotoChanged event, Emitter<PetEditState> emit) {
    emit(state.copyWith(
      pet: state.pet.copyWith(photo: event.value),
      status: PetEditStatus.typing,
    ));
  }

  FutureOr<void> _onPetBreedChanged(
      PetBreedChanged event, Emitter<PetEditState> emit) {
    emit(state.copyWith(
      pet: state.pet.copyWith(breed: event.value),
      status: PetEditStatus.typing,
    ));
  }

  FutureOr<void> _onPetAgeChanged(
      PetAgeChanged event, Emitter<PetEditState> emit) {
    emit(state.copyWith(
      pet: state.pet.copyWith(age: event.value),
      status: PetEditStatus.typing,
    ));
  }

  FutureOr<void> _onPetWeightChanged(
      PetWeightChanged event, Emitter<PetEditState> emit) {
    emit(state.copyWith(
      pet: state.pet.copyWith(weight: event.value),
      status: PetEditStatus.typing,
    ));
  }

  FutureOr<void> _onPetBirthdayChanged(
      PetBirthdayChanged event, Emitter<PetEditState> emit) {
    emit(state.copyWith(
      pet: state.pet.copyWith(birthday: event.value),
      status: PetEditStatus.typing,
    ));
  }

  FutureOr<void> _onPetGenderChanged(
      PetGenderChanged event, Emitter<PetEditState> emit) {
    emit(state.copyWith(
      pet: state.pet.copyWith(gender: event.value),
      status: PetEditStatus.typing,
    ));
  }

  FutureOr<void> _onPetNotesChanged(
      PetNotesChanged event, Emitter<PetEditState> emit) {
    emit(state.copyWith(
      pet: state.pet.copyWith(notes: event.value),
      status: PetEditStatus.typing,
    ));
  }

  FutureOr<void> _onPetEditSubmitted(
      PetEditSubmitted event, Emitter<PetEditState> emit) async {
    emit(state.copyWith(status: PetEditStatus.submitting));
    final petState = state.pet.id.isEmpty
        ? await repository.create(state.pet)
        : await repository.update(state.pet, event.oldPet); //
    emit(petState);
  }
}
