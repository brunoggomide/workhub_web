import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:workhub_web/src/controllers/auth/auth_controller.dart';

import '../../models/meeting_room_model.dart';
import '../../views/utils/env.dart';

class MeetingRoomController {
  final CollectionReference _meetingRooms =
      FirebaseFirestore.instance.collection('salas');

  Future<void> addMeetingRoom(
      MeetingRoom meetingRoom, List<Uint8List> imagens, context) async {
    List<String> imagePaths = [];

    DocumentReference meetingRoomRef = _meetingRooms.doc();

    for (Uint8List imagem in imagens) {
      // Gera um UUID único para cada imagem
      final imageName = Uuid().v1();

      final imagePath =
          '/meeting_rooms_images/${meetingRoom.UID_coworking}/${meetingRoomRef.id}/$imageName.jpg';

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

    meetingRoom.fotos = imagePaths;

    FirebaseFirestore.instance
        .collection('salas')
        .add(meetingRoom.toJson())
        .then((value) =>
            sucesso(context, 'Sala de reunião adicionada com sucesso.'))
        .catchError((e) =>
            erro(context, 'Não foi possível adicionar a sala. Error: $e'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  Stream<QuerySnapshot> getMeetingRooms() {
    return _meetingRooms.snapshots();
  }

  Stream<int> contarSalas() {
    var uidCoworking = AuthController().idUsuario();
    try {
      return FirebaseFirestore.instance
          .collection('salas')
          .where('UID_coworking', isEqualTo: uidCoworking)
          .snapshots()
          .map((snapshot) => snapshot.size);
    } catch (e) {
      print('Erro ao contar salas: $e');
      throw e;
    }
  }

  Future<DocumentSnapshot> getMeetingRoom(String id) async {
    try {
      final DocumentSnapshot meetingRoom = await _meetingRooms.doc(id).get();
      print(meetingRoom.data());
      return meetingRoom;
    } catch (e) {
      print('Erro ao obter os dados da sala de reunião do Firestore: $e');
      throw e;
    }
  }
}
