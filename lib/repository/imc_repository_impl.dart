import 'package:calculadora_imc/models/imc.dart';
import 'package:calculadora_imc/repository/sqlite_database.dart';

import 'imc_repository.dart';

class IMCRepositoryImpl implements IMCRepository {

  @override
  Future<void> addIMC(IMC imc) async {
    var db = await SQLiteDataBase().getDatabase();
    await db.rawInsert('INSERT INTO Imcs (peso, altura, imc) VALUES(?, ?, ?)',
        [imc.peso, imc.altura, imc.imc]);
  }

  @override
  Future<List<IMC>> getIMCs() async {
    List<IMC> imcs = [];
    var db = await SQLiteDataBase().getDatabase();
    var results = await db.rawQuery('SELECT * FROM Imcs');
    for(var result in results) {
      imcs.add(IMC(int.parse(result["id"].toString()),
          double.parse(result["peso"].toString()),
          double.parse(result["altura"].toString()),
          double.parse(result["imc"].toString())));
    }
    return imcs;
  }

}