import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BookingDao {
  Stream<QuerySnapshot> listarConfirmados(String id) {
    return FirebaseFirestore.instance
        .collection('reservas')
        .where('uid_empresa', isEqualTo: id)
        .where('status', isEqualTo: 'Confirmado')
        .snapshots();
  }

  listarPorDia(String id, String selectedDate) {
    return FirebaseFirestore.instance
        .collection('reservas')
        .where('uid_empresa', isEqualTo: id)
        .where('status', isEqualTo: 'Confirmado')
        .where('data', isEqualTo: selectedDate)
        .snapshots();
  }
}
