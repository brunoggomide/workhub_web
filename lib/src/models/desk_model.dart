import 'package:cloud_firestore/cloud_firestore.dart';

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
      this.uid,
      this.title,
      this.value_hour,
      this.num_tables,
      this.cep,
      this.address,
      this.num_address,
      this.city,
      this.uf,
      this.bairro,
      this.complemento,
      this.description,
      this.coffe,
      this.park,
      this.air,
      this.space,
      this.bike,
      this.accessibility,
      this.criado_em,
      this.atualizado_em,
      this.status);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'uid': uid,
      'title': title,
      'value_hour': value_hour,
      'num_tables': num_tables,
      'cep': cep,
      'address': address,
      'num_address': num_address,
      'city': city,
      'uf': uf,
      'bairro': bairro,
      'complemento': complemento,
      'description': description,
      'coffe': coffe,
      'park': park,
      'air': air,
      'space': space,
      'bike': bike,
      'accessibility': accessibility,
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
      json['uid'],
      json['title'],
      json['value_hour'],
      json['num_tables'],
      json['cep'],
      json['address'],
      json['num_address'],
      json['city'],
      json['uf'],
      json['bairro'],
      json['complemento'],
      json['description'],
      json['coffe'],
      json['park'],
      json['air'],
      json['space'],
      json['bike'],
      json['accessibility'],
      json['criado_em'],
      json['atualizado_em'],
      json['status'],
    );
  }
}
