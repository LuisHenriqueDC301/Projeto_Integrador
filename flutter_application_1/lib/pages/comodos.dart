import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/dbhelper.dart';
import 'package:flutter_application_1/models/models.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  late List<ComodosEletronicos> comodos;
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
              equipamentos: comodosEquipamentos["Sala"]!.length,
              consumo: '300W',
              valorConsumo: '\$0.30',
              icone: Icons.tv,
            ),
            ComodoListItem(
              nome: 'Quarto',
              equipamentos: comodosEquipamentos['Quarto']!.length,
              consumo: '150W',
              valorConsumo: '\$0.15',
              icone: Icons.bed,
            ),
            ComodoListItem(
              nome: 'Lavanderia',
              equipamentos: comodosEquipamentos['Lavanderia']!.length,
              consumo: '100W',
              valorConsumo: '\$0.10',
              icone: Icons.local_laundry_service,
            ),
            ComodoListItem(
              nome: 'Cozinha',
              equipamentos: comodosEquipamentos['Cozinha']!.length,
              consumo: '200W',
              valorConsumo: '\$0.20',
              icone: Icons.kitchen,
            ),
            ComodoListItem(
              nome: 'Banheiro',
              equipamentos: comodosEquipamentos['Banheiro']!.length,
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
  void initState() {

    super.initState();
    _carregarBD();
  }

  void _carregarBD() {
    setState(() {
      _loading = true;
    });
    DBHelper.getInstance().then(
      (value) => value.getAllComodos()
        .then((value) => {
          setState(() => comodos = value)
        })
        .whenComplete(() => _loading = false));
  }
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
              'Consumo: ${widget.consumo}',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            Text(
              'Valor do Consumo: ${widget.valorConsumo}',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ],
        ),
        onTap: () {
        /*  Navigator.pushNamed(
            context,
            "aparelhos", arguments: widget.nome
          );
         */ 
          _carregarBD();
          print(comodos);
          print('Cômodo: ${widget.nome}');
        },
      ),
    );
  }
}
