import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workhub_web/src/views/auth/login/loginPage.dart';
import 'package:workhub_web/src/views/base/sideBar.dart';
import 'package:workhub_web/src/views/homepage/homepage.dart';
import 'package:workhub_web/src/views/plans/planPage.dart';

import '../../views/utils/env.dart';

class AuthController {
  criarConta(context, nome, email, senha, documento, contato, plano, planoDesk,
      planoMeet) {
    //print('aqui');
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((res) {
      //Enviar confirmação do e-mail
      // res.user!.sendEmailVerification();

      FirebaseFirestore.instance.collection('empresas').add({
        'uid': res.user!.uid,
        'nome': nome,
        'email': email,
        'documento': documento,
        'contato': contato,
        'plano': plano,
        'planoDesk': planoDesk,
        'planoMeet': planoMeet,
      });

      // sucesso(context, 'Verifique seu e-mail para ativar seu cadastro');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: ((c) {
            return const LoginPage();
          }),
        ),
      );
    }).catchError((e) {
      switch (e.code) {
        case 'email-already-in-use':
          erro(context, 'O usuário já foi cadastrado.');
          break;
        case 'invalid-email':
          erro(context, 'O formato do e-mail é inválido.');
          break;
        default:
          erro(context, 'ERRO: ${e.code.toString()}');
      }
    });
  }

  login(context, email, senha) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((res) {
      // if (res.user!.emailVerified) {
      // sucesso(context, 'Usuário autenticado com sucesso!');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: ((c) {
            return const BaseScreen();
          }),
        ),
      );
    })
        // } else {
        //   erro(context, 'O endereço de e-mail não foi confirmado.');
        // }
        // })
        .catchError((e) {
      switch (e.code) {
        case 'user-not-found':
          erro(context, 'Usuário não encontrado.');
          break;
        case 'wrong-password':
          erro(context, 'Senha incorreta.');
          break;
        default:
          erro(context, 'ERRO: ${e.code.toString()}');
      }
    });
  }

  esqueceuSenha(context, String email) {
    if (email.isNotEmpty) {
      FirebaseAuth.instance
          .sendPasswordResetEmail(
        email: email,
      )
          .then((res) {
        sucesso(context, 'E-mail enviado com sucesso.');
      }).catchError((e) {
        switch (e.code) {
          case 'invalid-email':
            erro(context, 'O formato do email é inválido.');
            break;
          case 'user-not-found':
            erro(context, 'Usuário não encontrado.');
            break;
          default:
            erro(context, e.code.toString());
        }
      });
    }
  }

  logout(context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (c) {
          return const HomePage();
        },
      ),
    );
  }

  static Future<String?> getEmailByUid(String uid) async {
    try {
      // Buscar o documento do usuário pelo UID
      var document = await FirebaseFirestore.instance
          .collection('clientes')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      if (document.docs.isNotEmpty) {
        // Retornar o e-mail se o documento for encontrado
        return document.docs.first.data()['email'] as String?;
      } else {
        // Retornar nulo se nenhum documento for encontrado
        return null;
      }
    } catch (e) {
      // Tratar exceções, se necessário
      print('Erro ao buscar o e-mail: $e');
      return null;
    }
  }

  static Future<String?> getNumberByUid(String uid) async {
    try {
      // Buscar o documento do usuário pelo UID
      var document = await FirebaseFirestore.instance
          .collection('clientes')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      if (document.docs.isNotEmpty) {
        // Retornar o e-mail se o documento for encontrado
        return document.docs.first.data()['contato'] as String?;
      } else {
        // Retornar nulo se nenhum documento for encontrado
        return null;
      }
    } catch (e) {
      // Tratar exceções, se necessário
      print('Erro ao buscar o e-mail: $e');
      return null;
    }
  }

  idUsuario() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}
