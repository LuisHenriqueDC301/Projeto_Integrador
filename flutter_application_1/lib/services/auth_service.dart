import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  Future<String?> registrar(String nome, String email, String senha) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: senha);
      await userCredential.user!.updateDisplayName(nome);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'A senha é muito fraca!';
      } else if (e.code == 'email-already-in-use') {
        return 'Este email já está cadastrado';
      } else if (e.code == "invalid-email") {
        return "Email Invalido";
      }
      return "Erro Desconhecido";
    }
  }

  Future<String?> login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Email não encontrado. Cadastre-se.';
      } else if (e.code == 'wrong-password') {
        return 'Senha incorreta. Tente novamente';
      } else if (e.code == "invalid-login-credentials") {
        return "Credenciais de Login Invalidas";
      }
      return "Erro Desconhecido";
      print(e);
    }
    return null;
  }

  Future<void> logout() async {
    return _auth.signOut();
  }
}
