import 'package:adope/core/model/hive_model.dart';
import 'package:adope/dependency_injection/injection_container.config.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

bool testing = false;
final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

Future<void> setupLocator() async {
  await Hive.initFlutter();
  Hive.registerAdapter<PetModel>(PetModelAdapter());
  Hive.registerAdapter<Gender>(GenderAdapter());
}
