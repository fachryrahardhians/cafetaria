/// {@template rating_repository}
/// rating repository
/// {@endtemplate}
///
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rating_repository/src/models/models.dart';

///
class RatingRepository {
  ///
  RatingRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  /// add discount
  Future<void> addRating(
    RatingModel rating,
  ) async {
    // add to firestore
    await _firestore
        .collection('rating')
        .doc(rating.ratingId)
        .set(rating.toJson());
  }
}
