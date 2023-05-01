import 'package:ehkow/business/model/exceptions/flashcard_not_found.dart';
import 'package:ehkow/business/services/flashcard_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/flashcard.dart';

class FetchFlashCardEvent {}

abstract class FlashCardState {}

class FlashCardInitialState extends FlashCardState {}

class FlashCardLoadingState extends FlashCardState {}

class FlashCardSuccessState extends FlashCardState {
  final FlashCard flashCard;

  FlashCardSuccessState({required this.flashCard});
}

class FlashCardErrorState extends FlashCardState {
  final String errorMessage;

  FlashCardErrorState({required this.errorMessage});
}

class FlashCardBloc extends Bloc<FetchFlashCardEvent, FlashCardState> {
  int? flashCardId;

  FlashCardBloc(int this.flashCardId) : super(FlashCardInitialState()) {
    on<FetchFlashCardEvent>((event, emit) async {
      emit(FlashCardLoadingState());

      try {
        final card = await FlashCardService.fetchFlashCard(flashCardId!);
        emit(FlashCardSuccessState(flashCard: card as FlashCard));
      } catch (e) {
        if (e is FlashCardNotFound)
          emit(FlashCardErrorState(errorMessage: e.message.toString()));
      }
    });
  }
}
