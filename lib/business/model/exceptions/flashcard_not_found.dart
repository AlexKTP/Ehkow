
import 'package:ehkow/business/constants/constants.dart';

class FlashCardNotFound implements Exception {
  final int id;
  final String message = Constants.flashcard_not_found;
  FlashCardNotFound(this.id);
}
