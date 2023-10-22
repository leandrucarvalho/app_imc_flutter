import 'package:flutter/material.dart';

import '../model/imc_model.dart';
import '../repository/imc_repository.dart';

class IMCPage extends StatefulWidget {
  const IMCPage({super.key, required this.title});

  final String title;

  @override
  State<IMCPage> createState() => _IMCPageState();
}

class _IMCPageState extends State<IMCPage> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String resultado = '';
  String classificacao = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD0E9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        title: Text(
          widget.title,
          style: const TextStyle(color: Color(0xFFFFFFFF)),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: pesoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Digite seu peso em kg",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: alturaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Digite sua altura em cm",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        pesoController.text = '';
                        alturaController.text = '';
                        setState(() {
                          resultado = '';
                          classificacao = '';
                        });
                      },
                      child: const Text("Limpar"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        double peso =
                            double.tryParse(pesoController.text) ?? 0.0;
                        double altura =
                            (double.tryParse(alturaController.text) ?? 0.0);

                        if (peso > 0 && altura > 0) {
                          double imc = 0.0;
                          ImcModel imcModel = ImcModel(
                            data: DateTime.now().toString(),
                            peso: peso,
                            altura: altura,
                            imc: imc,
                            classificacao: classificacao,
                          );

                          await ImcRepository.instance.salvar(imcModel);
                          ImcModel imcResult = ImcModel(
                            peso: peso,
                            altura: altura,
                          );
                          double imcCalc = imcResult.calculateIMC();

                          setState(() {
                            resultado =
                                "Seu IMC: ${imcCalc.toStringAsFixed(2)}";
                            classificacao = imcModel.classifyIMC(imcCalc);
                          });
                        }
                      },
                      child: const Text("Calcular"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  resultado,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  classificacao,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
