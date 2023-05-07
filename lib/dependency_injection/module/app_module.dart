import 'package:adope/constant/hive_boxes.dart';
import 'package:adope/core/model/hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @preResolve
  Future<Box<PetModel>> get petModel => Hive.openBox<PetModel>(HiveBoxes.petModelBox);
}
