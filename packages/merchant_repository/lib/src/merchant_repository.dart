import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merchant_repository/src/models/models.dart';
import 'package:uuid/uuid.dart';

/// {@template merchant_repository}
/// merchant repository
/// {@endtemplate}
class MerchantRepository {
  final FirebaseFirestore _firestore;
  final uuid = const Uuid();

  MerchantRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

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
