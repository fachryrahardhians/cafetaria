// ignore_for_file: prefer_const_constructors
import 'package:cafetaria/feature/penjual/bloc/add_category_bloc/add_category_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';

void main() {
  group('Add category state', () {
    test('supports value comparisons', () {
      expect(AddCategoryState(), AddCategoryState());
    });

    test('returns same object when no properties are passed', () {
      expect(AddCategoryState().copyWith(), AddCategoryState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        AddCategoryState().copyWith(formzStatus: FormzStatus.pure),
        AddCategoryState(),
      );
    });

    test(
        'returns object with updated status when '
        'formzStatus is success)', () {
      expect(
        AddCategoryState().copyWith(formzStatus: FormzStatus.submissionSuccess),
        AddCategoryState(formzStatus: FormzStatus.submissionSuccess),
      );
    });
  });
}
