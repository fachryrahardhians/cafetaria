import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'models/models.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore;
  var uuid = const Uuid();

  CategoryRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  // get category menu
  Future<List<CategoryModel>> getCategoryMenu(String idMerchant) async {
    try {
      final snapshot = await _firestore.collection('category').get();

      final documents = snapshot.docs;
      return documents.toLeaderboard();
    } catch (e) {
      throw Exception('Failed to get category menu');
    }
  }

// get category menu
  Future<List<CategoryModel>> getCategoryMenuMerchant(String idMerchant) async {
    try {
      final snapshot = await _firestore
          .collection('category')
          .where('merchantId', isEqualTo: idMerchant)
          .get();

      final documents = snapshot.docs;
      return documents.toLeaderboard();
    } catch (e) {
      throw Exception('Failed to get category menu');
    }
  }

  //add idkawasan collection user
  Future<void> updateKawasan(String id, String idkawasan) async {
    try {
      await _firestore
          .collection('user')
          .doc(id)
          .update({'kawasanId': idkawasan});
    } catch (e) {
      throw Exception('Failed to Update idkawasan');
    }
  }

  //get pilih kawasan
  Future<List<PilihKawasanModel>> getPilihKawasan() async {
    try {
      final snapshot = await _firestore.collection('kawasan').get();

      final documents = snapshot.docs;
      return documents.toLeaderboard2();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // add category menu
  Future<void> addCategory(
    String idMerchant,
    String name,
  ) async {
    final id = uuid.v4();
    final data = {
      'merchantId': idMerchant,
      'category': name,
      'categoryId': id,
    };

    // add to firestore
    await _firestore.collection('category').doc(id).set(data);
  }
}

extension on List<QueryDocumentSnapshot> {
  List<PilihKawasanModel> toLeaderboard2() {
    final categoryEntries = <PilihKawasanModel>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          categoryEntries.add(PilihKawasanModel.fromJson(data));
        } catch (error) {
          throw Exception();
        }
      }
    }
    return categoryEntries;
  }
}

extension on List<QueryDocumentSnapshot> {
  List<CategoryModel> toLeaderboard() {
    final categoryEntries = <CategoryModel>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          categoryEntries.add(CategoryModel.fromJson(data));
        } catch (error) {
          throw Exception();
        }
      }
    }
    return categoryEntries;
  }
}
