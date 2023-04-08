import 'status.dart';

class FlashCard {

  final int? id;
  final String originalContent;
  final String translatedContent;
  late final int deckId;
  final Status? toSynchronize;


  FlashCard({
    this.id,
    required this.originalContent,
    required this.translatedContent,
    required this.deckId,
    this.toSynchronize
  });

  FlashCard.fromMap(Map<String, dynamic> data)
      :
        id = data['id'],
        originalContent = data['original'],
        translatedContent = data['translated'],
        deckId = data['deck_id'],
        toSynchronize = data['to_synchronize'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'original': originalContent,
      'translated': translatedContent,
      'deck_id': deckId,
      'to_synchronize': toSynchronize
    };
  }
}