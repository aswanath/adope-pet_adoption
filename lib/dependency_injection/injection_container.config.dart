// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:adope/core/model/hive_model.dart' as _i4;
import 'package:adope/core/repository/ipet_repository.dart' as _i5;
import 'package:adope/core/repository/pet_repository.dart' as _i6;
import 'package:adope/dependency_injection/module/app_module.dart' as _i8;
import 'package:adope/modules/home/bloc/home_bloc.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/hive_flutter.dart' as _i3;
import 'package:injectable/injectable.dart'
    as _i2; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i3.Box<_i4.PetModel>>(
      () => appModule.petModel,
      preResolve: true,
    );
    gh.factory<_i5.IPetRepository>(
        () => _i6.PetRepository(gh<_i3.Box<_i4.PetModel>>()));
    gh.factory<_i7.HomeBloc>(() => _i7.HomeBloc(gh<_i5.IPetRepository>()));
    return this;
  }
}

class _$AppModule extends _i8.AppModule {}
