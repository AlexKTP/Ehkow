import 'status.dart';

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
        id = data['id'] as int,
        name = data['name'] as String,
        toSynchronize = data['to_synchronize'] as Status;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'to_synchronize': toSynchronize,
    };
  }
}