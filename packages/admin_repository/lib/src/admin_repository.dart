import 'package:admin_repository/admin_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminRepository {
  AdminRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;
  final FirebaseFirestore _firestore;
  // get  menu per merchant
  Future<List<KawasanRead>> getListKawasan() async {
    try {
      final snapshot = await _firestore.collection('kawasan-read').get();
      final documents = snapshot.docs;
      return documents.toListKawasan();
    } catch (e) {
      throw Exception('Failed to get merchant');
    }
  }

  Future<void> updateStatus(String id, String status) async {
    try {
      await _firestore.collection('kawasan').doc(id).update({'status': status});
    } catch (e) {
      throw Exception('Failed to Update status');
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
