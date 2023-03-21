import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Map<int, String> scripts = {
  1: ''' CREATE TABLE Imcs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          peso REAL,
          altura REAL,
          imc REAL
  );'''
};

class SQLiteDataBase {

  static Database? db;

  Future<Database> getDatabase() async {
    if(db == null) {
      return await iniciateDatabase();
    } else {
      return db!;
    }
  }

  Future<Database> iniciateDatabase() async {
    var db = await openDatabase(
        path.join(await getDatabasesPath(), 'imc_database.db'),
        version: scripts.length,
        onCreate: (Database db, int version) async {
          for(var i = 1; i <= scripts.length; i++) {
            await db.execute(scripts[i]!);
          }
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          for(var i = oldVersion + 1; i <= scripts.length; i++) {
            await db.execute(scripts[i]!);
          }
        });
    return db;
  }

}