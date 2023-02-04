import 'Status.dart';

class Deck {

  int? id;
  String name;
  Status? toSynchronize;

  Deck({
    this.id,
    required this.name,
    this.toSynchronize
  });

  Deck.fromMap(Map<String, dynamic> data):
        id = data['id'],
        name = data['name'],
        toSynchronize = data['to_synchronize'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'to_synchronize': toSynchronize,
    };
  }
}