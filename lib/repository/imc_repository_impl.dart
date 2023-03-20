import 'package:calculadora_imc/models/imc.dart';

import 'imc_repository.dart';

class IMCRepositoryImpl implements IMCRepository {

  final List<IMC> _imcs = []; // Mock of database

  @override
  void addIMC(IMC imc) async {
    await Future.delayed(const Duration(seconds: 1));
    _imcs.add(imc);
  }

  @override
  Future<List<IMC>> getIMCs() async {
    await Future.delayed(const Duration(seconds: 1));
    return _imcs;
  }

}