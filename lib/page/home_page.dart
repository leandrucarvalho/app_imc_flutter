import 'package:flutter/material.dart';

import '../model/person.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  var result = "";
  var status = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: nameController,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "Digite seu nome",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: weightController,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "Digite seu peso",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: heightController,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "Digite sua altura",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      result = '';
                      nameController.text = '';
                      weightController.text = '';
                      heightController.text = '';
                      status = '';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                  child: Text(
                    'Limpar',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    String name = nameController.text;
                    double weight =
                        double.tryParse(weightController.text) ?? 0.0;
                    double height =
                        double.tryParse(heightController.text) ?? 0.0;

                    if (weight > 0 && height > 0) {
                      Person person = Person(
                        name: name,
                        weight: weight,
                        height: height,
                      );
                      double imc = person.calculateIMC();
                      setState(() {
                        result = imc.toStringAsFixed(2);
                        status = person.classifyIMC(imc);
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Peso e altura devem ser números",
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                  child: Text(
                    'Calcular',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Nome: ${nameController.text}"),
            Text("Peso: ${weightController.text}"),
            Text("Altura: ${heightController.text}"),
            Text("Resultado: $result"),
            Text("Status: $status"),
          ],
        ),
      ),
    );
  }
}
