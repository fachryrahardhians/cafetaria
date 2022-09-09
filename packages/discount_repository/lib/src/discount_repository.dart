import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uuid/uuid.dart';

import 'models/discount_model.dart';


class DiscountRepository {
  DiscountRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  final _uuid = const Uuid();

  // get discount by merchant id
  Future<List<DiscountModel>> getDiscount(String idMerchant) async {
    try {
      final snapshot = await _firestore
          .collection('discount')
          .where('merchantId', isEqualTo: idMerchant)
          .get();

      final documents = snapshot.docs;
      return documents.toListDiscount();
    } catch (e) {
      throw Exception('Failed to get discount');
    }
  }

  // add discount
  Future<void> addDiscount(
    DiscountModel discount,
  ) async {
    discount.copyWith(
      discountId: _uuid.v4(),
    );
    // add to firestore
    await _firestore.collection('discount').add(discount.toJson());
  }
}

extension on List<QueryDocumentSnapshot> {
  List<DiscountModel> toListDiscount() {
    final discountEntries = <DiscountModel>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          discountEntries.add(DiscountModel.fromJson(data));
        } catch (error) {
          throw Exception();
        }
      }
    }
    return discountEntries;
  }
}
