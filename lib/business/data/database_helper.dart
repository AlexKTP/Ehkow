import 'dart:async';
import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper();

  Future<void> _onCreate(Database database) async {
    await database.execute(
        'CREATE TABLE IF NOT EXISTS deck (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,name TEXT, to_synchronize INTEGER);');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS flash_card (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,original TEXT,translated TEXT,to_synchronize INTEGER, deck_id INTEGER NOT NULL, FOREIGN KEY (deck_id) REFERENCES deck(id));');
  }

  static Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  _onOpen(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
    log('db version ${await db.getVersion()}');
  }

  Future<Database> getDb() async {
    return openDatabase('main.db', version: 1, onConfigure: _onConfigure,
        onCreate: (Database database, int version) async {
      await _onCreate(database);
    }, onOpen: _onOpen, singleInstance: true);
  }
}
