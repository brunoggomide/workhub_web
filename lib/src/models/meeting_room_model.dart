import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MeetingRoom {
  final String? id;
  final String UID_coworking;
  final String titulo;
  final String valor;
  final String capacidade;
  final String cep;
  final String endereco;
  final String num_endereco;
  final String cidade;
  final String uf;
  final String bairro;
  final String complemento;
  final String descricao;
  List<String> fotos;
  final bool projetor;
  final bool videoconferencia;
  final bool ar_condicionado;
  final bool quadro_branco;
  final bool tv;
  final bool acessibilidade;
  final String criado_em;
  final String atualizado_em;
  final String hr_abertura;
  final String hr_fechamento;

  MeetingRoom(
      {this.id,
      required this.UID_coworking,
      required this.titulo,
      required this.valor,
      required this.capacidade,
      required this.cep,
      required this.endereco,
      required this.num_endereco,
      required this.cidade,
      required this.uf,
      required this.bairro,
      required this.complemento,
      required this.descricao,
      this.fotos = const [],
      required this.projetor,
      required this.videoconferencia,
      required this.ar_condicionado,
      required this.quadro_branco,
      required this.tv,
      required this.acessibilidade,
      required this.criado_em,
      required this.atualizado_em,
      required this.hr_abertura,
      required this.hr_fechamento,});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'id': id,
      'UID_coworking': UID_coworking,
      'titulo': titulo,
      'valor': valor,
      'capacidade': capacidade,
      'cep': cep,
      'endereco': endereco,
      'num_endereco': num_endereco,
      'cidade': cidade,
      'uf': uf,
      'bairro': bairro,
      'complemento': complemento,
      'descricao': descricao,
      'fotos': fotos,
      'projetor': projetor,
      'videoconferencia': videoconferencia,
      'ar_condicionado': ar_condicionado,
      'quadro_branco': quadro_branco,
      'tv': tv,
      'acessibilidade': acessibilidade,
      'atualizado_em': FieldValue.serverTimestamp(),
      'hr_abertura': hr_abertura,
      'hr_fechamento': hr_fechamento,
    };

    if (criado_em != null && criado_em.isNotEmpty) {
      json['criado_em'] = FieldValue.serverTimestamp();
    }

    return json;
  }

  factory MeetingRoom.fromJson(Map<String, dynamic> json) {
    return MeetingRoom(
    id: json['id'] ?? '',
    UID_coworking: json['UID_coworking'] ?? '',
    titulo: json['titulo'] ?? '',
    valor: json['valor'] ?? '',
    capacidade: json['capacidade'] ?? '',
    cep: json['cep'] ?? '',
    endereco: json['endereco'] ?? '',
    num_endereco: json['num_endereco'] ?? '',
    cidade: json['cidade'] ?? '',
    uf: json['uf'] ?? '',
    bairro: json['bairro'] ?? '',
    complemento: json['complemento'] ?? '',
    descricao: json['descricao'] ?? '',
    fotos: List<String>.from(json['fotos'] ?? []),
    projetor: json['projetor'] ?? false,
    videoconferencia: json['videoconferencia'] ?? false,
    ar_condicionado: json['ar_condicionado'] ?? false,
    quadro_branco: json['quadro_branco'] ?? false,
    tv: json['tv'] ?? false,
    acessibilidade: json['acessibilidade'] ?? false,
    criado_em: json['criado_em'] is Timestamp
        ? (json['criado_em'] as Timestamp).toDate().toString()
        : json['criado_em'] ?? '',
    atualizado_em: json['atualizado_em'] is Timestamp
        ? (json['atualizado_em'] as Timestamp).toDate().toString()
        : json['atualizado_em'] ?? '',
    hr_abertura: json['hr_abertura'] ?? '',
    hr_fechamento: json['hr_fechamento'] ?? '',
  );
  }
}
