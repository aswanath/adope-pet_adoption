import 'dart:async';

import 'package:adope/core/model/hive_model.dart';
import 'package:adope/core/repository/ipet_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IPetRepository petRepository;
  int currentPage = 0;
  int pageSize = 1;
  List<PetModel> pets = [];

  HomeBloc(this.petRepository) : super(HomeInitial()) {
    on<InitializeHome>(_onInitializeHome);
    on<ScrollToPageEnd>(_onScrollToPageEnd);
    on<HomeSearched>(_onHomeSearched);
    on<AdoptClicked>(_onAdoptClicked);
    on<FetchHistory>(_onFetchHistory);
  }

  FutureOr<void> _onFetchHistory(FetchHistory event, emit) async {
    List<PetModel> history = await petRepository.getAdoptionHistory();
    emit(FetchedAdoptionHistory(pets: history));
  }

  FutureOr<void> _onAdoptClicked(AdoptClicked event, emit) async {
    await petRepository.adoptPet(event.petModel);
    emit(AdoptedSuccessfully());
  }

  FutureOr<void> _onHomeSearched(HomeSearched event, emit) async {
    currentPage = 0;
    pets = await petRepository.getPets(
      searchPhrase: event.searchPhrase,
      currentPage: currentPage,
    );
    emit(PetsListUpdated(pets: pets));
  }

  FutureOr<void> _onScrollToPageEnd(ScrollToPageEnd event, emit) async {
    if (currentPage < pageSize) {
      emit(PageLoading());
      currentPage++;
      List<PetModel> newPetsList = await petRepository.getPets(
        currentPage: currentPage,
        searchPhrase: event.searchPhrase,
      );
      pets += newPetsList;
      //To showcase delay in fetching
      await Future.delayed(const Duration(seconds: 1));
      emit(PetsListUpdated(pets: pets));
    }
  }

  FutureOr<void> _onInitializeHome(InitializeHome event, emit) async {
    await petRepository.initializePets();
    pets = await petRepository.getPets(currentPage: 0);
    emit(PetsListUpdated(pets: pets));
  }
}
