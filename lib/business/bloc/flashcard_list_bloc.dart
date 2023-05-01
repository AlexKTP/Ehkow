import 'package:ehkow/business/model/exceptions/deck_not_found_exception.dart';
import 'package:ehkow/business/services/flashcard_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/flashcard.dart';

class FetchFlashCardsEvent {}

abstract class FlashCardsState {}

class FlashCardsInitialState extends FlashCardsState {}

class FlashCardsLoadingState extends FlashCardsState {}

class FlashCardsSuccessState extends FlashCardsState {
  final List<FlashCard> flashCardList;

  FlashCardsSuccessState({required this.flashCardList});
}

class FlashCardsErrorState extends FlashCardsState {
  final String errorMessage;

  FlashCardsErrorState({required this.errorMessage});
}

class FlashCardListBloc extends Bloc<FetchFlashCardsEvent, FlashCardsState> {
  int? deckId;

  FlashCardListBloc(int this.deckId) : super(FlashCardsInitialState()) {
    on<FetchFlashCardsEvent>((event, emit) async {
      emit(FlashCardsLoadingState());

      try {
        final cardList = await FlashCardService.fetchCardsByDeckId(deckId!);
        emit(
            FlashCardsSuccessState(flashCardList: cardList as List<FlashCard>));
      } catch (e) {
        if (e is DeckNotFoundException)
          emit(FlashCardsErrorState(errorMessage: e.message.toString()));
      }
    });
  }
}
