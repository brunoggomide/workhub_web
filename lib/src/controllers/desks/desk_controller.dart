import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/desk_model.dart';
import '../../views/utils/env.dart';

class DeskController {
  adicionar(context, Desk ex) {
    FirebaseFirestore.instance
        .collection('mesas')
        .add(ex.toJson())
        .then((value) => sucesso(context, 'Mesa adicionado com sucesso.'))
        .catchError((e) => erro(context, 'Não foi possível adicionar o Mesa'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  void atualizar(context, String id, Desk ex) {
    FirebaseFirestore.instance
        .collection('mesas')
        .doc(id)
        .update(ex.toJson())
        .then((value) => sucesso(context, 'Mesa atualizada com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  listar() {
    return FirebaseFirestore.instance.collection('mesas');
  }
}
