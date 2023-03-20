class IMC {
  double _peso = 0;
  double _altura = 0;
  double _imc = 0;

  IMC(this._peso, this._altura);

  double get peso => _peso;

  set peso(double peso) {
    _peso = peso;
  }

  double get altura => _altura;

  set altura(double altura) {
    _altura = altura;
  }

  double get imc => _imc;

  void calculateIMC() {
    _imc = _peso / (_altura * _altura);
  }
}