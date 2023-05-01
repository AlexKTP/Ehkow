import 'package:ehkow/business/constants/constants.dart';

class FlashCardNotFound implements Exception {
  final int id;

  FlashCardNotFound(this.id);

  final String message = Constants.deck_not_found;
}
