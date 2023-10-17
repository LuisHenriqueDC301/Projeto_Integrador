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
            id INTEGER PRIMARY KEY,
            nome TEXT,
            potencia TEXT
          );
          CREATE TABLE ComodosEletronicos(
            id INTEGER PRIMARY KEY,
            id_eletronico INTEGER,
            nomeComodo TEXT,
            consumo INTEGER

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

  Future<List<Eletronicos>> getAllEletronicos(String nome) async {
     List<Map<String, dynamic>> rows = await _database.rawQuery(
    """
    SELECT E.*
    FROM Eletronicos AS E
    INNER JOIN ComodosEletronicos AS CE ON E.id = CE.id_eletronico
    WHERE CE.comodo = ?
    """,
    [nome],
  );
    List<Eletronicos> eletronicos = List.empty(growable: true);

    for (var element in rows) {
      eletronicos.add(Eletronicos(
          id: element["id"] as int,
          nome: element["nome"] as String,
          potencia: element["potencia"] as int));
    }

    return eletronicos;
  }
  Future<List<ComodosEletronicos>> getAllComodos() async {
  List<Map<String, dynamic>> rows = await _database.query("ComodosEletronicos");
  List<ComodosEletronicos> comodos = List.empty(growable: true);

  for (var element in rows) {
    comodos.add(ComodosEletronicos(
      id: element["id"] as int,
      nome: element["nome"] as String,
      id_eletronico: element["id_eletronico"] as int,
      nomeComodo: element["nomeComodo"] as String,
      consumo: element["consumo"] as int,
    ));
  }

  return comodos;
}

Future<void> salvarComodos(ComodosEletronicos comodo) async {
  if (comodo.id == 0) {
    await _database.insert("ComodosEletronicos", {
      "nome": comodo.nome,
      "id_eletronico": comodo.id_eletronico,
      "nomeComodo": comodo.nomeComodo,
      "consumo": comodo.consumo,
    });
  } else {
    // Implemente a atualização se necessário
  }
}


 
  void salvareletronicos(Eletronicos eletronicos,String nomeComodo, int consumo) async {
    if (eletronicos.id == 0) {
      eletronicos.id = await _database.insert("eletronicos",
          {"nome": eletronicos.nome, "potencia": eletronicos.potencia});
      eletronicos.id = await _database.insert("ComodosEletronicos",
          {"id_eletronico": eletronicos.id, "nomeComodo": nomeComodo, "consumo" : consumo});
    } /*else {
      await _database.update("eletronicos",
          {"nome": eletronicos.nome, "potencia": eletronicos.potencia},
          where: "id = ${eletronicos.id}");
      await _database.update("ComodosEletronicos",
         {"id_eletronico": eletronicos.id, "id_comodo": comodos.id, "consumo" : consumo});
      
    }*/
  }
}
