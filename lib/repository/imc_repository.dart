import '../models/imc.dart';

abstract class IMCRepository {

  Future<void> addIMC(IMC imc);

  Future<List<IMC>> getIMCs();
}