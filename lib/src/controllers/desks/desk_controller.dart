import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import '../../models/desk_model.dart';
import '../../views/utils/env.dart';
import '../auth/auth_controller.dart';

class DeskController {
  final CollectionReference _desks =
      FirebaseFirestore.instance.collection('mesas');

  Future<void> addDesk(Desk desk, List<Uint8List> imagens, context) async {
    List<String> imagePaths = [];

    DocumentReference deskRef = _desks.doc();

    for (Uint8List imagem in imagens) {
      // Gera um UUID único para cada imagem
      final imageName = Uuid().v1();

      final imagePath =
          '/desks_images/${desk.UID_coworking}/${deskRef.id}/$imageName.jpg';

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

    desk.fotos = imagePaths;

    _desks
        .add(desk.toJson())
        .then((value) => sucesso(context, 'Mesa adicionada com sucesso.'))
        .catchError((e) =>
            erro(context, 'Não foi possível adicionar a mesa. Error: $e'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  /*void atualizar(context, String id, Desk ex) {
    FirebaseFirestore.instance
        .collection('mesas')
        .doc(id)
        .update(ex.toJson())
        .then((value) => sucesso(context, 'Mesa atualizada com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'))
        .whenComplete(() => Navigator.of(context).pop());
  }*/

  Stream<QuerySnapshot> getDesks() {
    return _desks
        .where('UID_coworking', isEqualTo: AuthController().idUsuario())
        .snapshots();
  }

  Future<int> contarMesas() async {
    var uidCoworking = AuthController().idUsuario();
    int totalMesas = 0;

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('mesas')
          .where('UID_coworking', isEqualTo: uidCoworking)
          .get();

      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        String numMesasStr = data['num_mesas'] ?? '0';
        int numMesas = int.tryParse(numMesasStr) ?? 0;
        totalMesas += numMesas;
      }
    } catch (e) {
      print('Erro ao contar mesas: $e');
    }

    return totalMesas;
  }

  Future<Desk> getDesk(String id) async {
    try {
      final DocumentSnapshot docSnapshot = await _desks.doc(id).get();
      return Desk.fromJson(docSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print('Erro ao obter os dados da mesa no no banco de dados: Error $e');
      throw e;
    }
  }

  Future<void> updateDesk(
      String deskId, Desk desk, List<Uint8List> imagens, context) async {
    deleteDeskImages(desk.UID_coworking, deskId);
    List<String> imagePaths = [];

    for (Uint8List imagem in imagens) {
      // Gera um UUID único para cada imagem
      final imageName = Uuid().v1();

      final imagePath =
          '/desks_images/${desk.UID_coworking}/$deskId/$imageName.jpg';

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

    desk.fotos = imagePaths;

    _desks
        .doc(deskId)
        .update(desk.toJson())
        .then((value) => sucesso(context, 'Mesa atualizada com sucesso.'))
        .catchError((e) =>
            erro(context, 'Não foi possível atualizar a mesa. Error: $e'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  Future<void> deleteDesk(String uidCoworking, String deskId) async {
    try {
      // Deleta as imagens da mesa
      await deleteDeskImages(uidCoworking, deskId);

      // Deleta a mesa
      await _desks.doc(deskId).delete();
      print('Mesa excluída com sucesso.');
    } catch (e) {
      print('Erro ao excluir a mesa: Error: $e');
      throw e;
    }
  }

  // Alternativa ao uso do Firebase Functions para deletar as imagens
  Future<void> deleteDeskImages(String uidCoworking, String deskId) async {
    final storage = FirebaseStorage.instance;
    final folderPath = 'desks_images/$uidCoworking/$deskId';

    final ListResult result = await storage.ref(folderPath).listAll();

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
