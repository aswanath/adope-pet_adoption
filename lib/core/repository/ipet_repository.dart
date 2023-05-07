import 'package:adope/core/model/hive_model.dart';

abstract class IPetRepository {
  Future<void> addPet(PetModel petModel);

  Future<void> adoptPet(PetModel petModel);

  Future<void> initializePets();

  Future<List<PetModel>> getPets({
    required int currentPage,
    String? searchPhrase,
  });

  Future<List<PetModel>> getAdoptionHistory();
}
