import 'package:ehkow/business/data/flashcard_repository.dart';

class FlashCardService {
  static Future<dynamic> fetchFlashCard(int flashCardId) async {
    final repository = FlashCardRepository();
    return repository.findById(flashCardId);
  }

  static Future<List<dynamic>> fetchCardsByDeckId(int deckId) async {
    final repository = FlashCardRepository();
    return repository.getAllByDeckId(deckId);
  }
}
