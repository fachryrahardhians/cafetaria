import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penjual_repository/penjual_repository.dart';
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

  // get  menu per merchant
  Future<List<MenuModel>> getMenu(
    String idMerchant,
    String idCategory,
  ) async {
    try {
      final snapshot =
          await _firestore.collection('menuPerMerchant-$idMerchant').get();

      final documents = snapshot.docs;
      return documents.toListMenu();
    } catch (e) {
      throw Exception('Failed to get menu');
    }
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

  List<MenuModel> toListMenu() {
    final leaderboardEntries = <MenuModel>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          leaderboardEntries.add(MenuModel.fromJson(data));
        } catch (error) {
          throw Exception();
        }
      }
    }
    return leaderboardEntries;
  }
}
