import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workhub_web/src/controllers/auth/auth_controller.dart';

import '../../models/user_model.dart';
import '../../views/utils/env.dart';

class UserController {
  getData() {
    return FirebaseFirestore.instance
        .collection('empresas')
        .where('uid', isEqualTo: AuthController().idUsuario());
  }

  getPlanDesk() async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('empresas')
          .where('uid', isEqualTo: AuthController().idUsuario())
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var document = querySnapshot.docs.first;

        return document.data()['planoDesk'] as int;
      } else {
        return 'Plano não encontrado';
      }
    } catch (e) {
      return 'Erro ao buscar o plano: $e';
    }
  }

  getPlanMeet() async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('empresas')
          .where('uid', isEqualTo: AuthController().idUsuario())
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var document = querySnapshot.docs.first;

        return document.data()['planoMeet'] as int;
      } else {
        return 'Plano não encontrado';
      }
    } catch (e) {
      return 'Erro ao buscar o plano: $e';
    }
  }

  void atualizar(context, String id, UsuarioModel ex) {
    FirebaseFirestore.instance
        .collection('empresas')
        .doc(id)
        .update(ex.toJson())
        .then((value) => sucesso(context, 'Atualizado com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'));
  }
}
