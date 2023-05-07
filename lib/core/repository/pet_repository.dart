import 'package:adope/constant/app_constant.dart';
import 'package:adope/core/model/hive_model.dart';
import 'package:adope/core/repository/ipet_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IPetRepository)
class PetRepository extends IPetRepository {
  final Box<PetModel> box;

  PetRepository(this.box);

  @override
  Future<void> addPet(PetModel petModel) async {
    await box.add(petModel);
  }

  @override
  Future<void> initializePets() async {
    bool isLocalListEmpty = box.values.isEmpty;
    if (isLocalListEmpty) {
      await box.addAll(petsList);
    }
  }

  @override
  Future<List<PetModel>> getPets({
    required int currentPage,
    String? searchPhrase,
  }) async {
    //For pagination purpose.
    List<PetModel> allPets = box.values.toList();
    if (searchPhrase != null) {
      String formattedStringPhrase = searchPhrase.toLowerCase().trim();
      allPets = box.values
          .where(
            (element) =>
                element.name.toLowerCase().contains(formattedStringPhrase) ||
                element.age.toString().contains(formattedStringPhrase) ||
                element.price.toString().contains(formattedStringPhrase) ||
                element.gender.name == formattedStringPhrase,
          )
          .toList();
    }
    int elementsOnSinglePage = 10;
    int listStart = currentPage * elementsOnSinglePage;
    if (listStart > allPets.length) {
      return [];
    }

    int listEnd = (currentPage + 1) * elementsOnSinglePage;
    if (listEnd > allPets.length) {
      listEnd = allPets.length;
    }

    return allPets.sublist(listStart, listEnd);
  }

  @override
  Future<void> adoptPet(PetModel petModel) async {
    await box.put(
      petModel.key,
      PetModel(
        id: petModel.id,
        name: petModel.name,
        age: petModel.age,
        imagePath: petModel.imagePath,
        isAdopted: true,
        price: petModel.price,
        gender: petModel.gender,
        adoptedDate: DateTime.now(),
      ),
    );
  }

  @override
  Future<List<PetModel>> getAdoptionHistory() async {
    List<PetModel> adoptedList = box.values.where((element) => element.isAdopted).toList();
    adoptedList.sort((a, b) => a.adoptedDate!.compareTo(b.adoptedDate!));
    return adoptedList;
  }
}
