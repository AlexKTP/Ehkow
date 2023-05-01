import 'package:ehkow/business/data/deck_repository.dart';

class DeckService {
  static Future<List<dynamic>> fetchDeckList() async {
    final repository = DeckRepository();

    return repository.getAll();
  }
}
