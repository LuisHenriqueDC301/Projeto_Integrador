import 'package:flutter/material.dart';
import 'package:flutter_application_1/_comum/snackbar.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class SignInPage2 extends StatefulWidget {
  const SignInPage2({Key? key}) : super(key: key);

  @override
  State<SignInPage2> createState() => _SignInPage2State();
}

class _SignInPage2State extends State<SignInPage2> {
    Widget build(BuildContext context) {
     final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Scaffold(
        body: Center(
            child: isSmallScreen
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      _Logo(),
                      _FormContent(),
                    ],
                  )
                : Container(
                    padding: const EdgeInsets.all(32.0),
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Row(
                      children: const [
                        Expanded(child: _Logo()),
                        Expanded(
                          child: Center(child: _FormContent()),
                        ),
                      ],
                    ),
                  )));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/logo.png',height: 50,),
          //FlutterLogo(size: isSmallScreen ? 50 : 100),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Bem Vindo ao DCGE",
              textAlign: TextAlign.center,
              style: isSmallScreen
                  ? Theme.of(context).textTheme.headline5
                  : Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Colors.black),
            ),
          )
        ],
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
  
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  late String titulo;
  late String actionButton;
  String  toggleButton = "";  
  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;
  bool loading = false;



  login() async {
    setState(() => loading = true);
    try {
      await AuthService()
          .login(emailController.text, senhaController.text)
          .then((String? erro) {
        if (erro != null) {
          // Com erro
          setState(() => loading = false);
          showSnackBar(context: context, texto: erro);
        }
      });
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

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
  void initState() { 
    super.initState();
    setFormAction(true);
  }
  setFormAction(bool acao) {
    setState(() {
      isLogin = acao;
      if (isLogin) {
        actionButton = 'Login';
        toggleButton = 'Não tem Login? Registrar';
      } else {
        actionButton = 'Cadastrar';
        toggleButton = 'Já tem conta? Logar';
      }
    });
  }

  bool _isPasswordVisible = false;
  bool _rememberMe = false;




  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Form(
          key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                            visible: !isLogin,
                            child: Column(children: [
                              _gap(),
                              TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Selecione seu nome',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  controller: nomeController
                ),
                _gap()
                            ]
                          ),
                ),
                TextFormField(
                  validator: (value) {
                    // add email validation
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira algum texto';
                    }
              
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);
                    if (!emailValid) {
                      return 'Por favor digite um email válido';
                    }
              
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Coloque seu email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  controller: emailController
                ),
                _gap(),
                TextFormField(
                  controller: senhaController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira algum texto';
                    }
              
                    if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                      labelText: 'Senha',
                      hintText: 'Coloque sua senha',
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      )),
                ),
                _gap(),
                CheckboxListTile(
                  value: _rememberMe,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _rememberMe = value;
                    });
                  },
                  title: const Text('Lembre de mim'),
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                  contentPadding: const EdgeInsets.all(0),
                ),
                _gap(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child:  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        actionButton,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                         isLogin ? login() : registrar();
                      }
                    },
                  ),
                ),
                 _gap(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child:  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        toggleButton,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () {
                        setFormAction(!isLogin);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget _gap() => const SizedBox(height: 16);
}
