import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'models/models.dart';

class RatingRepository {
  RatingRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  final _uuid = const Uuid();

  // add discount
  Future<void> addRating(
    RatingModel rating,
  ) async {
    rating.copyWith(
      ratingId: _uuid.v4(),
    );
    // add to firestore
    await _firestore.collection('rating').add(rating.toJson());
  }
}
