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
    String abertura,
    String fechamento,
    String descricao,
    String valor,
    String capacidade,
    bool acessibilidade,
    bool arCondicionado,
    bool projetor,
    bool quadroBranco,
    bool tv,
    bool videoconferencia,
    DateTime dtCriacao,
    List<Uint8List> imagens,
  ) async {
    var uidCoworking = AuthController().idUsuario();
    List<String> imagePaths = [];

    DocumentReference meetingRoomRef = _meetingRooms.doc();

    for (Uint8List imagem in imagens) {
      // Gera um UUID único para cada imagem
      final imageName = Uuid().v1();

      final imagePath =
          '/meeting_rooms_images/$uidCoworking/${meetingRoomRef.id}/$imageName.jpg';

      final ref =
          firebase_storage.FirebaseStorage.instance.ref().child(imagePath);

      try {
        await ref.putData(imagem,
            firebase_storage.SettableMetadata(contentType: 'image/jpeg'));

        final downloadUrl = await ref.getDownloadURL();

        imagePaths.add(downloadUrl);
      } catch (e) {
        print('Erro ao carregar a imagem: $e');
        return;
      }
    }

    try {
      await meetingRoomRef.set({
        'titulo': titulo,
        'UID_coworking': uidCoworking,
        'descricao': descricao,
        'valor': valor,
        'fotos': imagePaths,
        'hr_abertura': abertura,
        'hr_fechamento': fechamento,
        'cep': cep,
        'endereco': logradouro,
        'numero': numero,
        'cidade': cidade,
        'uf': uf,
        'complemento': complemento,
        'bairro': bairro,
        'quadro_branco': quadroBranco,
        'projetor': projetor,
        'ar_condicionado': arCondicionado,
        'tv': tv,
        'videoconferencia': videoconferencia,
        'acessibilidade': acessibilidade,
        // crair campo status e avisar bruno para atualizar diagraam de classe
        'criado_em': dtCriacao,
        'atualizado_em': dtCriacao,
        'capacidade': capacidade,
      });
      print('Sala de reunião adicionada com sucesso.');
    } catch (e) {
      print('Erro ao adicionar os dados da sala de reunião ao Firestore: $e');
    }
  }

  Stream<QuerySnapshot> getMeetingRooms() {
    return _meetingRooms.snapshots();
  }
}
