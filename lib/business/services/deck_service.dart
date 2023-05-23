import 'package:ehkow/business/data/deck_repository.dart';
import 'package:ehkow/business/model/deck.dart';

class DeckService {

  Future<List<dynamic>> getDeckList() => fetchDeckList();
  static Future<List<dynamic>> fetchDeckList() async {
    final repository = DeckRepository();

    return repository.getAll();
  }

  Future<dynamic> getDeckById(int deckId) => fetchDeckById(deckId);
  static Future<dynamic> fetchDeckById(int deckId) async {
    final repository = DeckRepository();
    return repository.findById(deckId);
  }

  Future<void> deleteDeck(Deck deck) => deleteCascadeDeck(deck);
  static Future<void> deleteCascadeDeck(Deck deck) async {
    final repository = DeckRepository();
    return repository.delete(deck);
  }
}
