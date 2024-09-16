import 'package:equatable/equatable.dart';

abstract base class PetListEvent extends Equatable {
  const PetListEvent();

  @override
  List<Object> get props => [];
}

final class PetFetched extends PetListEvent {
  const PetFetched();
}
