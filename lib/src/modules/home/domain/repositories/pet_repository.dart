import '../states/pet_list_state.dart';

abstract interface class PetRepository {
  Stream<PetListState> fetch();
}
