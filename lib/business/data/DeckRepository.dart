import 'package:flash_card_flutter/business/model/Deck.dart';

import 'DatabaseHelper.dart';
import 'Repository.dart';

class DeckRepository implements Repository {
  DeckRepository(this._localDataSource);

  final DatabaseHelper _localDataSource;

  @override
  Future<int> create(entity) {
    return _localDataSource.createDeck((entity as Deck).name);
  }

  @override
  Future<Deck> findById(id) {
    return _localDataSource.findDeckById(id);
  }

  @override
  Future<void> delete(entity) {
    return _localDataSource.deleteFlashCard((entity).id);
  }

  @override
  Future<List<Deck>> getAll() {
    return _localDataSource.getAllDecks();
  }

  @override
  Future<List> getAllByDeckId(id) {
    return _localDataSource.getFlashCardsByDeckId(id);
  }

  @override
  Future<int> update(entity) {
    return _localDataSource.updateDeck((entity as Deck).id!, entity.name);
  }
}
