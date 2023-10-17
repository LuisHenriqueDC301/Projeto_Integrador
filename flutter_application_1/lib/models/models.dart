class Eletronicos {
  int id;
  String nome;
  int potencia;

  Eletronicos({this.id = 0, required this.nome, required this.potencia});
}
class ComodosEletronicos{
  int id;
  String nome;
  int id_eletronico;
  String nomeComodo;
  int consumo;

  ComodosEletronicos({this.id = 0, required this.nome, required this.id_eletronico, required this.nomeComodo, required this.consumo });
}
