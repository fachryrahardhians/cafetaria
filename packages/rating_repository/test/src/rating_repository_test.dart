// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
//import 'package:mocktail/mocktail.dart';
import 'package:rating_repository/rating_repository.dart';

//class MockFirestore extends Mock implements FirebaseFirestore {}

void main() {
  //MockFirestore instance = MockFirestore();
  // setUp(() {
  //   instance = MockFirestore();
  // });
  final firestore = FakeFirebaseFirestore();
  group('RatingRepository', () {
    test('can be instantiated', () async {
      expect(RatingRepository(firestore: firestore), isNotNull);
    });
    // test('can add to firestore', () async{
    //   RatingRepository ratingRepository = RatingRepository(firestore: firestore);
    //   RatingModel model = RatingModel(feedback: 'test', merchantId: '1', orderId: '1', rating: 1, ratingId: '1');
    //   //verify(()async=>await ratingRepository.addRating(model));
    //   //await expectLater(()async{await ratingRepository.addRating(model);}, isNull);
    // });
  });
}
