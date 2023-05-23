import 'package:ehkow/business/data/database_helper.dart';
import 'package:ehkow/business/model/status.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../model/exceptions/deck_not_found_exception.dart';
import '../model/flashcard.dart';

class FlashCardHelper extends DatabaseHelper {
  //CREATE
  Future<int> createFlashCard(
      String originalContent, String translatedContent, int deckId) async {
    final db = await getDb();

    final data = {
      'original': originalContent,
      'translated': translatedContent,
      'deck_id': deckId,
      'to_synchronize': 1
    };
    final id = await db.insert('flash_card', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //READ
  Future<List<FlashCard>> getFlashCards() async {
    final db = await getDb();
    var maps = await db.query('flash_card', orderBy: 'id');
    var list = List.generate(maps.length, (i) {
      return FlashCard(
          id: maps[i]['id'] as int,
          originalContent: maps[i]['original'] as String,
          translatedContent: maps[i]['translated'] as String,
          deckId: maps[i]['deck_id'] as int,
          toSynchronize: maps[i]['to_synchronize'] == 0
              ? Status.NONE
              : Status.TO_SYNCHRONIZE as Status?);
    });
    return list;
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

  Future<FlashCard> findById(int id) async {
    final db = await getDb();
    var maps = await db
        .query('flash_card', where: 'id = ?', limit: 1, whereArgs: [id]);
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
    return list.first;
  }

  //UPDATE
  Future<int> updateFlashCard(
      int id, String original, String translated) async {
    final db = await getDb();

    final data = {
      'original': original,
      'translated': translated,
      'to_synchronize': Status.TO_SYNCHRONIZE
    };

    final result =
        await db.update('flash_card', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  //DELETE
  Future<void> deleteFlashCard(int id) async {
    final db = await getDb();
    try {
      await db.delete('flash_card', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong when deleting an flash_card: $err');
    }
  }

  Future<int?> getFlashCardCount() async {
    final db = await getDb();
    final int? count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM flash_card'));
    return count;
  }
}
