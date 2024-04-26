import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BookingDao {
  // Stream<QuerySnapshot> listarConfirmados(String id) {
  //   return FirebaseFirestore.instance
  //       .collection('reservas')
  //       .where('uid_empresa', isEqualTo: id)
  //       .where('status', isEqualTo: 'Finalizado')
  //       .snapshots();
  // }

  Stream<QuerySnapshot> listarConfirmados(String userId) {
    var now = DateTime.now();
    var tomorrow = now.subtract(Duration(days: 1));
    var ref = FirebaseFirestore.instance.collection('reservas');
    return ref
        .where('uid_empresa', isEqualTo: userId)
        .where('status', isEqualTo: 'Confirmado')
        .snapshots()
        .asyncMap((snapshot) async {
      for (var doc in snapshot.docs) {
        DateTime bookingDate = DateFormat('dd/MM/yyyy').parse(doc['data']);
        if (bookingDate.isBefore(tomorrow)) {
          await doc.reference.update({'status': 'Finalizado'});
        }
      }
      return snapshot;
    });
  }

  listarPorDia(String id, String selectedDate) {
    return FirebaseFirestore.instance
        .collection('reservas')
        .where('uid_empresa', isEqualTo: id)
        .where('status', isEqualTo: 'Confirmado')
        .where('data', isEqualTo: selectedDate)
        .snapshots();
  }

  static Future<String?> getEmailByUid(String uid) async {
    try {
      // Buscar o documento do usuário pelo UID
      var document = await FirebaseFirestore.instance
          .collection('clientes')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      if (document.docs.isNotEmpty) {
        // Retornar o e-mail se o documento for encontrado
        return document.docs.first.data()['email'] as String?;
      } else {
        // Retornar nulo se nenhum documento for encontrado
        return null;
      }
    } catch (e) {
      // Tratar exceções, se necessário
      print('Erro ao buscar o e-mail: $e');
      return null;
    }
  }

  static Future<String?> getNumberByUid(String uid) async {
    try {
      // Buscar o documento do usuário pelo UID
      var document = await FirebaseFirestore.instance
          .collection('clientes')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      if (document.docs.isNotEmpty) {
        // Retornar o e-mail se o documento for encontrado
        return document.docs.first.data()['contato'] as String?;
      } else {
        // Retornar nulo se nenhum documento for encontrado
        return null;
      }
    } catch (e) {
      // Tratar exceções, se necessário
      print('Erro ao buscar o e-mail: $e');
      return null;
    }
  }
}
