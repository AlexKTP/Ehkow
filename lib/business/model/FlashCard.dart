class FlashCard {

  int id;
  String originalContent;
  String translatedContent;


  FlashCard({
    required this.id,
    required this.originalContent,
    required this.translatedContent,
  });

  FlashCard.fromMap(Map<String, dynamic> data)
      :
        id = data['id'],
        originalContent = data['original'],
        translatedContent = data['translated'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'original': originalContent,
      'translated': translatedContent
    };
  }
}