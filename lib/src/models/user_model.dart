import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioModel {
  final String uid;
  final String nome;
  final String contato;
  final String plano;
  final int planoDesk;
  final int planoMeet;
  final String atualizado_em;

  UsuarioModel(
    this.uid,
    this.nome,
    this.contato,
    this.plano,
    this.planoDesk,
    this.planoMeet,
    this.atualizado_em,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'uid': uid,
      'nome': nome,
      'contato': contato,
      'plano': plano,
      'planoDesk': planoDesk,
      'planoMeet': planoMeet,
      'atualizado_em': FieldValue.serverTimestamp(),
    };
    return json;
  }

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      json['uid'],
      json['nome'],
      json['contato'],
      json['plano'],
      json['planoDesk'],
      json['planoMeet'],
      json['atualizado_em'],
    );
  }
}
