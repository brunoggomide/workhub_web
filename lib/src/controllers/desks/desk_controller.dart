import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';
import '../../models/desk_model.dart';
import '../../views/utils/env.dart';
import '../auth/auth_controller.dart';

class DeskController {
  adicionar(context, Desk ex) async {
    List<String> imageUrls = [];

    var uidCoworking = AuthController().idUsuario();

    DocumentReference deskRef =
        FirebaseFirestore.instance.collection('mesas').doc();

    for (Uint8List imagem in ex.imageFiles) {
      // Gera um UUID único para cada imagem
      final imageName = Uuid().v1();

      final imagePath =
          '/desks_images/$uidCoworking/${deskRef.id}/$imageName.jpg';

      final ref =
          firebase_storage.FirebaseStorage.instance.ref().child(imagePath);

      try {
        await ref.putData(imagem,
            firebase_storage.SettableMetadata(contentType: 'image/jpeg'));

        final downloadUrl = await ref.getDownloadURL();

        imageUrls.add(downloadUrl);
      } catch (e) {
        print('Erro ao carregar a imagem: $e');
        return;
      }
    }

    ex.fotos = imageUrls;

    FirebaseFirestore.instance
        .collection('mesas')
        .add(ex.toJson())
        .then((value) => sucesso(context, 'Mesa adicionado com sucesso.'))
        .catchError((e) => erro(context, 'Não foi possível adicionar o Mesa'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  void atualizar(context, String id, Desk ex) {
    FirebaseFirestore.instance
        .collection('mesas')
        .doc(id)
        .update(ex.toJson())
        .then((value) => sucesso(context, 'Mesa atualizada com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  listar() {
    return FirebaseFirestore.instance
        .collection('mesas')
        .where('UID_coworking', isEqualTo: AuthController().idUsuario())
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Desk.fromJson(doc.data())).toList();
    });
  }

  contarMesas() async {
    var uidCoworking = AuthController().idUsuario();
    int totalMesas = 0;

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('mesas')
          .where('UID_coworking', isEqualTo: uidCoworking)
          .get();

      for (var doc in querySnapshot.docs) {
        // Usar um cast para Map<String, dynamic>
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
}
