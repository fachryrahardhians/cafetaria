import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/models.dart';

class RatingRepository {
  RatingRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  // add discount
  Future<void> addRating(
      String orderId,
    RatingModel rating,
  ) async {
    // add to firestore
    await _firestore.collection('rating').doc(rating.ratingId).set(rating.toJson());
    await _firestore.collection('order').doc(orderId).update({'ratingId': rating.ratingId});
  }
}
