import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'models/models.dart';

class MenuRepository {
  final FirebaseFirestore _firestore;
  final uuid = const Uuid();

  MenuRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

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

  Future<void> addMenu(MenuModel menu) async {
    try {
      await _firestore.collection('menu').doc(menu.menuId).set(menu.toJson());
    } catch (e) {
      throw Exception('Failed to get menu');
    }
  }
}

extension on List<QueryDocumentSnapshot> {
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
