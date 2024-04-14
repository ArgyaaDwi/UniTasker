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

  //Matkul
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

 Future<void> updateData(String table, Map<String, dynamic> data) async {
    try {
      await _database?.update(
        table,
        data,
        where: 'id = ?',
        whereArgs: [data['id']],
      );
    } catch (e) {
      // Menangani kesalahan jika terjadi
      throw Exception('Terjadi kesalahan saat memperbarui data: $e');
    }
  }

  Future<dynamic> deleteData(table, itemId) async {
    var connection = await database;
    return await connection
        ?.rawDelete("DELETE FROM matkul WHERE id = ?", [itemId]);
  }

  //Tugas
  Future<dynamic> insertDataTugas(table, Map<String, dynamic> data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  Future<dynamic> readDataTugas(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  Future<dynamic> readDataTugasById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  Future<dynamic> updateDataTugas(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  Future<dynamic> deleteDataTugas(table, itemId) async {
    var connection = await database;
    return await connection
        ?.rawDelete("DELETE FROM tugas WHERE id = ?", [itemId]);
  }

  Future<dynamic> readTugasByMatkul(table, columnName, columnValue) async {
    var connection = await database;
    return await connection
        ?.query(table, where: '$columnName=?', whereArgs: [columnValue]);
  }
}
