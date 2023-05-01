import 'package:ehkow/business/data/flash_card_helper.dart';
import 'package:ehkow/business/model/exceptions/deck_not_found_exception.dart';
import 'package:ehkow/business/model/exceptions/flashcard_not_found.dart';

import '../model/flashcard.dart';
import 'repository.dart';

class FlashCardRepository implements Repository<dynamic, dynamic> {
  final FlashCardHelper _localDataSource = FlashCardHelper();

  @override
  Future<int> create(entity) {
    return _localDataSource.createFlashCard(
        (entity as FlashCard).originalContent,
        (entity).translatedContent,
        entity.deckId);
  }

  @override
  Future<FlashCard> findById(id) {
    try {
      Future<FlashCard> result = _localDataSource.findById(id as int);
      return result;
    } on FlashCardNotFound {
      throw FlashCardNotFound(id as int);
    }
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
    try {
      Future<List<FlashCard>> response =
          _localDataSource.getFlashCardsByDeckId(id as String);
      return response;
    } on DeckNotFoundException {
      throw DeckNotFoundException();
    }
  }

  @override
  Future<int> update(entity) {
    return _localDataSource.updateFlashCard((entity as FlashCard).id!,
        (entity).originalContent, (entity).translatedContent);
  }

  Future<int?> rowCount() {
    return _localDataSource.getFlashCardCount();
  }
}
