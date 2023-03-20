import 'package:calculadora_imc/models/imc.dart';
import 'package:calculadora_imc/repository/imc_repository_impl.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var imcRepository = IMCRepositoryImpl();
  var pesoController = TextEditingController(text: "");
  var alturaController = TextEditingController(text: "");
  var _imc = const <IMC>[];

  @override
  void initState() {
    super.initState();
    getIMCs();
  }

  void getIMCs() async {
    _imc = await imcRepository.getIMCs();
  }

  double calcularImc(double peso, double altura) {
    var imc = peso / (altura * altura);
    return imc;
  }

  String getClassificacao(double imc) {
    if (imc < 16) {
      return "Magreza grave";
    } else if (imc < 17) {
      return "Magreza moderada";
    } else if (imc < 18.5) {
      return "Magreza leve";
    } else if (imc < 25) {
      return "Saudável";
    } else if (imc < 30) {
      return "Sobrepeso";
    } else if (imc < 35) {
      return "Obesidade Grau 1";
    } else if (imc < 40) {
      return "Obesidade Grau 2 (severa)";
    } else {
      return "Obesidade Grau 3 (mórbida)";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: _imc.length,
            itemBuilder: (BuildContext bc, int index) {
              var imc = _imc[index];
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Peso: ${imc.peso}kg"),
                    Text("Altura: ${imc.altura}m"),
                    Text("IMC: ${imc.imc.toStringAsFixed(2)}")
                  ],
                ),
                subtitle: Text("Classificação: ${getClassificacao(imc.imc)}"),
                isThreeLine: true,
              );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          pesoController.text = "";
          alturaController.text = "";
          showDialog(context: context, builder: (BuildContext bc) {
            return AlertDialog(
              title: const Text(
                "Para calcular seu IMC, informe:",
                style: TextStyle(fontSize: 16),
              ),
              content: Wrap(
                //alignment: WrapAlignment.spaceBetween,
                children: <Widget>[
                  TextField(
                    controller: pesoController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.scale),
                      hintText: "Peso em kg (ex: 75.4)"
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: alturaController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.height),
                        hintText: "Altura em metros (ex: 1.68)"
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar")
                ),
                TextButton(
                    onPressed: () async {
                      double? peso;
                      double? altura;
                      peso = double.tryParse(pesoController.text);
                      altura = double.tryParse(alturaController.text);
                      if(peso == null || altura == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Por favor preencha os campos conforme os exemplos!")));
                      } else {
                         await imcRepository.addIMC(IMC(peso, altura, calcularImc(peso, altura)));
                        Navigator.pop(context);
                      }
                      setState(() {});
                    },
                    child: const Text("Calcular",
                    style: TextStyle(fontWeight: FontWeight.bold))
                )
              ],
            );
          });
        },
      ),
    );
  }
}
