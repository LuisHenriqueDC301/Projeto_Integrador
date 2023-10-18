import 'package:flutter_application_1/models/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static DBHelper? _instance;
  late Database _database;

  
  
  _init() async {
    var dbPath = await getDatabasesPath();
    _database = await openDatabase(
      join(dbPath, "dcge.db"),
      version: 1,
      onCreate: (db, version) async {
        db.execute("""
  CREATE TABLE Eletronicos(
    id INTEGER PRIMARY KEY,
    nome TEXT,
    potencia INTEGER,
    tempoUso INTEGER,
    diasUso INTEGER,
    quantidade INTEGER
  );
  CREATE TABLE ComodosEletronicos(
    id INTEGER PRIMARY KEY,
    nome TEXT
  );
  CREATE TABLE ComodoEletronico(
    id INTEGER PRIMARY KEY,
    comodo_id INTEGER,
    eletronico_id INTEGER,
    FOREIGN KEY (comodo_id) REFERENCES ComodosEletronicos(id),
    FOREIGN KEY (eletronico_id) REFERENCES Eletronicos(id)
  );

  insert into ComodosEletronicos(nome) values ("Sala");
  insert into ComodosEletronicos(nome) values ("Quarto");
  insert into ComodosEletronicos(nome) values ("Lavanderia");
  insert into ComodosEletronicos(nome) values ("Cozinha");
  insert into ComodosEletronicos(nome) values ("Banheiro");
""");
      },
    );
  }
    static Future<DBHelper> getInstance() async {
    if(_instance == null) {
      _instance = DBHelper();
      await _instance?._init();
    } 

    return _instance!;
  }
 

  Future<List<Eletronicos>> getAllEletronicos(String nome) async {
    List<Map<String, dynamic>> rows = await _database.query("Eletronicos"
    /*  """
      SELECT E.*
      FROM Eletronicos AS E
      INNER JOIN ComodoEletronico AS CE ON E.id = CE.eletronico_id
      INNER JOIN ComodosEletronicos AS C ON CE.comodo_id = C.id
      WHERE C.nome = $nome
      """,
     */ 
    );
    List<Eletronicos> eletronicos = List.empty(growable: true);
    for (var element in rows) {
      eletronicos.add(Eletronicos(
        id: element["id"] as int,
        nome: element["nome"] as String,
        potencia: element["potencia"] as int,
         tempoUso: element["tempoUso"] as int,
          diasUso: element["diasUso"] as int,
           quantidade: element["quantidade"] as int,
      ));
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
      ));
    }

    return comodos;
  }

  Future<void> salvarComodos(ComodosEletronicos comodo) async {
    if (comodo.id == 0) {
      await _database.insert("ComodosEletronicos", {
        "nome": comodo.nome,
      });
    } else {
      // Implemente a atualização se necessário
    }
  }

  Future<void> salvareletronicos(Eletronicos eletronicos, String nomeComodo) async {
  if (eletronicos.id == 0) {
    eletronicos.id = await _database.insert("Eletronicos", {
      "nome": eletronicos.nome,
      "potencia": eletronicos.potencia,
      "tempoUso": eletronicos.tempoUso,
      "diasUso": eletronicos.diasUso,
      "quantidade": eletronicos.quantidade,
    });

    int comodoId = await _getComodoIdByName(nomeComodo);

    await _database.insert("ComodoEletronico", {
      "comodo_id": comodoId,
      "eletronico_id": eletronicos.id,
    });
  }
}


  Future<int> _getComodoIdByName(String nomeComodo) async {
    final result = await _database.query("ComodosEletronicos", where: "nome = ?", whereArgs: [nomeComodo]);
    if (result.isNotEmpty) {
      return result.first["id"] as int;
    } else {
      // Trate o caso em que o cômodo não é encontrado (você pode inserir o cômodo aqui, se necessário)
      return 0;
    }
  }
}
