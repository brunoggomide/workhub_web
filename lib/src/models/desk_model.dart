import 'package:cloud_firestore/cloud_firestore.dart';

class Desk {
  final String UID_coworking;
  final String titulo;
  final String valor;
  final String num_mesas;
  final String cep;
  final String endereco;
  final String num_endereco;
  final String cidade;
  final String uf;
  final String bairro;
  final String complemento;
  final String descricao;
  List<String> fotos;
  final bool cafe;
  final bool estacionamento;
  final bool ar_condicionado;
  final bool espaco_interativo;
  final bool bicicletario;
  final bool acessibilidade;
  final String? criado_em;
  final String? atualizado_em;
  final bool status; /////////////// nao esquecer---------------------------
  final String hr_abertura;
  final String hr_fechamento;

  Desk(
      {required this.UID_coworking,
      required this.titulo,
      required this.valor,
      required this.num_mesas,
      required this.cep,
      required this.endereco,
      required this.num_endereco,
      required this.cidade,
      required this.uf,
      required this.bairro,
      required this.complemento,
      required this.descricao,
      this.fotos = const [],
      required this.cafe,
      required this.estacionamento,
      required this.ar_condicionado,
      required this.espaco_interativo,
      required this.bicicletario,
      required this.acessibilidade,
      this.criado_em,
      required this.atualizado_em,
      required this.status,
      required this.hr_abertura,
      required this.hr_fechamento});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'UID_coworking': UID_coworking,
      'titulo': titulo,
      'valor': valor,
      'num_mesas': num_mesas,
      'cep': cep,
      'endereco': endereco,
      'num_endereco': num_endereco,
      'cidade': cidade,
      'uf': uf,
      'bairro': bairro,
      'complemento': complemento,
      'descricao': descricao,
      'fotos': fotos,
      'cafe': cafe,
      'estacionamento': estacionamento,
      'ar_condicionado': ar_condicionado,
      'espaco_interativo': espaco_interativo,
      'bicicletario': bicicletario,
      'acessibilidade': acessibilidade,
      'atualizado_em': FieldValue.serverTimestamp(),
      'status': status,
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

  factory Desk.fromJson(Map<String, dynamic> json) {
    return Desk(
      UID_coworking: json['UID_coworking'] ?? '',
      titulo: json['titulo'] ?? '',
      valor: json['valor'] ?? '',
      num_mesas: json['num_mesas'] ?? '',
      cep: json['cep'] ?? '',
      endereco: json['endereco'] ?? '',
      num_endereco: json['num_endereco'] ?? '',
      cidade: json['cidade'] ?? '',
      uf: json['uf'] ?? '',
      bairro: json['bairro'] ?? '',
      complemento: json['complemento'] ?? '',
      descricao: json['descricao'] ?? '',
      fotos: List<String>.from(json['fotos'] ?? []),
      cafe: json['cafe'] ?? false,
      estacionamento: json['estacionamento'] ?? false,
      ar_condicionado: json['ar_condicionado'] ?? false,
      espaco_interativo: json['espaco_interativo'] ?? false,
      bicicletario: json['bicicletario'] ?? false,
      acessibilidade: json['acessibilidade'] ?? false,
      status: json['status'] ?? false,
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

  Desk copyWith({
    String? UID_coworking,
    String? titulo,
    String? valor,
    String? num_mesas,
    String? cep,
    String? endereco,
    String? num_endereco,
    String? cidade,
    String? uf,
    String? bairro,
    String? complemento,
    String? descricao,
    List<String>? fotos,
    bool? cafe,
    bool? estacionamento,
    bool? ar_condicionado,
    bool? espaco_interativo,
    bool? bicicletario,
    bool? acessibilidade,
    Timestamp? atualizado_em,
    Timestamp? criado_em,
    bool? status,
    String? hr_abertura,
    String? hr_fechamento,
  }) {
    return Desk(
      UID_coworking: UID_coworking ?? this.UID_coworking,
      titulo: titulo ?? this.titulo,
      valor: valor ?? this.valor,
      num_mesas: num_mesas ?? this.num_mesas,
      cep: cep ?? this.cep,
      endereco: endereco ?? this.endereco,
      num_endereco: num_endereco ?? this.num_endereco,
      cidade: cidade ?? this.cidade,
      uf: uf ?? this.uf,
      bairro: bairro ?? this.bairro,
      complemento: complemento ?? this.complemento,
      descricao: descricao ?? this.descricao,
      fotos: fotos ?? this.fotos,
      cafe: cafe ?? this.cafe,
      estacionamento: estacionamento ?? this.estacionamento,
      ar_condicionado: ar_condicionado ?? this.ar_condicionado,
      espaco_interativo: espaco_interativo ?? this.espaco_interativo,
      bicicletario: bicicletario ?? this.bicicletario,
      acessibilidade: acessibilidade ?? this.acessibilidade,
      atualizado_em: atualizado_em?.toDate().toString() ?? this.atualizado_em,
      criado_em: criado_em?.toDate().toString() ?? this.criado_em,
      status: status ?? this.status,
      hr_abertura: hr_abertura ?? this.hr_abertura,
      hr_fechamento: hr_fechamento ?? this.hr_fechamento,
    );
  }
}
