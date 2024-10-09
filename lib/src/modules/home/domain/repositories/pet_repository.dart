import '../entities/pet.dart';
import '../states/pet_edit_state.dart';
import '../states/pet_list_state.dart';

abstract interface class PetRepository {
  Stream<PetListState> fetch();

  Future<PetEditState> create(Pet pet);

  Future<PetEditState> update(Pet pet, Pet oldPet);

  // Future<PetDeleteState> delete(Pet pet);
}
