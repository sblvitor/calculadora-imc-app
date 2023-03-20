import '../models/imc.dart';

abstract class IMCRepository {

  void addIMC(IMC imc);

  Future<List<IMC>> getIMCs();
}