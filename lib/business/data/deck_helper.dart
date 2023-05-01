import 'package:ehkow/business/data/database_helper.dart';
import 'package:ehkow/business/model/status.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../model/deck.dart';
import '../model/exceptions/deck_not_found_exception.dart';
import '../model/flashcard.dart';

class DeckHelper extends DatabaseHelper {
  Future<int> createDeck(String name) async {
    final db = await getDb();

    final data = {'name': name, 'to_synchronize': 1};
    final id = await db.insert('deck', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //READ
  Future<List<Deck>> getAllDecks() async {
    final db = await getDb();
    var maps = await db.query('deck', orderBy: 'id');
    var list = List.generate(maps.length, (i) {
      return Deck(
          id: maps[i]['id'] as int,
          name: maps[i]['name'] as String,
          toSynchronize: maps[i]['to_synchronize'] == 0
              ? Status.NONE
              : Status.TO_SYNCHRONIZE as Status?);
    });
    return list;
  }

  Future<Deck> findDeckById(String id) async {
    final db = await getDb();
    var maps =
        await db.query('deck', where: 'id = ?', limit: 1, whereArgs: [id]);
    var list = List.generate(maps.length, (i) {
      return Deck(
          id: maps[i]['id'] as int,
          name: maps[i]['name'] as String,
          toSynchronize: maps[i]['to_synchronize'] == 0
              ? Status.NONE
              : Status.TO_SYNCHRONIZE);
    });
    return list.first;
  }

  //UPDATE
  Future<int> updateDeck(int id, String name) async {
    final db = await getDb();

    final data = {'name': name, 'to_synchronize': Status.TO_SYNCHRONIZE};

    final result =
        await db.update('deck', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  //DELETE
  Future<void> deleteDeck(int id) async {
    final db = await getDb();
    try {
      await db.delete('deck', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong when deleting an deck: $err');
    }
  }

  Future<List<FlashCard>> getFlashCardsByDeckId(String id) async {
    final db = await getDb();
    var maps =
        await db.query('flash_card', orderBy: 'id', where: 'deck_id = ?');
    if (maps.isEmpty) throw DeckNotFoundException();
    var list = List.generate(maps.length, (i) {
      return FlashCard(
          id: maps[i]['id'] as int,
          originalContent: maps[i]['original'] as String,
          translatedContent: maps[i]['translated'] as String,
          deckId: maps[i]['deck_id'] as int,
          toSynchronize: maps[i]['to_synchronize'] == 0
              ? Status.NONE
              : Status.TO_SYNCHRONIZE);
    });
    return list;
  }
}
