import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workhub_web/src/controllers/auth/auth_controller.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class MeetingRoomController {
  final CollectionReference _meetingRooms =
      FirebaseFirestore.instance.collection('salas');

  Future<void> addMeetingRoom(
    String cep,
    String logradouro,
    String numero,
    String bairro,
    String complemento,
    String uf,
    String cidade,
    String titulo,
    String descricao,
    double valor,
    int capacidade,
    bool acessibilidade,
    bool arCondicionado,
    bool projetor,
    bool quadroBranco,
    bool tv,
    DateTime dtCriacao,
    Uint8List imagem,
    String imageName,
  ) async {
    // Cria uma referência para o arquivo que você quer carregar
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref('/images/$imageName');

    // Carrega o arquivo
    await ref.putData(imagem);

    // Obtém a URL de download
    String downloadURL = await ref.getDownloadURL();

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
      'imagem': downloadURL,
    });
  }
}
