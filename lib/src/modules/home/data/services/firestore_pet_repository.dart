import 'package:patatudo/src/modules/home/data/adapters/firestore_adapter.dart';

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
      onFailure: (failure) {
        throw const PetListLoadFailure(
            message: 'Erro ao obter os dados dos pets cadastrados.');
      },
    );
  }
}
