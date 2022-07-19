// ignore_for_file: prefer_const_constructors
import 'package:cafetaria/feature/penjual/bloc/add_category_bloc/add_category_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Add category event', () {
    test('props are equal', () {
      expect(
        AddCategoryEvent().props,
        <Object>[],
      );
    });
    group('save category', () {
      test('supports value comparisons', () {
        expect(
          SaveCategory(
            category: 'cat',
            idMerchant: 'id',
          ),
          SaveCategory(
            category: 'cat',
            idMerchant: 'id',
          ),
        );
      });

      test('props are equal', () {
        expect(
          SaveCategory(
            category: 'cat',
            idMerchant: 'id',
          ).props,
          SaveCategory(
            category: 'cat',
            idMerchant: 'id',
          ).props,
        );
      });
    });

    group('Category Changes', () {
      test('supports value comparisons', () {
        expect(CategoryChange('cat'), CategoryChange('cat'));
      });

      test('props are equal', () {
        expect(
          CategoryChange('cat').props,
          CategoryChange('cat').props,
        );
      });
    });
  });
}
