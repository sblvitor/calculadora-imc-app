import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var pesoController = TextEditingController(text: "");
  var alturaController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(),
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
                    onPressed: () {
                      // calcular
                      Navigator.pop(context);
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
