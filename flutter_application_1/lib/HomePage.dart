import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final valorController = TextEditingController();
  final consumoController = TextEditingController();
  final valorTotalController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    valorController.dispose();
    consumoController.dispose();
    valorTotalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela Inicial"),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                AuthService().logout();
              },
            )
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Seja bem-vindo(a) ao DCGE! Vamos começar?",
                    style: GoogleFonts.openSans(
                      fontSize: screenWidth < 600 ? 24 : 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                buildInputField(
                  "Qual valor você gostaria de pagar em sua conta de energia?",
                  Icons.attach_money,
                  valorController,
                  TextInputType.number,
                ),
                SizedBox(height: 20),
                buildInputField(
                  "Qual o valor do consumo em kWh da sua última conta de energia?",
                  Icons.electric_bolt,
                  consumoController,
                  TextInputType.number,
                ),
                SizedBox(height: 30),
                buildInputField(
                  "Qual o valor total da sua última conta de energia?",
                  Icons.monetization_on,
                  valorTotalController,
                  TextInputType.number,
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState?.validate() == true) {
            // O formulário é válido, permita a transição para a próxima página
            Navigator.pushNamed(context, "comodos");
          } else {
            // O formulário é inválido, não permita a transição
            // ou exiba uma mensagem de erro ao usuário, se desejar.
          }
        },
        backgroundColor: Colors.green,
        child: Icon(
          Icons.play_arrow,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildInputField(
    String label,
    IconData icon,
    TextEditingController controller,
    TextInputType keyboardType,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blueGrey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: "Insira o valor aqui",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              icon: Icon(icon, color: Colors.green),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Digite um valor válido';
              }
              return null;
            },
          ),
        ),
        // Exibe mensagem de erro
        Text(
          _formKey.currentState?.validate() == true ? '' : 'Campo obrigatório',
          style: TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
