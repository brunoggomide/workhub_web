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

  void atualizar(context, String id, UsuarioModel ex) {
    FirebaseFirestore.instance
        .collection('empresas')
        .doc(id)
        .update(ex.toJson())
        .then((value) => sucesso(context, 'Atualizado com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'));
  }
}
