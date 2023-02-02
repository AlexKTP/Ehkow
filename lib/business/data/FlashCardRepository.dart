import '../model/FlashCard.dart';
import 'DatabaseHelper.dart';
import 'Repository.dart';

class FlashCardRepository implements Repository {

  FlashCardRepository(this._localDataSource);

  final DatabaseHelper _localDataSource;

  @override
  Future<int> create(entity) {
    return _localDataSource.createFlashCard(
        (entity as FlashCard).originalContent, (entity).translatedContent);
  }

  @override
  Future<FlashCard> findById(id) {
    return _localDataSource.findById(id);
  }

  @override
  Future<void> delete(entity) {
    return _localDataSource.deleteFlashCard((entity).id);
  }

  @override
  Future<List<FlashCard>> getAll() {
    return _localDataSource.getFlashCards();
  }

  @override
  Future<int> update(entity) {
    return _localDataSource.updateFlashCard(
        (entity as FlashCard).id, (entity).originalContent, (entity).translatedContent);
  }
}