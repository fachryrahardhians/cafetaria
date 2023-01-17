import 'package:admin_repository/admin_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminRepository {
  AdminRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;
  final FirebaseFirestore _firestore;
  // get  menu per merchant


  Future<void> addInfo(InfoModel info) async {
    try {
      await _firestore.collection('info').doc(info.infoId).set(info.toJson());
    } catch (e) {
      throw Exception('Failed to add info');
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

  Stream<List<KawasanRead>> getStreamListKawasan() async* {
    yield* _firestore.collection('kawasan-read').snapshots().map((event) =>
        event.docs.map((e) => KawasanRead.fromJson(e.data())).toList());
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

  Future<void> updateStatus(String id, String status) async {
    try {
      await _firestore.collection('kawasan').doc(id).update({'status': status});
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
