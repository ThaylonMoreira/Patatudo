import 'package:equatable/equatable.dart';

import '../entities/pet.dart';

enum PetEditStatus { initial, typing, submitting, success, failure }

final class PetEditState extends Equatable {
  const PetEditState({required this.pet, required this.status});

  const PetEditState.initial()
      : pet = const Pet.empty(),
        status = PetEditStatus.initial;

  final Pet pet;
  final PetEditStatus status;

  @override
  List<Object> get props => [pet, status];

  PetEditState copyWith({
    Pet? pet,
    PetEditStatus? status,
  }) {
    return PetEditState(
      pet: pet ?? this.pet,
      status: status ?? this.status,
    );
  }
}

extension PetEditStateValidatorExtension on PetEditState {
  String? get nameValidator {
    if (pet.name.isEmpty) {
      return 'O nome do pet não pode ser nulo';
    }
    return null;
  }

  bool get formValidator =>
      [nameValidator].every((validator) => validator == null);
}
