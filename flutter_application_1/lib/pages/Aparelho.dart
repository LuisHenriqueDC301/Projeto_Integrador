import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/models.dart';

class AparelhoForm extends StatefulWidget {
  @override
  _AparelhoFormState createState() => _AparelhoFormState();
}

class _AparelhoFormState extends State<AparelhoForm> {
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: isSmallScreen
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  _FormContent(),
                ],
              )
            : Container(
                padding: const EdgeInsets.all(32.0),
                constraints: const BoxConstraints(maxWidth: 800),
                child: Row(
                  children: const [
                    Expanded(
                      child: Center(child: _FormContent()),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();
  TextEditingController tempoUsoController = TextEditingController();
  TextEditingController potenciaController = TextEditingController();
  TextEditingController diasUsoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedTimeUnit = 'Horas por dia';

  final _numberInputFormatter = FilteringTextInputFormatter.digitsOnly;

  @override
  Widget build(BuildContext context) {
    String nome = ModalRoute.of(context)?.settings.arguments as String;
    print(nome);
    List<Eletronicos>? lista = eletronicosPorComodo[nome];

    return SingleChildScrollView(
      reverse: false,
      child: Container(
        width: 350,
        height: 550,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _gap(),
                Text(
                  "Nome do Aparelho:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  controller: nomeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome do aparelho';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Ex: Televisão',
                    hintText: 'Coloque o nome do aparelho',
                    prefixIcon: Icon(Icons.tv),
                    border: OutlineInputBorder(),
                  ),
                ),
                _gap(),
                Text(
                  "Quantidade:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  controller: quantidadeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a quantidade';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Ex 1',
                    hintText: 'Insira a quantidade',
                    prefixIcon: Icon(Icons.format_list_numbered),
                    border: OutlineInputBorder(),
                  ),
                  inputFormatters: [_numberInputFormatter],
                ),
                _gap(),
                Text(
                  "Tempo de Uso:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  controller: tempoUsoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o tempo de uso';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Ex 8',
                    hintText: 'Insira o tempo de uso',
                    prefixIcon: Icon(Icons.access_time),
                    border: OutlineInputBorder(),
                  ),
                  inputFormatters: [_numberInputFormatter],
                ),
                _gap(),
                Text(
                  "Potência:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: potenciaController,
                        inputFormatters: [_numberInputFormatter],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a potência';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Ex 220W',
                          hintText: 'Insira a potência',
                          prefixIcon: Icon(Icons.flash_on),
                          border: OutlineInputBorder(),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              value: selectedTimeUnit,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedTimeUnit = newValue!;
                                });
                              },
                              items: <String>[
                                'Horas por dia',
                                'Minutos por dia'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _gap(),
                TextFormField(
                  controller: diasUsoController,
                  inputFormatters: [_numberInputFormatter],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira outra informação';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Dias de Uso por Mês',
                    hintText: 'Dias de Uso por Mês',
                    prefixIcon: Icon(Icons.info),
                    border: OutlineInputBorder(),
                  ),
                ),
                _gap(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Adicionar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          lista?.add(Eletronicos(
                            nome: nomeController.text,
                            potencia: int.parse(potenciaController.text),
                            tempoUso: int.parse(tempoUsoController.text),
                            diasUso: int.parse(diasUsoController.text),
                            quantidade: int.parse(quantidadeController.text),
                          ));
                        });
                       Navigator.pushNamed(context, "comodos");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
