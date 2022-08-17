import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'models/models.dart';

class OrderRepository {
  OrderRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  final _uuid = const Uuid();

  Future<List<HistoryModel>> getListOrderHistory(String status, String userId) async {
    try {
      final snapshot = await _firestore.collection('order').where('statusOrder', isEqualTo: status).where('userId', isEqualTo: userId).get();

      final documents = snapshot.docs;

      return documents.toListHistory();
    } catch (e) {
      throw Exception('Failed to get history');
    }
  }

  Future<void> addOrder(HistoryModel order) async {
    order.copyWith(
      orderId: _uuid.v4(),
    );
    // add to firestore
    await _firestore.collection('order').doc(order.orderId).set(order.toJson());
  }
}

extension on List<QueryDocumentSnapshot> {
  List<HistoryModel> toListHistory() {
    final historyEntries = <HistoryModel>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          historyEntries.add(HistoryModel.fromJson(data));
        } catch (error) {
          throw Exception();
        }
      }
    }
    return historyEntries;
  }
}
