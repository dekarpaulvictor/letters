import 'package:flutter/foundation.dart';
import 'package:letters/models/letter.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  late Database _database;

  Future<void> open() async {
    try {
      _database = await openDatabase(
        'letters.db',
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE letters(
              id TEXT PRIMARY KEY,
              title TEXT,
              body TEXT,
              date TEXT
            );

            CREATE TABLE favorites(
              id TEXT PRIMARY KEY,
              letterId TEXT,
            );

            CREATE TABLE bookmarks(
              id TEXT PRIMARY KEY,
              letterId TEXT,
            );
          ''');
        },
      );
    } catch (e) {
      debugPrint("Error Opening Database: $e");
      debugPrintStack();
    }
  }

  Future<void> close() async {
    try {
      await _database.close();
    } catch (e) {
      debugPrint("Error Closing Database: $e");
      debugPrintStack();
    }
  }

  Future<void> saveLetter(Letter letter) async {
    try {
      await _database.insert(
        'letters',
        letter.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      debugPrint("Error Saving Letter: $e");
      debugPrintStack();
    }
  }

  Future<void> saveFavorite(String letterId) async {
    try {
      await _database.insert(
        'favorites',
        {'id': letterId, 'letterId': letterId},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      debugPrint("Error Saving Favorite: $e");
      debugPrintStack();
    }
  }

  Future<void> saveBookmark(String letterId) async {
    try {
      await _database.insert(
        'bookmarks',
        {'id': letterId, 'letterId': letterId},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      debugPrint("Error Saving Bookmark: $e");
      debugPrintStack();
    }
  }

  Future<void> deleteFavorite(String letterId) async {
    try {
      await _database.delete(
        'favorites',
        where: 'letterId = ?',
        whereArgs: [letterId],
      );
    } catch (e) {
      debugPrint("Error Deleting Favorite: $e");
      debugPrintStack();
    }
  }

  Future<void> deleteBookmark(String letterId) async {
    try {
      await _database.delete(
        'bookmarks',
        where: 'letterId = ?',
        whereArgs: [letterId],
      );
    } catch (e) {
      debugPrint("Error Deleting Bookmark: $e");
      debugPrintStack();
    }
  }

  Future<Letter?> getLetter(String id) async {
    try {
      final List<Map<String, dynamic>> data = await _database.query(
        'letters',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (data.isEmpty) return null;
      return Letter.fromJson(data.first);
    } catch (e) {
      debugPrint("Error Getting Letter: $e");
      debugPrintStack();
      return null;
    }
  }

  Future<List<Letter>> getLetters() async {
    try {
      final List<Map<String, dynamic>> data = await _database.query('letters');
      return data.map((e) => Letter.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Error Getting Letters: $e");
      debugPrintStack();
      return [];
    }
  }

  Future<List<Letter>> getFavorites() async {
    try {
      final List<Map<String, dynamic>> data =
          await _database.query('favorites');
      final List<String> ids =
          data.map((e) => e['letterId'] as String).toList();
      final List<Letter> letters = [];
      for (final id in ids) {
        final letter = await getLetter(id);
        if (letter != null) letters.add(letter);
      }
      return letters;
    } catch (e) {
      debugPrint("Error Getting Favorites: $e");
      debugPrintStack();
      return [];
    }
  }

  Future<List<Letter>> getBookmarks() async {
    try {
      final List<Map<String, dynamic>> data =
          await _database.query('bookmarks');
      final List<String> ids =
          data.map((e) => e['letterId'] as String).toList();
      final List<Letter> letters = [];
      for (final id in ids) {
        final letter = await getLetter(id);
        if (letter != null) letters.add(letter);
      }
      return letters;
    } catch (e) {
      debugPrint("Error Getting Bookmarks: $e");
      debugPrintStack();
      return [];
    }
  }
}
