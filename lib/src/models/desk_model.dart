import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Desk {
  final String uid;
  final String title;
  final String value_hour;
  final String num_tables;
  final String cep;
  final String address;
  final String num_address;
  final String city;
  final String uf;
  final String bairro;
  final String complemento;
  final String description;
  final List<Uint8List> imageFiles;
  List<String> imageUrls;
  final bool coffe;
  final bool park;
  final bool air;
  final bool space;
  final bool bike;
  final bool accessibility;
  final String criado_em;
  final String atualizado_em;
  final bool status;

  Desk(
      {required this.uid,
      required this.title,
      required this.value_hour,
      required this.num_tables,
      required this.cep,
      required this.address,
      required this.num_address,
      required this.city,
      required this.uf,
      required this.bairro,
      required this.complemento,
      required this.description,
      required this.imageFiles,
      this.imageUrls = const [],
      required this.coffe,
      required this.park,
      required this.air,
      required this.space,
      required this.bike,
      required this.accessibility,
      required this.criado_em,
      required this.atualizado_em,
      required this.status});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'UID_coworking': uid,
      'titulo': title,
      'valor': value_hour,
      'num_mesas': num_tables,
      'cep': cep,
      'address': address,
      'num_endereco': num_address,
      'cidade': city,
      'uf': uf,
      'bairro': bairro,
      'complemento': complemento,
      'descricao': description,
      'fotos': imageUrls,
      'cafe': coffe,
      'estacionamento': park,
      'ar_condicionado': air,
      'espaco_interativo': space,
      'bicicletario': bike,
      'acessibilidade': accessibility,
      'atualizado_em': FieldValue.serverTimestamp(),
      'status': status,
    };

    if (criado_em != null && criado_em.isNotEmpty) {
      json['criado_em'] = FieldValue.serverTimestamp();
    }

    return json;
  }

  factory Desk.fromJson(Map<String, dynamic> json) {
    return Desk(
      uid: json['UID_coworking'],
      title: json['titulo'],
      value_hour: json['valor'],
      num_tables: json['num_mesas'],
      cep: json['cep'],
      address: json['address'],
      num_address: json['num_endereco'],
      city: json['cidade'],
      uf: json['uf'],
      bairro: json['bairro'],
      complemento: json['complemento'],
      description: json['descricao'],
      imageFiles: [], // Inicialize imageFiles como uma lista vazia
      imageUrls: List<String>.from(json['fotos'] ?? []),
      coffe: json['cafe'],
      park: json['estacionamento'],
      air: json['ar_condicionado'],
      space: json['espaco_interativo'],
      bike: json['bicicletario'],
      accessibility: json['acessibilidade'],
      status: json['status'],
      criado_em: json['criado_em'],
      atualizado_em: json['atualizado_em'],
    );
  }
}
