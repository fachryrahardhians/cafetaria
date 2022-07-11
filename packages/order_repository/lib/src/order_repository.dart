import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'models/models.dart';

class OrderRepository {
  OrderRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  final _uuid = const Uuid();

  Future<List<HistoryModel>> getListOrderHistory(String status) async {
    try {
      final snapshot = await _firestore.collection('order').get();

      final documents = snapshot.docs;

      return documents.toListHistory();
    } catch (e) {
      throw Exception('Failed to get history');
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
          historyEntries.add(HistoryModel.fromJson(data));
        } catch (error) {
          throw Exception();
        }
      }
    }
    return historyEntries;
  }
}
