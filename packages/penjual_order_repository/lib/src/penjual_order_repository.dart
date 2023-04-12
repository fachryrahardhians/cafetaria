import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:penjual_order_repository/src/models/penjual_order_model.dart';

class PenjualOrderRepository {
  final FirebaseFirestore _firestore;

  PenjualOrderRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  Future<List<PenjualOrderModel>> getOrder(String idMerchant) async {
    try {
      final snapshot = await _firestore
          .collection("order")
          .where("merchantId", isEqualTo: idMerchant)
          .get();
      if (kDebugMode) {}

      final documents = snapshot.docs;
      return documents.toListOrder();
    } catch (e) {
      throw Exception("Failed to get Order");
    }
  }

  Future<void> actionToOrder(Map<String, dynamic> data, String docId) async {
    try {
      await _firestore.collection("order").doc(docId).update(data);
    } catch (e) {
      throw Exception("Failed to Update the Order");
    }
  }
}

extension on List<QueryDocumentSnapshot> {
  List<PenjualOrderModel> toListOrder() {
    final entries = <PenjualOrderModel>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          entries.add(PenjualOrderModel.fromJson(data, document.id));
        } catch (error) {
          throw Exception();
        }
      }
    }
    return entries;
  }
}
