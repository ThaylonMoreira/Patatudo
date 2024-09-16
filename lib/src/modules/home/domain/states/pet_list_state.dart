import 'package:equatable/equatable.dart';

import '../entities/pet.dart';

sealed class PetListState extends Equatable {
  const PetListState();

  @override
  List<Object> get props => [];
}

final class PetListInitial extends PetListState {
  const PetListInitial();
}

final class PetListLoading extends PetListState {
  const PetListLoading();
}

final class PetListLoadEmpty extends PetListState {
  const PetListLoadEmpty();
}

final class PetListLoadSuccess extends PetListState {
  const PetListLoadSuccess({required this.pets});

  final List<Pet> pets;

  @override
  List<Object> get props => [pets];

  PetListLoadSuccess copyWith({
    List<Pet>? pets,
  }) {
    return PetListLoadSuccess(
      pets: pets ?? this.pets,
    );
  }
}

final class PetListLoadFailure extends PetListState {
  const PetListLoadFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
