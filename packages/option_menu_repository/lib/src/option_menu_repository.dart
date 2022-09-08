// ignore_for_file: public_member_api_docs, always_use_package_imports

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'models/models.dart';

class OptionMenuRepository {
  final FirebaseFirestore _firestore;
  final uuid = const Uuid();

  OptionMenuRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  // get opsi menu
  Future<List<OptionMenuModel>> getOptionMenu(
    String menuId,
    String idMerchant,
  ) async {
    try {
      final snapshot =
          await _firestore.collection('menuPerMerchant-$idMerchant').get();

      final documents = snapshot.docs;
      return documents.toListOpsiMenu();
    } catch (e) {
      throw Exception('Failed to get Option');
    }
  }
}

extension on List<QueryDocumentSnapshot> {
  List<OptionMenuModel> toListOpsiMenu() {
    final leaderboardEntries = <OptionMenuModel>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          leaderboardEntries.add(OptionMenuModel.fromJson(data));
        } catch (error) {
          throw Exception();
        }
      }
    }
    return leaderboardEntries;
  }
}