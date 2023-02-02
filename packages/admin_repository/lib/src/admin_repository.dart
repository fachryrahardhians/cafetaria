import 'package:admin_repository/admin_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class AdminRepository {
  AdminRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;
  final FirebaseFirestore _firestore;
  // get  menu per merchant

  Future<UserAdmin> getUserAdmin(String userId) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('getUserAdminKawasanData');
    final resp = await callable.call(<String, dynamic>{'userId': userId});
    // final List data = resp.data;
    final UserAdmin leaderboardEntries;

    try {
      leaderboardEntries =
          UserAdmin.fromJson(Map<String, dynamic>.from(resp.data));
    } catch (error) {
      throw Exception(error.toString());
    }
    return leaderboardEntries;
  }

  Future<void> addInfo(InfoModel info) async {
    try {
      await _firestore.collection('info').doc(info.infoId).set(info.toJson());
    } catch (e) {
      throw Exception('Failed to add info');
    }
  }

  Future<void> updateInfo(InfoModel info) async {
    try {
      await _firestore
          .collection('info')
          .doc(info.infoId)
          .update(info.toJson());
    } catch (e) {
      throw Exception('Failed to update info');
    }
  }

  Future<void> deleteInfo(InfoModel info) async {
    try {
      await _firestore.collection('info').doc(info.infoId).delete();
    } catch (e) {
      throw Exception('Failed to delete info');
    }
  }

  Future<List<KawasanRead>> getListKawasan() async {
    try {
      final snapshot = await _firestore.collection('kawasan-read').get();
      final documents = snapshot.docs;
      return documents.toListKawasan();
    } catch (e) {
      throw Exception('Failed to get kawasan');
    }
  }

  Stream<List<UserModel>> getStreamListKawasan(
      String idKawasan, String kawasan) async* {
    yield* _firestore
        .collection('kawasan-read')
        .doc(idKawasan)
        .collection(kawasan)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => UserModel.fromJson(e.data())).toList());
  }

  Stream<List<InfoModel>> getStreamInfo() async* {
    yield* _firestore.collection('info').snapshots().map((event) =>
        event.docs.map((e) => InfoModel.fromJson(e.data())).toList());
  }

  Future<void> updateLongLat(String id, String long, String lat) async {
    try {
      await _firestore.collection('user').doc(id).update({
        'currentLatitude': double.parse(lat),
        'currentLongitude': double.parse(long)
      });
    } catch (e) {
      throw Exception('Failed to Update LongLat');
    }
  }

  Future<void> updateStatus(
      String id, String status, String kawasan, String iduser) async {
    try {
      await _firestore
          .collection('kawasan')
          .doc(id)
          .collection(kawasan)
          .doc(iduser)
          .update({'status': status});
    } catch (e) {
      throw Exception('Failed to Update status');
    }
  }

  Future<void> updateKawasan(String id, String kawasan) async {
    try {
      await _firestore.collection('kawasan').doc(id).update({'name': kawasan});
    } catch (e) {
      throw Exception('Failed to Update Kawasan');
    }
  }

  Future<void> deleteKawasan(String id) async {
    try {
      await _firestore.collection('kawasan').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to Update Kawasan');
    }
  }
}

extension on List<QueryDocumentSnapshot> {
  List<KawasanRead> toListKawasan() {
    final leaderboardEntries = <KawasanRead>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          print(data);
          leaderboardEntries.add(KawasanRead.fromJson(data));
        } catch (error) {
          print(error.toString());
          throw Exception();
        }
      }
    }
    return leaderboardEntries;
  }
}
