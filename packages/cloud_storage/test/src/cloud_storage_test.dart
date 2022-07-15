// ignore_for_file: prefer_const_constructors
import 'package:cloud_storage/cloud_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CloudStorage', () {
    test('can be instantiated', () {
      expect(CloudStorage(), isNotNull);
    });
  });
}
