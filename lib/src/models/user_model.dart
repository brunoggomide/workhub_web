import 'package:cloud_firestore/cloud_firestore.dart';

class EmpresaModel {
  final String nome;
  final String email;
  final String documento;
  final String contato;
  final String plano;
  final int planoDesk;
  final int planoMeet;
  final String criado_em;
  final String atualizado_em;

  EmpresaModel(
    this.nome,
    this.email,
    this.documento,
    this.contato,
    this.plano,
    this.planoDesk,
    this.planoMeet,
    this.criado_em,
    this.atualizado_em,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'nome': nome,
      'email': email,
      'documento': documento,
      'contato': contato,
      'plano': plano,
      'planoDesk': planoDesk,
      'planoMeet': planoMeet,
      'atualizado_em': FieldValue.serverTimestamp(),
    };
    if (criado_em != null && criado_em.isNotEmpty) {
      json['criado_em'] = FieldValue.serverTimestamp();
    }
    return json;
  }

  factory EmpresaModel.fromJson(Map<String, dynamic> json) {
    return EmpresaModel(
      json['nome'],
      json['email'],
      json['documento'],
      json['contato'],
      json['plano'],
      json['planoDesk'],
      json['planoMeet'],
      json['criado_em'],
      json['atualizado_em'],
    );
  }
}
