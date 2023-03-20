import 'package:flutter/cupertino.dart';

class IMC {
  final String _id = UniqueKey().toString();
  double _peso = 0;
  double _altura = 0;
  double _imc = 0;

  IMC(this._peso, this._altura);

  String get id => _id;

  double get peso => _peso;

  set peso(double peso) {
    _peso = peso;
  }

  double get altura => _altura;

  set altura(double altura) {
    _altura = altura;
  }

  double get imc => _imc;

  set imc(double imc) {
    _imc = imc;
  }
}