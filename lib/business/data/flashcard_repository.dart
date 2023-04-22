import '../model/flashcard.dart';
import 'database_helper.dart';
import 'repository.dart';

class FlashCardRepository implements Repository<dynamic, dynamic> {

  final DatabaseHelper _localDataSource = DatabaseHelper();

  @override
  Future<int> create(entity) {
    return _localDataSource.createFlashCard(
        (entity as FlashCard).originalContent, (entity).translatedContent, entity.deckId);
  }

  @override
  Future<FlashCard> findById(id) {
    return _localDataSource.findById(id as int);
  }

  @override
  Future<void> delete(entity) {
    return _localDataSource.deleteFlashCard((entity).id as int);
  }

  @override
  Future<List<FlashCard>> getAll() {
    return _localDataSource.getFlashCards();
  }

@override
  Future<List<dynamic>> getAllByDeckId(id) {
  return _localDataSource.getFlashCardsByDeckId(id as String);
}

  @override
  Future<int> update(entity) {
    return _localDataSource.updateFlashCard(
        (entity as FlashCard).id!, (entity).originalContent, (entity).translatedContent);
  }

  Future<int?> rowCount(){
    return _localDataSource.getFlashCardCount();
  }


}