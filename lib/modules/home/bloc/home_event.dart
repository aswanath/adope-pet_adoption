part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class InitializeHome extends HomeEvent {}

class ScrollToPageEnd extends HomeEvent {
  final String? searchPhrase;

  ScrollToPageEnd({this.searchPhrase});
}

class HomeSearched extends HomeEvent {
  final String searchPhrase;

  HomeSearched({required this.searchPhrase});
}

class AdoptClicked extends HomeEvent {
  final PetModel petModel;

  AdoptClicked({required this.petModel});
}

class FetchHistory extends HomeEvent {}
