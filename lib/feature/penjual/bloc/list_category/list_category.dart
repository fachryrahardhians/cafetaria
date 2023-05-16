import 'package:category_repository/category_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  Stream<List<CategoryModel>> fetchData() {
    return FirebaseFirestore.instance.collection('category').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => CategoryModel.fromJson(doc.data()))
            .toList());
  }
}
