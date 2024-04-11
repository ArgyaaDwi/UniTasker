import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database?> setDatabase() async {
    try {
      var directory = await getApplicationDocumentsDirectory();
      var path = join(directory.path, 'db_manajemen_tugas_sqflite');
      var database =
          await openDatabase(path, version: 1, onCreate: _onCreateDb);
      return database;
    } catch (error) {
      print("Error occurred while opening or creating database: $error");
      return null;
    }
  }

  Future<void> _onCreateDb(Database database, int version) async {
    try {
      await database.execute(
        '''
CREATE TABLE matkul(id INTEGER PRIMARY KEY, namaMatkul TEXT, namaDosen TEXT, hari TEXT, jamMulai TEXT, jamBerakhir TEXT, ruangan TEXT)
''',
      );
    } catch (error) {
      print("Error occurred while creating table: $error");
    }
    return Future.value(); 
  }
}
