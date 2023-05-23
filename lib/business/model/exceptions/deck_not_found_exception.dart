import 'package:ehkow/business/constants/constants.dart';

class DeckNotFoundException implements Exception {
  var message = Constants.deck_not_found;
}
