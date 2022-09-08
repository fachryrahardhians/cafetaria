import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merchant_repository/src/models/models.dart';

/// {@template merchant_repository}
/// merchant repository
/// {@endtemplate}
class MerchantRepository {
  final FirebaseFirestore _firestore;

  /// {@macro merchant_repository}
  MerchantRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  Future<MerchantModel> getMerchant(
    String idUser,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('merchant')
          .where('userId', isEqualTo: idUser)
          .get();

      final documents = snapshot.docs;
      return MerchantModel.fromJson(documents.first.data());
    } catch (e) {
      throw Exception('Failed to get merchant where id user');
    }
  }
}
