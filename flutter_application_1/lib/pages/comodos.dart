import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              equipamentos: 5,
              consumo: '300W',
              valorConsumo: '\$0.30',
              icone: Icons.tv,
            ),
            ComodoListItem(
              nome: 'Quarto',
              equipamentos: 3,
              consumo: '150W',
              valorConsumo: '\$0.15',
              icone: Icons.bed,
            ),
            ComodoListItem(
              nome: 'Lavanderia',
              equipamentos: 2,
              consumo: '100W',
              valorConsumo: '\$0.10',
              icone: Icons.local_laundry_service,
            ),
            ComodoListItem(
              nome: 'Cozinha',
              equipamentos: 4,
              consumo: '200W',
              valorConsumo: '\$0.20',
              icone: Icons.kitchen,
            ),
            ComodoListItem(
              nome: 'Banheiro',
              equipamentos: 2,
              consumo: '75W',
              valorConsumo: '\$0.07',
              icone: Icons.bathtub,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aqui você pode adicionar a lógica para adicionar um novo cômodo
          print('Adicionar cômodo');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class ComodoListItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: Icon(icone, color: Colors.black, size: 40.0),
        title: Text(
          nome,
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
              'Equipamentos: $equipamentos',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            Text(
              'Consumo: $consumo',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            Text(
              'Valor do Consumo: $valorConsumo',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            "aparelhos",
          );
          print('Cômodo: $nome');
        },
      ),
    );
  }
}
