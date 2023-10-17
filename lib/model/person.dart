// ignore_for_file: public_member_api_docs, sort_constructors_first
class Person {
  String name;
  double weight;
  double height;
  Person({
    required this.name,
    required this.weight,
    required this.height,
  });

  double calculateIMC() {
    if (height <= 0) {
      throw Exception("A altura deve ser maior que zero.");
    }
    double heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  String classifyIMC(double imc) {
    if (imc < 16) {
      return 'Magreza grave';
    } else if (imc >= 16 && imc < 17) {
      return 'Magreza moderada';
    } else if (imc >= 17 && imc < 18.5) {
      return 'Magreza leve';
    } else if (imc >= 18.5 && imc < 25) {
      return 'Saudável';
    } else if (imc >= 25 && imc < 30) {
      return 'Sobrepeso';
    } else if (imc >= 30 && imc < 35) {
      return 'Obesidade Grau I';
    } else if (imc >= 35 && imc < 40) {
      return 'Obesidade Grau II (severa)';
    } else {
      return 'Obesidade Grau III (mórbida)';
    }
  }
}
