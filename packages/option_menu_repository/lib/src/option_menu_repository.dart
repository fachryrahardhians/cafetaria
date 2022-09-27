// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:option_menu_repository/src/models/models.dart';
// import 'package:option_menu_repository/src/models/option_menu_model.dart';
// import 'package:option_menu_repository/src/models/option_menu_model.dart';
import 'package:uuid/uuid.dart';

/// {@template option_menu_repository}
/// option menu repository
/// {@endtemplate}
class OptionMenuRepository {
  /// {@macro option_menu_repository}
  OptionMenuRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;
  //final _uuid = const Uuid();

  /// save option menu
  Future<void> saveOptionMenu(OptionMenuModel optionMenu) async {
    try {
      await _firestore
          .collection('optionmenu')
          .doc(optionMenu.optionmenuId)
          .set(optionMenu.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> editOptionMenu(OptionMenuModel optionMenu) async {
    try {
      await _firestore
          .collection('optionmenu')
          .doc(optionMenu.optionmenuId)
          .update(optionMenu.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteOptionMenu(String optionMenuId) async {
    try {
      await _firestore.collection('optionmenu').doc(optionMenuId).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //get option menu
  Future<List<OptionMenuModel>> getOptionMenu(String menuId) async {
    try {
      final snapshot = await _firestore
          .collection('optionmenu')
          .where('menuId', isEqualTo: menuId)
          .get();
      final document = snapshot.docs;
      return document.toListMenu();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

extension on List<QueryDocumentSnapshot> {
  List<OptionMenuModel> toListMenu() {
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
