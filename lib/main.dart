import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import 'my_app.dart';

Map<int, String> scripts = {
  1: ''' CREATE TABLE Imcs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          peso REAL,
          altura REAL,
          imc REAL
  );'''
};

Future iniciateDatabase() async {
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await iniciateDatabase();
  runApp(const MyApp());
}


