import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penjual_repository/src/models/category_menu_model.dart';
import 'package:uuid/uuid.dart';

class MenuRepository {
  final FirebaseFirestore _firestore;
  var uuid = const Uuid();

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

  // get category menu
  Future<List<CategoryMenuModel>> getCategoryMenu(String idMerchant) async {
    try {
      final snapshot = await _firestore.collection('category').get();

      final documents = snapshot.docs;
      return documents.toLeaderboard();
    } catch (e) {
      print(e.toString());
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
  List<CategoryMenuModel> toLeaderboard() {
    final leaderboardEntries = <CategoryMenuModel>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          leaderboardEntries.add(CategoryMenuModel.fromJson(data));
        } catch (error) {
          throw Exception();
        }
      }
    }
    return leaderboardEntries;
  }
}
