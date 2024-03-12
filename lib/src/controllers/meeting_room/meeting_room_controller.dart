import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';
import 'package:workhub_web/src/controllers/auth/auth_controller.dart';

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
    bool bicicletario,
    bool espacoInterativo,
    bool estacionamento,
    bool cafe,
    DateTime dtCriacao,
    List<Uint8List> imagens,
  ) async {
    var uidCoworking = AuthController().idUsuario();
    List<String> imagePaths = [];

    for (Uint8List imagem in imagens) {
      var imageName = const Uuid().v1();
      String imagePath = '/meeting_rooms_photos/$uidCoworking/$imageName.jpg';
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref(imagePath);

      try {
        await ref.putData(imagem);
        imagePaths.add(imagePath);
      } catch (e) {
        print('Erro ao carregar a imagem: $e');
        return;
      }
    }

    try {
      await _meetingRooms.add({
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
        'bicicletario': bicicletario,
        'espacoInterativo': espacoInterativo,
        'estacionamento': estacionamento,
        'cafe': cafe,
        'dtCriacao': dtCriacao,
        'imagens': imagePaths,
      });
      print('Sala de reunião adicionada com sucesso.');
    } catch (e) {
      print('Erro ao adicionar os dados da sala de reunião ao Firestore: $e');
    }
  }
}
