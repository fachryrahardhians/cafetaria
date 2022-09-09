import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penjual_order_repository/src/models/penjual_order_model.dart';

class PenjualOrderRepository {
  final FirebaseFirestore _firestore;

  PenjualOrderRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  Future<List<PenjualOrderModel>> getOrder() async {
    try{
      final snapshot =
          await _firestore.collection("order").get();

      final documents = snapshot.docs;
      return documents.toListMenu();
    }catch(e){
      throw Exception("Failed to get Order");
    }
  }
}

extension on List<QueryDocumentSnapshot> {
  List<PenjualOrderModel> toListMenu() {
    final entries = <PenjualOrderModel>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          entries.add(PenjualOrderModel.fromJson(data));
        } catch (error) {
          throw Exception();
        }
      }
    }
    return entries;
  }
}