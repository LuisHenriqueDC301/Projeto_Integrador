import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loginteste.dart';
import 'package:flutter_application_1/models/models.dart';
import 'package:flutter_application_1/pages/Aparelho.dart';
import 'package:flutter_application_1/pages/Auth.dart';
import 'package:flutter_application_1/pages/cadastro.dart';
import 'package:flutter_application_1/pages/comodos.dart';
import 'package:flutter_application_1/pages/crud_eletronicos.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'HomePage.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

// Variável global
var initialroute = "";
Map<String, List<Eletronicos>> eletronicosPorComodo = {
  "Sala": [],
  "Quarto": [],
  "Lavanderia": [],
  "Cozinha": [],
  "Banheiro": [],
};

void main() async {
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  } else {
    databaseFactory = databaseFactoryFfi;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DCGE",
      debugShowCheckedModeBanner: false,
      home: const RoteadorTela(),
      /*
      initialRoute: 'roteadorTela',
      */

      routes: {
        "login": (context) => LoginView(),
        "cadastro": (context) => RegistroView(),
        'roteadorTela': (context) => RoteadorTela(),
        "HomePage": (context) => HomePage(),
        "comodos": (context) => HomeScreen(),
        "loginTeste": (context) => LoginTeste(),
        "aparelhos": (context) => AparelhoForm(),
        "Auth": (context) => SignInPage2(),
        "crud_eletro": (context) => CrudEletronicos()
      },
    );
  }
}

class RoteadorTela extends StatelessWidget {
  const RoteadorTela({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("VAMOO PRA HOMEPAGE");

            return HomePage(); //HomePage();
          } else {
            print("VAMO PRO CARROSEL");
            return SignInPage2();
          }
        });
  }
}
