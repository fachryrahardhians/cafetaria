import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'models/models.dart';

class OrderRepository {
  OrderRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  final _uuid = const Uuid();

  Future<List<HistoryModel>> getListOrderHistory(
      String status, String userId) async {
    int retries = 5;
    while (retries > 0) {
      try {
        final snapshot = await _firestore
            .collection('order')
            .where('statusOrder', isEqualTo: status)
            .where('userId', isEqualTo: userId)
            .get();
        final documents = snapshot.docs;
        return documents.toListHistory();
      } catch (e) {
        retries--;
        if (retries == 0) {
          throw Exception('Failed to get history');
        }
        await Future.delayed(const Duration(seconds: 3));
      }
    }
    return [];
  }

  Future<void> addOrder(HistoryModel order) async {
    try {
      order.copyWith(
        orderId: _uuid.v4(),
      );
      var orderJson = order.toJson();

      orderJson["timestamp"] =
          Timestamp.fromDate(DateTime.parse(orderJson["timestamp"]));
      orderJson["pickupDate"] =
          Timestamp.fromDate(DateTime.parse(orderJson["pickupDate"]));
      // add to firestore
      await _firestore.collection('order').doc(order.orderId).set(orderJson);
      print(order.orderId);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

extension on List<QueryDocumentSnapshot> {
  List<HistoryModel> toListHistory() {
    final historyEntries = <HistoryModel>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          var timestamp = data["timestamp"] as Timestamp;
          data["timestamp"] = timestamp.toDate().toString();
          var pickupDate = data["pickupDate"] as Timestamp;
          data["pickupDate"] = pickupDate.toDate().toString();
          historyEntries.add(HistoryModel.fromJson(data));
        } catch (error) {
          throw Exception();
        }
      }
    }
    return historyEntries;
  }
}
