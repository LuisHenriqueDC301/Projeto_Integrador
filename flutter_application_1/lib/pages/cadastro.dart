import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../_comum/snackbar.dart';
import '../services/auth_service.dart';

class RegistroView extends StatefulWidget {
  @override
  _RegistroViewState createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  registrar() async {
    setState(() => loading = true);
    try {
      await context
          .read<AuthService>()
          .registrar(
              nomeController.text, emailController.text, senhaController.text)
          .then((String? erro) {
        if (erro != null) {
          // Com erro
          showSnackBar(context: context, texto: erro);
          setState(() => loading = false);
        } else {
          // Sem erro
          showSnackBar(
              context: context,
              texto: "Cadastro efetuado com sucesso",
              isErro: false);
        }
      });
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center, // Centraliza o conteúdo na tela
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth < 600 ? 20 : 40,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Bem vindo",
                          style: GoogleFonts.openSans(
                            fontSize: screenWidth < 600 ? 34 : 46,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Registro",
                        style: GoogleFonts.openSans(
                          fontSize: screenWidth < 600 ? 20 : 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Faça o registro para continuar",
                        style: TextStyle(
                          fontSize: screenWidth < 600 ? 12 : 15,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildSocialIcon(
                              FontAwesomeIcons.facebook, Colors.blue),
                          buildSocialIcon(
                              FontAwesomeIcons.google, Colors.yellow[700]!),
                          buildSocialIcon(
                              FontAwesomeIcons.instagramSquare, Colors.red),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        "ou faça com seu Email",
                        style: TextStyle(
                          fontSize: screenWidth < 600 ? 12 : 15,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 30),
                      buildInputField(
                        "nome",
                        "Nome Completo",
                        Icons.person,
                        nomeController,
                        TextInputType.text,
                      ),
                      SizedBox(height: 20),
                      buildInputField(
                        "email",
                        "Email",
                        Icons.email,
                        emailController,
                        TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20),
                      buildInputField(
                        "senha",
                        "Senha",
                        Icons.lock,
                        senhaController,
                        TextInputType.text,
                        isPassword: true,
                      ),
                      SizedBox(height: 30),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Visibility(
                            visible: !loading,
                            child: buildButton("Registro", Colors.green, () {
                              if (_formKey.currentState!.validate()) {
                                registrar();
                              }
                            }),
                          ),
                          Visibility(
                            visible: loading,
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      buildButton("Já tem conta? Fazer Login", Colors.green,
                          () async {
                        await Navigator.pushNamed(
                          context,
                          "login",
                        );
                      }),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField(String type, String label, IconData icon,
      TextEditingController controller, TextInputType keyboardType,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            obscureText: isPassword,
            controller: controller,
            onChanged: ((value) => ()),
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: label,
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              icon: Icon(icon),
            ),
            validator: (value) {
              if (type == "senha") {
                if (value!.isEmpty) {
                  return 'Digite uma senha válida';
                } else if (value.length < 6) {
                  return 'Sua senha deve ter no mínimo 6 caracteres';
                }
              } else if (type == "email") {
                if (value!.isEmpty) {
                  return 'Digite um email válido';
                }
              } else if (type == "nome") {
                if (value!.isEmpty) {
                  return 'Digite um nome válido';
                }
              }

              // Adicione validações personalizadas aqui, se necessário
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget buildButton(String label, Color color, VoidCallback onPressed) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 60,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: color,
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }

  Widget buildSocialIcon(IconData icon, Color iconColor) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}
