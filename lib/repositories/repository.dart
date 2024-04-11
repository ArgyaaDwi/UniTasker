import 'package:manajemen_tugas/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  Future<dynamic> insertDataMatkul(table, Map<String, dynamic> data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  Future<dynamic> readDataMatkul(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  Future<dynamic> readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  Future<dynamic> updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  Future<dynamic> deleteData(table, itemId) async {
    var connection = await database;
    return await connection
        ?.rawDelete("DELETE FROM matkul WHERE id = ?", [itemId]);
  }
}
