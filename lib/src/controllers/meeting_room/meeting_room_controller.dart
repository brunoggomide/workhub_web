import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workhub_web/src/controllers/auth/auth_controller.dart';

class MeetingRoomController {
  final CollectionReference _meetingRooms =
      FirebaseFirestore.instance.collection('salas');

  addMeetingRoom(
    cep,
    logradouro,
    numero,
    bairro,
    complemento,
    uf,
    cidade,
    titulo,
    descricao,
    valor,
    capacidade,
    acessibilidade,
    arCondicionado,
    projetor,
    quadroBranco,
    tv,
    dtCriacao,
  ) {
    var uidCoworking = AuthController().idUsuario();
    _meetingRooms.add({
      'cep': cep,
      'logradouro': logradouro,
      'numero': numero,
      'bairro': bairro,
      'complemento': complemento,
      'uf': uf,
      'cidade': cidade,
      'titulo': titulo,
      'descricao': descricao,
      'valor': valor,
      'capacidade': capacidade,
      'uidCoworking': uidCoworking,
      'acessibilidade': acessibilidade,
      'arCondicionado': arCondicionado,
      'projetor': projetor,
      'quadroBranco': quadroBranco,
      'tv': tv,
      'dtCriacao': dtCriacao,
    });
  }
}
