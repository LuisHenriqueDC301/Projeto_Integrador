class Eletronicos {
  int id;
  String nome;
  int potencia;
  int tempoUso;
  int diasUso;
  int quantidade;

  Eletronicos({this.id = 0, required this.nome, required this.potencia, required this.tempoUso, required this.diasUso, required this.quantidade});
}

class ComodosEletronicos {
  int id;
  String nome;

  ComodosEletronicos({this.id = 0, required this.nome});
}

class ComodoEletronico {
  int id;
  int comodoId;
  int eletronicoId;

  ComodoEletronico({this.id = 0, required this.comodoId, required this.eletronicoId});
}
