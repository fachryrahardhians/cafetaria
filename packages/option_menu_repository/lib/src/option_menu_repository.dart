import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:option_menu_repository/src/models/option_menu_model.dart';
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
  final _uuid = const Uuid();

  /// save option menu
  Future<void> saveOptionMenu(OptionMenuModel optionMenu) async {
    try {
      await _firestore
          .collection('optionMenu')
          .doc(_uuid.v4())
          .set(optionMenu.toJson());
    } catch (e) {
      throw Exception('Failed to save option menu');
    }
  }
}
