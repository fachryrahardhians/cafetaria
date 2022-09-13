import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merchant_repository/src/models/models.dart';
import 'package:uuid/uuid.dart';

/// {@template merchant_repository}
/// merchant repository
/// {@endtemplate}
class MerchantRepository {
  final FirebaseFirestore _firestore;

  /// {@macro merchant_repository}
  final uuid = const Uuid();

  MerchantRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  Future<MerchantModel> getMerchantDetail(
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
  // get  menu per merchant
  Future<List<MerchantModel>> getMerchant() async {
    try {
      final snapshot = await _firestore.collection('merchant').get();

      final documents = snapshot.docs;
      return documents.toListMerchant();
    } catch (e) {
      throw Exception('Failed to get merchant');
    }
  }

  Future<List<MerchantModel>> getMerchantById(String merchantId) async {
    try {
      final snapshot = await _firestore.collection('merchant').where('merchantId', isEqualTo: merchantId).get();
      final documents = snapshot.docs;
      return documents.toListMerchant();
    } catch (e) {
      throw Exception('Failed to get merchant');
    }
  }
}

extension on List<QueryDocumentSnapshot> {
  List<MerchantModel> toListMerchant() {
    final leaderboardEntries = <MerchantModel>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          print(data);
          leaderboardEntries.add(MerchantModel.fromJson(data));
        } catch (error) {
          print(error.toString());
          throw Exception();
        }
      }
    }
    return leaderboardEntries;
  }
}
