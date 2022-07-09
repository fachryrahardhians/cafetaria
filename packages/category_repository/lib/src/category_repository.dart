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

  // add category menu
  Future<void> addCategory(
    String idMerchant,
    String name,
  ) async {
    final data = {
      'merchantId': idMerchant,
      'category': name,
      'categoryId': uuid.v4(),
    };

    // add to firestore
    await _firestore.collection('category').add(data);
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
