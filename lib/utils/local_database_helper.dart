import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseHelper {
  late Database _database;

  Future<void> initDatabase({
    required String databasePathName,
    int version = 1,
    FutureOr<void> Function(Database, int)? onCreate,
  }) async {
    _database = await _openYourDatabase(
      databasePathName: databasePathName,
      version: version,
      onCreate: onCreate,
    );
    print(_database);
  }

  Future<Database> _openYourDatabase({
    required String databasePathName,
    int version = 1,
    FutureOr<void> Function(Database, int)? onCreate,
  }) async {
    final dbPath = await getDatabasesPath();
    final path = join(
      dbPath,
      "$databasePathName.db",
    );
    return openDatabase(
      path,
      version: version,
      onCreate: onCreate,
    );
  }

  Future<void> insertToDatabase({
    required Map<String, dynamic> values,
    required String tableName,
  }) async {
    await _database.insert(
      tableName,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateDatabase({
    required Map<String, dynamic> values,
    required String tableName,
    required String query,
  }) async {
    await _database.update(
      tableName,
      values,
      where: query,
    );
  }

  Future<void> deleteDatabase({
    required String tableName,
    required String query,
  }) async {
    await _database.delete(
      tableName,
      where: query,
    );
  }

  Future<List<Map<String, dynamic>>> retrieveData({
    required String tableName,
    String? where,
  }) async {
    return await _database.query(
      tableName,
      where: where
    );
  }

  Future<void> execute({
    required String query,
    List<Object?>? arguments,
  }) async {
    await _database.execute(
      query,
      arguments,
    );
  }
}