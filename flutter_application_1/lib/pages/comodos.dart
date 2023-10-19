import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/models.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = true;
  late List<Eletronicos> eletronicos = [];

  @override
  Widget build(BuildContext context) {
    double calcularConsumo(String comodo) {
      double consumoTotal = 0.0; // Inicializa o consumo total como zero

      // Verifica se o cômodo existe na lista de eletrônicos por comodo
      if (eletronicosPorComodo.containsKey(comodo)) {
        // Obtém a lista de eletrônicos para o cômodo
        List<Eletronicos> eletronicosNoComodo = eletronicosPorComodo[comodo]!;

        // Itera sobre a lista de eletrônicos no cômodo e calcula o consumo
        for (Eletronicos eletronico in eletronicosNoComodo) {
          double consumoAparelho = (eletronico.potencia *
                  eletronico.tempoUso *
                  eletronico.diasUso) /
              1000; // O resultado é em kW, dividido por 1000 para converter para W
          consumoTotal += consumoAparelho;
        }
      }

      return consumoTotal;
    }

    double calcularValorConsumo(double consumoKwh, double custoKwh) {
      double valorConsumo = consumoKwh * custoKwh;
      return valorConsumo;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Adicione cômodos à sua casa'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.green,
        child: ListView(
          children: [
            ComodoListItem(
              nome: 'Sala',
              equipamentos: eletronicosPorComodo["Sala"]!.length,
              consumo: calcularConsumo("Sala").toStringAsFixed(0),
              valorConsumo: calcularValorConsumo(calcularConsumo("Sala"), 0.656).toStringAsFixed(2),
              icone: Icons.tv,
            ),
            ComodoListItem(
              nome: 'Quarto',
              equipamentos: eletronicosPorComodo['Quarto']!.length,
              consumo: calcularConsumo("Quarto").toStringAsFixed(0),
              valorConsumo: calcularValorConsumo(calcularConsumo("Quarto"), 0.656).toStringAsFixed(2),
              icone: Icons.bed,
            ),
            ComodoListItem(
              nome: 'Lavanderia',
              equipamentos: eletronicosPorComodo['Lavanderia']!.length,
              consumo: calcularConsumo("Lavanderia").toStringAsFixed(0),
              valorConsumo: calcularValorConsumo(calcularConsumo("Lavanderia"), 0.656).toStringAsFixed(2),
              icone: Icons.local_laundry_service,
            ),
            ComodoListItem(
              nome: 'Cozinha',
              equipamentos: eletronicosPorComodo['Cozinha']!.length,
              consumo: calcularConsumo("Cozinha").toStringAsFixed(0),
              valorConsumo: calcularValorConsumo(calcularConsumo("Cozinha"), 0.656).toStringAsFixed(2),
              icone: Icons.kitchen,
            ),
            ComodoListItem(
              nome: 'Banheiro',
              equipamentos: eletronicosPorComodo['Banheiro']!.length,
              consumo: calcularConsumo("Banheiro").toStringAsFixed(0),
              valorConsumo:  calcularValorConsumo(calcularConsumo("Banheiro"), 0.656).toStringAsFixed(2),
              icone: Icons.bathtub,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //await Navigator.pushNamed(context, "crud_eletro",arguments: widget.nome);
          // Aqui você pode adicionar a lógica para adicionar um novo cômodo
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

Map<String, List<String>> comodosEquipamentos = {
  'Sala': [],
  'Quarto': [],
  'Lavanderia': [],
  'Cozinha': [],
  'Banheiro': [],
};

class ComodoListItem extends StatefulWidget {
  final String nome;
  final int equipamentos;
  final String consumo;
  final String valorConsumo;
  final IconData icone;

  ComodoListItem({
    required this.nome,
    required this.equipamentos,
    required this.consumo,
    required this.valorConsumo,
    required this.icone,
  });

  @override
  State<ComodoListItem> createState() => _ComodoListItemState();
}

class _ComodoListItemState extends State<ComodoListItem> {
  List<ComodosEletronicos> comodos = [];

  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: Icon(widget.icone, color: Colors.black, size: 40.0),
        title: Text(
          widget.nome,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Equipamentos: ${widget.equipamentos}',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            Text(
              'Consumo: ${widget.consumo}W/h',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            Text(
              'Valor do Consumo: ${widget.valorConsumo}',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, "crud_eletro", arguments: widget.nome);

          print(comodos);
          print('Cômodo: ${widget.nome}');
        },
      ),
    );
  }
}
