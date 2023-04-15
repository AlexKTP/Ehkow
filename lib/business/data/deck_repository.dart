import 'package:ehkow/business/model/deck.dart';

import 'database_helper.dart';
import 'repository.dart';

class DeckRepository implements Repository<dynamic, dynamic>{
  DeckRepository(this._localDataSource);

  final DatabaseHelper _localDataSource;

  @override
  Future<int> create(entity) {
    return _localDataSource.createDeck((entity as Deck).name);
  }

  @override
  Future<Deck> findById(id) {
    return _localDataSource.findDeckById(id as String);
  }

  @override
  Future<void> delete(entity) {
    return _localDataSource.deleteFlashCard((entity).id as int);
  }

  @override
  Future<List<Deck>> getAll() {
    return _localDataSource.getAllDecks();
  }

  @override
  Future<List<dynamic>> getAllByDeckId(id) {
    return _localDataSource.getFlashCardsByDeckId(id as String);
  }

  @override
  Future<int> update(entity) {
    return _localDataSource.updateDeck((entity as Deck).id!, entity.name);
  }
}
