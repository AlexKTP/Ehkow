import 'package:ehkow/business/model/deck.dart';
import 'package:ehkow/business/services/deck_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchDecksEvent {}

abstract class DecksState {}

class DecksInitialState extends DecksState {}

class DecksLoadingState extends DecksState {}

class DecksSuccessState extends DecksState {
  final List<Deck> deckList;

  DecksSuccessState({required this.deckList});
}

class DecksErrorState extends DecksState {
  final String errorMessage;

  DecksErrorState({required this.errorMessage});
}

class DeckListBloc extends Bloc<FetchDecksEvent, DecksState> {
  int? deckId;

  DeckListBloc() : super(DecksInitialState()) {
    on<FetchDecksEvent>((event, emit) async {
      emit(DecksLoadingState());

      try {
        final deckList = await DeckService.fetchDeckList();
        emit(DecksSuccessState(deckList: deckList as List<Deck>));
      } catch (e) {
        emit(DecksErrorState(errorMessage: e.toString()));
      }
    });
  }
}
