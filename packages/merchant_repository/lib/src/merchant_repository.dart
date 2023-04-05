import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:merchant_repository/merchant_repository.dart';

import 'package:uuid/uuid.dart';

/// {@template merchant_repository}
/// merchant repository
/// {@endtemplate}
class MerchantRepository {
  // ignore: public_member_api_docs
  MerchantRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;
  final FirebaseFirestore _firestore;

  /// {@macro merchant_repository}
  final uuid = const Uuid();

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

  Future<List<MerchantModel>> getMerchantLogin(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('user')
          .doc(userId)
          .collection('store')
          .get();

      final documents = snapshot.docs;
      return documents.toListMerchant();
    } catch (e) {
      throw Exception('Failed to get merchant');
    }
  }
  // get  menu per merchant
  // Future<List<Rules>> getrulesDay(String idMerchant) async {
  //   try {
  //     final snapshot = await _firestore
  //         .collection('merchant')
  //         .doc(idMerchant)
  //         .collection("rules")
  //         .get();

  //     final documents = snapshot.docs;
  //     return documents.toListDay();
  //   } catch (e) {
  //     throw Exception('Failed to get merchant');
  //   }
  // }

  Future<List<Rules>> getrulesDay({String? merchantId}) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('getMerchantRule');
    final resp = await callable.call(<String, dynamic>{
      'merchantId': merchantId,
    });
    final List data = resp.data;
    final leaderboardEntries = <Rules>[];

    for (final document in data) {
      final data = document;
      if (data != null) {
        try {
          print(data);
          leaderboardEntries
              .add(Rules.fromJson(Map<String, dynamic>.from(data)));
        } catch (error) {
          throw Exception(error.toString());
        }
      }
    }
    return leaderboardEntries;
  }

  Future<List<RulesDays>> getMerchantOffDaysRule(
      {String? date, String? merchantId, String? type}) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('getMerchantOffDaysRule');
    final resp = await callable.call(<String, dynamic>{
      'merchantId': merchantId,
      'date': date,
      'type': type
    });
    final List data = resp.data;
    final leaderboardEntries = <RulesDays>[];

    for (final document in data) {
      final data = document;
      if (data != null) {
        try {
          print(data);
          leaderboardEntries
              .add(RulesDays.fromJson(Map<String, dynamic>.from(data)));
        } catch (error) {
          throw Exception(error.toString());
        }
      }
    }
    return leaderboardEntries;
  }

  // Future<void> editStockMenu(String menu, String idMerchant) async {
  //   try {
  //     await _firestore
  //         .collection('menu')
  //         .doc(menu.menuId)
  //         .update(menu.toJson());
  //   } catch (e) {
  //     throw Exception('Failed to Update Stock Menu');
  //   }
  // }

  Future<List<MechantSearch>> searchMerchant(String message, //String id,
      {required double long,
      required double lat}) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('searchMerchant');
    final resp = await callable.call(<String, dynamic>{
      'keyword': message,
      //'userId': id,
      'latitude': lat,
      'longitude': long
    });
    final List data = resp.data;
    final leaderboardEntries = <MechantSearch>[];

    for (final document in data) {
      final data = document;
      if (data != null) {
        try {
          print(data);
          leaderboardEntries
              .add(MechantSearch.fromJson(Map<String, dynamic>.from(data)));
          print(leaderboardEntries[0].source!.distance);
        } catch (error) {
          throw Exception(error.toString());
        }
      }
    }
    return leaderboardEntries;
  }

  Future<List<MerchantModel>> getMerchantById(String merchantId) async {
    try {
      final snapshot = await _firestore
          .collection('merchant')
          .where('merchantId', isEqualTo: merchantId)
          .get();
      final documents = snapshot.docs;
      return documents.toListMerchant();
    } catch (e) {
      throw Exception('Failed to get merchant');
    }
  }
}

// extension on List<Object?> {
//   List<MechantSearch> toListMerchantSearch() {
//     final leaderboardEntries = <MechantSearch>[];
//     for (final document in this) {
//       final data = document as Map<String, dynamic>?;
//       if (data != null) {
//         try {
//           print(data);
//           leaderboardEntries.add(MechantSearch.fromJson(data));
//         } catch (error) {
//           print(error.toString());
//           throw Exception();
//         }
//       }
//     }
//     return leaderboardEntries;
//   }
// }

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

extension on List<QueryDocumentSnapshot> {
  List<Rules> toListDay() {
    final leaderboardEntries = <Rules>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          print(data);
          leaderboardEntries.add(Rules.fromJson(data));
        } catch (error) {
          print(error.toString());
          throw Exception();
        }
      }
    }
    return leaderboardEntries;
  }
}
