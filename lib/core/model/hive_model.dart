import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 0)
class PetModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String imagePath;
  @HiveField(2)
  String name;
  @HiveField(3)
  double age;
  @HiveField(4)
  double price;
  @HiveField(5)
  bool isAdopted;
  @HiveField(6)
  Gender gender;
  @HiveField(7)
  DateTime? adoptedDate;

  PetModel({
    this.id = -1,
    required this.name,
    required this.age,
    required this.imagePath,
    required this.isAdopted,
    required this.price,
    required this.gender,
    this.adoptedDate,
  });
}

@HiveType(typeId: 1)
enum Gender {
  @HiveField(0)
  male(Icons.male, Colors.blue),
  @HiveField(1)
  female(Icons.female, Colors.pink);

  const Gender(this.icon, this.color);

  final IconData icon;
  final Color color;
}
