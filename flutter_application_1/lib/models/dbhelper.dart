import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models.dart';

class DBHelper {
  static DBHelper? _instance;
  late Database _database;

  _init() async {
    var dbPath = await getDatabasesPath();
    _database = await openDatabase(
      join(dbPath, "DCGE.db"),
      version: 1,
      onCreate: (db, version) async {
        db.execute("""
          CREATE TABLE Eletronicos(
            id INTEREGER PRIMARY KEY,
            nome TEXT,
            potencia TEXT
          )
""");
      },
    );
  }

  static Future<DBHelper> getInstance() async {
    if (_instance == null) {
      _instance = DBHelper();
      await _instance?._init();
    }

    return _instance!;
  }

  Future<List<Eletronicos>> getAllContatos() async {
    List<Map<String, Object?>> rows = await _database.query("contatos");
    List<Eletronicos> eletronicos = List.empty(growable: true);

    for (var element in rows) {
      eletronicos.add(Eletronicos(
          id: element["id"] as int,
          nome: element["nome"] as String,
          potencia: element["potencia"] as String));
    }

    return eletronicos;
  }

  void salvareletronicos(Eletronicos eletronicos) async {
    if (eletronicos.id == 0) {
      eletronicos.id = await _database.insert("eletronicos",
          {"nome": eletronicos.nome, "telefone": eletronicos.potencia});
    } else {
      await _database.update("eletronicos",
          {"nome": eletronicos.nome, "potencia": eletronicos.potencia},
          where: "id = ${eletronicos.id}");
    }
  }
}
