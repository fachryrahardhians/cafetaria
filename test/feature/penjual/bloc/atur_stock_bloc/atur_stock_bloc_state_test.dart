// ignore_for_file: prefer_const_constructors

import 'package:cafetaria/feature/penjual/bloc/add_category_bloc/add_category_bloc.dart';
import 'package:cafetaria/feature/penjual/bloc/atur_stock_bloc/atur_stock_bloc_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';

void main() {
  group('Edit Stok state', () {
    test('supports value comparisons', () {
      expect(AturStockBlocState(), AturStockBlocState());
    });

    test('returns same object when no properties are passed', () {
      expect(AturStockBlocState().copyWith(), AturStockBlocState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        AturStockBlocState().copyWith(status: FormzStatus.pure),
        AturStockBlocState(),
      );
    });

    test(
        'returns object with updated status when '
        'formzStatus is success)', () {
      expect(
        AturStockBlocState().copyWith(status: FormzStatus.submissionSuccess),
        AturStockBlocState(status: FormzStatus.submissionSuccess),
      );
    });
  });
}
