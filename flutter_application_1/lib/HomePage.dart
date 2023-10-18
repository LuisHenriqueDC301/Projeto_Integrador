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
                "Sair",
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
                      fontSize: screenWidth < 600 ? 28 : 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                buildInputField(
                  "Qual o valor que você deseja pagar na conta de energia?",
                  Icons.attach_money,
                  valorController,
                  TextInputType.number,
                ),
                SizedBox(height: 20),
                buildInputField(
                  "Qual o consumo em kWh da sua última conta de energia?",
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
            // Se o formulário for válido, permitir a transição para a próxima página
            Navigator.pushNamed(context, "comodos");
          } else {
            // Se o formulário for inválido, você pode exibir uma mensagem de erro.
          }
        },
        backgroundColor: Colors.green,
        child: Icon(
          Icons.arrow_forward,
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
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blueGrey[100],
            borderRadius: BorderRadius.circular(10),
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
          ),
        ),
        // Exibe mensagem de erro
      ],
    );
  }
}
