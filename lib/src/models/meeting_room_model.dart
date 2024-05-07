import 'package:cloud_firestore/cloud_firestore.dart';

class MeetingRoom {
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
  final String? criado_em;
  final String? atualizado_em; // Excluir depois, nao precisa dessa variavel
  final String hr_abertura;
  final String hr_fechamento;

  MeetingRoom({
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
    this.criado_em,
    required this.atualizado_em,
    required this.hr_abertura,
    required this.hr_fechamento,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
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

    if (criado_em != null) {
      json['criado_em'] = criado_em;
    } else {
      json['criado_em'] = FieldValue.serverTimestamp();
    }

    return json;
  }

  factory MeetingRoom.fromJson(Map<String, dynamic> json) {
    return MeetingRoom(
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

  MeetingRoom copyWith({
    String? UID_coworking,
    String? titulo,
    String? valor,
    String? capacidade,
    String? cep,
    String? endereco,
    String? num_endereco,
    String? cidade,
    String? uf,
    String? bairro,
    String? complemento,
    String? descricao,
    List<String>? fotos,
    bool? projetor,
    bool? videoconferencia,
    bool? ar_condicionado,
    bool? quadro_branco,
    bool? tv,
    bool? acessibilidade,
    Timestamp? atualizado_em,
    Timestamp? criado_em,
    String? hr_abertura,
    String? hr_fechamento,
  }) {
    return MeetingRoom(
      UID_coworking: UID_coworking ?? this.UID_coworking,
      titulo: titulo ?? this.titulo,
      valor: valor ?? this.valor,
      capacidade: capacidade ?? this.capacidade,
      cep: cep ?? this.cep,
      endereco: endereco ?? this.endereco,
      num_endereco: num_endereco ?? this.num_endereco,
      cidade: cidade ?? this.cidade,
      uf: uf ?? this.uf,
      bairro: bairro ?? this.bairro,
      complemento: complemento ?? this.complemento,
      descricao: descricao ?? this.descricao,
      fotos: fotos ?? this.fotos,
      projetor: projetor ?? this.projetor,
      videoconferencia: videoconferencia ?? this.videoconferencia,
      ar_condicionado: ar_condicionado ?? this.ar_condicionado,
      quadro_branco: quadro_branco ?? this.quadro_branco,
      tv: tv ?? this.tv,
      acessibilidade: acessibilidade ?? this.acessibilidade,
      atualizado_em: atualizado_em?.toDate().toString() ?? this.atualizado_em,
      criado_em: criado_em?.toDate().toString() ?? this.criado_em,
      hr_abertura: hr_abertura ?? this.hr_abertura,
      hr_fechamento: hr_fechamento ?? this.hr_fechamento,
    );
  }
}
