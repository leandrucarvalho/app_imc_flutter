import '../model/imc_model.dart';
import '../sqlite/database.dart';

class ImcRepository {
  static final ImcRepository instance = ImcRepository._internal();

  ImcRepository._internal();

  Future<List<ImcModel>> obterDados(bool apenasNaoConcluidos) async {
    List<ImcModel> imc = [];
    var db = await SQliteDataBase().obterDatabase();
    var result = await db.rawQuery(
        'SELECT id, data, peso, altura, imc, classificacao FROM imc_data');
    for (var element in result) {
      imc.add(ImcModel.fromMap(element));
    }
    return imc;
  }

  Future<void> salvar(ImcModel imcModel) async {
    var db = await SQliteDataBase().obterDatabase();
    final values = imcModel.toMap();
    await db.rawInsert(
      "INSERT INTO imc_data (data, peso, altura, imc, classificacao) values (?, ?, ?, ?, ?)",
      [
        values["data"],
        values["peso"],
        values["altura"],
        values["imc"],
        values["classificacao"],
      ],
    );
  }

  Future<void> remover(int id) async {
    var db = await SQliteDataBase().obterDatabase();
    await db.rawDelete(
      "DELETE FROM imc_data WHERE id = ?",
      [id],
    );
  }
}
