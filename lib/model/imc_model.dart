class ImcModel {
  int? id;
  String? data;
  double peso;
  double altura;
  double? imc;
  String? classificacao;
  ImcModel({
    this.id,
    this.data,
    required this.peso,
    required this.altura,
    this.imc,
    this.classificacao,
  });

  factory ImcModel.fromMap(Map<String, dynamic> map) {
    return ImcModel(
      id: map['id'],
      data: map['data'],
      peso: map['peso'],
      altura: map['altura'],
      imc: map['imc'],
      classificacao: map['classificacao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
      'peso': peso,
      'altura': altura,
      'imc': imc,
      'classificacao': classificacao,
    };
  }

  double calculateIMC() {
    double alturaMetros = altura / 100;
    if (altura <= 0) {
      throw Exception("A Altura deve ser maior que zero.");
    }
    return (peso / (alturaMetros * alturaMetros));
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
