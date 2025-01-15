import 'package:patatudo/src/modules/home/data/adapters/firestore_adapter.dart';
import 'package:patatudo/src/modules/home/domain/entities/pet.dart';
import 'package:patatudo/src/modules/home/domain/states/pet_edit_state.dart';

import '../../../../core/services/firestore_service.dart';
import '../../domain/repositories/pet_repository.dart';
import '../../domain/states/pet_list_state.dart';

class FirestorePetRepository implements PetRepository {
  const FirestorePetRepository({required this.firestoreService});

  final FirestoreService firestoreService;

  @override
  Stream<PetListState> fetch() {
    return firestoreService.stream<PetListState>(
      collection: 'pets',
      onEmpty: () => const PetListLoadEmpty(),
      onData: (docs) => PetListLoadSuccess(
        pets: docs.map((doc) => FirestoreAdapter.petFromMap(doc)).toList(),
      ),
      queryParams: (query) => query.orderBy('name'),
      onFailure: (failure) {
        throw const PetListLoadFailure(
            message: 'Erro ao obter os dados dos pets cadastrados.');
      },
    );
  }

  @override
  Future<PetEditState> create(Pet pet) async {
    return firestoreService.post<PetEditState>(
      collection: 'pets',
      document: FirestoreAdapter.petToDocument(pet),
      onSuccess: (document) => PetEditState(
        pet: FirestoreAdapter.petFromMap(document),
        status: PetEditStatus.success,
      ),
      onFailure: (failure) => PetEditState(
        pet: pet,
        status: PetEditStatus.failure,
      ),
    );
  }

  @override
  Future<PetEditState> update(Pet pet, Pet oldPet) async {
    return firestoreService.put(
      collection: 'pets',
      id: pet.id,
      document: FirestoreAdapter.petToDocument(pet),
      onSuccess: (document) => PetEditState(
        pet: FirestoreAdapter.petFromMap(document),
        status: PetEditStatus.success,
      ),
      onFailure: (failure) => PetEditState(
        pet: pet,
        status: PetEditStatus.failure,
      ),
    );
  }
}
