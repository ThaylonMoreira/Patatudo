import 'package:equatable/equatable.dart';

import '../entities/pet.dart';
import '../entities/pet_type.dart';

abstract base class PetEditEvent extends Equatable {
  const PetEditEvent();

  @override
  List<Object> get props => [];
}

final class PetCreateStarted extends PetEditEvent {
  const PetCreateStarted();
}

final class PetUpdateStarted extends PetEditEvent {
  const PetUpdateStarted(this.pet);

  final Pet pet;

  @override
  List<Object> get props => [pet];
}

// Fields
abstract base class PetFieldChanged extends PetEditEvent {
  const PetFieldChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

final class PetNameChanged extends PetFieldChanged {
  const PetNameChanged(super.value);
}

final class PetPhotoChanged extends PetFieldChanged {
  const PetPhotoChanged(super.value);
}

final class PetBreedChanged extends PetFieldChanged {
  const PetBreedChanged(super.value);
}

final class PetAgeChanged extends PetFieldChanged {
  const PetAgeChanged(super.value);
}

final class PetWeightChanged extends PetFieldChanged {
  const PetWeightChanged(super.value);
}

final class PetBirthdayChanged extends PetFieldChanged {
  const PetBirthdayChanged(super.value);
}

final class PetGenderChanged extends PetFieldChanged {
  const PetGenderChanged(super.value);
}

final class PetNotesChanged extends PetFieldChanged {
  const PetNotesChanged(super.value);
}
// End Fields

final class PetTypeChanged extends PetEditEvent {
  const PetTypeChanged(this.type);

  final PetType type;

  @override
  List<Object> get props => [type];
}

final class PetEditSubmitted extends PetEditEvent {
  const PetEditSubmitted(this.oldPet);

  final Pet oldPet;

  @override
  List<Object> get props => [oldPet];
}
