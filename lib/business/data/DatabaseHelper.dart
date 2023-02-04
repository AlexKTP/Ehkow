import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../model/Deck.dart';
import '../model/FlashCard.dart';
import '../model/Status.dart';

class DatabaseHelper {
  DatabaseHelper();

  Future<void> _onCreate(Database database) async {
    await database.execute('CREATE TABLE IF NOT EXISTS deck (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,name TEXT);');
    await database.execute('CREATE TABLE IF NOT EXISTS flash_card (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,original TEXT,translated TEXT,deck_id INTEGER NOT NULL, FOREIGN KEY (deck_id) REFERENCES deck(id));');
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  _onOpen(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
    log('db version ${await db.getVersion()}');
  }

  Future<Database> getDb() async {
    return openDatabase(
      'main.db',
      version: 1, onConfigure: _onConfigure,
      onCreate: (Database database, int version) async {
        await _onCreate(database);
      }, onOpen: _onOpen,
    singleInstance: true);
  }

  //CREATE
  Future<int> createFlashCard(String originalContent, String translatedContent, int deckId) async {
    final db = await getDb();

    final data = {'original': originalContent, 'translated': translatedContent, 'deck_id': deckId};
    final id = await db.insert("flash_card", data,
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
          translatedContent: maps[i]['translated'] as String,
          deckId: maps[i]['deck_id'] as int,
          toSynchronize: maps[i]['to_synchronize'] as Status);
    });
    return list;
  }

  Future<List<FlashCard>> getFlashCardsByDeckId(String id) async {
    final db = await getDb();
    var maps = await db.query('flash_card', orderBy: "id", where: 'deck_id = ?');
    var list = List.generate(maps.length, (i) {
      return FlashCard(
          id: maps[i]['id'] as int,
          originalContent: maps[i]['original'] as String,
          translatedContent: maps[i]['translated'] as String,
          deckId: maps[i]['deck_id'] as int,
          toSynchronize: maps[i]['to_synchronize'] as Status);
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
          translatedContent: maps[i]['translated'] as String,
          deckId: maps[i]['deck_id'] as int,
          toSynchronize: maps[i]['to_synchronize'] as Status);
    });
    return list.first;
  }

  //UPDATE
  Future<int> updateFlashCard(int id, String original, String translated) async {
    final db = await getDb();

    final data = {'original': original, 'translated': translated, 'to_synchronize': Status.TO_SYNCHRONIZE};

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

 ////

  Future<int> createDeck(String name) async {
    final db = await getDb();

    final data = {'name': name, 'to_synchronize': Status.TO_SYNCHRONIZE};
    final id = await db.insert("deck", data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //READ
  Future<List<Deck>> getAllDecks() async {
    final db = await getDb();
    var maps = await db.query('deck', orderBy: "id");
    var list = List.generate(maps.length, (i) {
      return Deck(
          id: maps[i]['id'] as int,
          name: maps[i]['name'] as String,
          toSynchronize: maps[i]['to_synchronize'] as Status);
    });
    return list;
  }

  Future<Deck> findDeckById(String id) async {
    final db = await getDb();
    var maps = await db
        .query("deck", where: "id = ?", limit: 1, whereArgs: [id]);
    var list = List.generate(maps.length, (i) {
      return Deck(
          id: maps[i]['id'] as int,
          name: maps[i]['name'] as String,
          toSynchronize: maps[i]['to_synchronize'] as Status);
    });
    return list.first;
  }

  //UPDATE
  Future<int> updateDeck(int id, String name) async {
    final db = await getDb();

    final data = {'name': name, 'to_synchronize': Status.TO_SYNCHRONIZE};

    final result =
    await db.update('deck', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  //DELETE
  Future<void> deleteDeck(int id) async {
    final db = await getDb();
    try {
      await db.delete("deck", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an deck: $err");
    }
  }
}