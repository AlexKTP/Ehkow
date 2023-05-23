import 'package:ehkow/business/data/flashcard_repository.dart';
import 'package:ehkow/business/model/exceptions/flashcard_not_found.dart';

class FlashCardService {

  Future<dynamic> getFlashCard(int flashCardId) {
    final repository = FlashCardRepository();
    try{
      return repository.findById(flashCardId);
    } on FlashCardNotFound {
      throw FlashCardNotFound(flashCardId);
    }
  }

    Future<dynamic> getFlashCardByDeckId(int deckId) {
      final repository = FlashCardRepository();
      return repository.getAllByDeckId(deckId);
  }
}
