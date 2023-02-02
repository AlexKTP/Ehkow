import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../model/FlashCard.dart';

class DatabaseHelper {
  DatabaseHelper();

  Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE flash_card(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        original TEXT,
        translated TEXT
      );
      """);
  }

  Future<Database> getDb() async {
    return openDatabase(
      'database.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  //CRUD

  //CREATE
  Future<int> createFlashCard(String originalContent, String translatedContent) async {
    final db = await getDb();

    final data = {'original': originalContent, 'translated': translatedContent};
    final id = await db.insert('flash_card', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //READ
  Future<List<FlashCard>> getFlashCards() async {
    final db = await getDb();
    var maps = await db.query('flash_card', orderBy: "id");
    var list = List.generate(maps.length, (i) {
      return FlashCard(
          id: maps[i]['id'] as int,
          originalContent: maps[i]['original'] as String,
          translatedContent: maps[i]['translated'] as String);
    });
    return list;
  }

  Future<FlashCard> findById(String id) async {
    final db = await getDb();
    var maps = await db
        .query("flash_card", where: "id = ?", limit: 1, whereArgs: [id]);
    var list = List.generate(maps.length, (i) {
      return FlashCard(
          id: maps[i]['id'] as int,
          originalContent: maps[i]['original'] as String,
          translatedContent: maps[i]['translated'] as String);
    });
    return list.first;
  }

  //UPDATE
  Future<int> updateFlashCard(int id, String original, String translated) async {
    final db = await getDb();

    final data = {'original': original, 'translated': translated};

    final result =
    await db.update('flash_card', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  //DELETE
  Future<void> deleteFlashCard(int id) async {
    final db = await getDb();
    try {
      await db.delete("flash_card", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an flash_card: $err");
    }
  }
}