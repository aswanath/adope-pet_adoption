part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class PetsListUpdated extends HomeState {
  final List<PetModel> pets;

  PetsListUpdated({required this.pets});
}

class PageLoading extends HomeState {}

class AdoptedSuccessfully extends HomeState {}

class FetchedAdoptionHistory extends HomeState {
  final List<PetModel> pets;

  FetchedAdoptionHistory({required this.pets});
}
