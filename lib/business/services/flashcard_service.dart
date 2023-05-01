import 'package:ehkow/business/data/flashcard_repository.dart';
import 'package:ehkow/business/model/exceptions/flashcard_not_found.dart';

class FlashCardService {

  Future<dynamic> fetchFlashCardFunction(int flashCardId) => fetchFlashCard(flashCardId);
  static Future<dynamic> fetchFlashCard(int flashCardId) async {
    final repository = FlashCardRepository();
    try{
     return repository.findById(flashCardId);
    } on FlashCardNotFound {
      throw FlashCardNotFound(flashCardId);
    }

  }

  Future<dynamic> fetchFlashCardsByDeckId(int deckId) => fetchCardsByDeckId(deckId);
  static Future<List<dynamic>> fetchCardsByDeckId(int deckId) async {
    final repository = FlashCardRepository();
    return repository.getAllByDeckId(deckId);
  }
}
