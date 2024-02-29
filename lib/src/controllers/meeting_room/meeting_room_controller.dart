import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart'; // Certifique-se de adicionar o pacote uuid ao seu pubspec.yaml
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
    DateTime dtCriacao,
    Uint8List imagem,
  ) async {
    // Gera um nome único para a imagem baseado em UUID
    var imageName = const Uuid().v1(); // Gera um UUID v1
    var uidCoworking = AuthController().idUsuario();
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('/meeting_rooms_photos/$uidCoworking/$imageName.jpg');

    String downloadURL = '';
    try {
      // Carrega o arquivo
      await ref.putData(imagem);

      // Obtém a URL de download
      downloadURL =
          await ref.getDownloadURL().timeout(const Duration(seconds: 10));
    } catch (e) {
      print('Erro ao carregar a imagem ou obter a URL: $e');
      return; // Encerra a função se não conseguir carregar a imagem ou obter a URL
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
        'dtCriacao': dtCriacao,
        'imagem': downloadURL,
      });
      print('Sala de reunião adicionada com sucesso.');
    } catch (e) {
      print('Erro ao adicionar os dados da sala de reunião ao Firestore: $e');
    }
  }
}
