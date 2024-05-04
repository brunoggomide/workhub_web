import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:workhub_web/src/controllers/auth/auth_controller.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

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

    _meetingRooms
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

  Future<MeetingRoom> getMeetingRoom(String id) async {
    try {
      final DocumentSnapshot docSnapshot = await _meetingRooms.doc(id).get();
      return MeetingRoom.fromJson(docSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print('Erro ao obter os dados da sala de reunião do Firestore: $e');
      throw e;
    }
  }

  Future<void> updateMeetingRoom(String meetingRoomId, MeetingRoom meetingRoom,
      List<Uint8List> imagens, context) async {
    deleteMeetingRoomImages(meetingRoom.UID_coworking, meetingRoomId);
    List<String> imagePaths = [];

    for (Uint8List imagem in imagens) {
      // Gera um UUID único para cada imagem
      final imageName = Uuid().v1();

      final imagePath =
          '/meeting_rooms_images/${meetingRoom.UID_coworking}/$meetingRoomId/$imageName.jpg';

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
        .doc(meetingRoomId)
        .update(meetingRoom.toJson())
        .then((value) =>
            sucesso(context, 'Sala de reunião atualizada com sucesso.'))
        .catchError((e) =>
            erro(context, 'Não foi possível atualizar a sala. Error: $e'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  Future<void> deleteMeetingRoom(
      String uidCoworking, String meetingRoomId) async {
    try {
      // Deleta as imagens da sala de reunião
      await deleteMeetingRoomImages(uidCoworking, meetingRoomId);

      // Deleta a sala de reunião
      await FirebaseFirestore.instance
          .collection('salas')
          .doc(meetingRoomId)
          .delete();
      print('Sala de reunião excluída com sucesso.');
    } catch (e) {
      print('Erro ao excluir a sala de reunião: $e');
      throw e;
    }
  }

  // Alternativa ao uso do Firebase Functions para deletar as imagens
  Future<void> deleteMeetingRoomImages(
      String uidCoworking, String roomId) async {
    final storage = FirebaseStorage.instance;
    final folderPath = 'meeting_rooms_images/$uidCoworking/$roomId';
    print(folderPath);

    final ListResult result = await storage.ref(folderPath).listAll();
    print(result.items);

    for (final Reference ref in result.items) {
      await ref.delete();
      print("imagem deletada");
    }
  }

  Future<List<Uint8List>> downloadImages(List<String> imageUrls) async {
    List<Uint8List> imageBytesList = [];

    for (String imageUrl in imageUrls) {
      try {
        final http.Response response = await http.get(Uri.parse(imageUrl));
        if (response.statusCode == 200) {
          final Uint8List imageBytes = response.bodyBytes;
          imageBytesList.add(imageBytes);
        } else {
          print('Erro ao baixar a imagem: ${response.statusCode}');
        }
      } catch (e) {
        print('Erro ao baixar a imagem: $e');
      }
    }

    return imageBytesList;
  }
}
