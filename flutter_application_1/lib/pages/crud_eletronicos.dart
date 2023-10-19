
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/models.dart';

class CrudEletronicos extends StatefulWidget {
  const CrudEletronicos({super.key});
  
  @override
  State<CrudEletronicos> createState() => _CrudEletronicosState();
}

class _CrudEletronicosState extends State<CrudEletronicos> {



  @override
  Widget build(BuildContext context) {
    String nome = ModalRoute.of(context)?.settings.arguments as String;
    List<Eletronicos>? lista = eletronicosPorComodo[nome];
    return Scaffold(
      appBar: AppBar(title: const Text("Controle de gastos"),backgroundColor: Colors.green,),
      body: ListView.builder(
        itemCount: lista!.length,
        itemBuilder: listTile
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, "aparelhos", arguments: nome);
          setState(() {  });
        },
        child: const Icon(Icons.add)
        ),
    );
  }


 Widget listTile(BuildContext context, index) {
  String nome = ModalRoute.of(context)?.settings.arguments as String;
    List<Eletronicos>? lista = eletronicosPorComodo[nome];
  Eletronicos d = lista![index];

  return ListTile(
    title: Text(d.nome), 
    subtitle: Text(d.potencia.toString()),
    trailing: const Icon(Icons.arrow_forward),
    onTap: () async {
      await Navigator.pushNamed(context, "", arguments: lista);
      setState(() {});
    }, 
  );
}
}