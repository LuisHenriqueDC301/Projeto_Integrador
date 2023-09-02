import 'package:flutter/material.dart';
import 'package:flutter_application_1/cadastro.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/TelasIniciais.dart';
import 'package:flutter_application_1/pages/carrosel.dart';

// Variável global
var initialroute = "";

void main() {
  runApp(MyApp());
  bool login = false;
  // Sem var aqui
  if (login == false) {
    initialroute = "Carrosel";
  } else {
    initialroute = "login";
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DCGE",
      debugShowCheckedModeBanner: false,
      initialRoute: initialroute,
      routes: {
        "Carrosel": (context) => CarouselPage(),
        "TelasIniciais": (context) => TelasIniciais(),
        "login": (context) => LoginView(),
        "cadastro": (context) => RegistroView()
      },
    );
  }
}
