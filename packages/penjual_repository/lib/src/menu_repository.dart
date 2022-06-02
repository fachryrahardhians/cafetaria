import 'package:cloud_firestore/cloud_firestore.dart';

class MenuRepository {
  final FirebaseFirestore _firestore;

  MenuRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  // add category menu
  Future<void> addCategoryMenu(
    String category,
    String idMerchant,
  ) async {
    final data = {
      'category': category,
      'merchantId': idMerchant,
    };

    // add to firestore
    await _firestore.collection('category').add(data);
  }
}
