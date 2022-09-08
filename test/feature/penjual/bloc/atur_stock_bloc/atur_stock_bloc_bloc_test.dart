// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:cafetaria/feature/penjual/bloc/atur_stock_bloc/atur_stock_bloc_bloc.dart';
import 'package:cafetaria/feature/penjual/model/restok_tipe.dart';
import 'package:cafetaria/feature/penjual/model/stok_input.dart';
import 'package:cafetaria/feature/penjual/model/time_input.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockMenuRepository extends Mock implements MenuRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MenuRepository menuRepository;

  setUp(() {
    menuRepository = MockMenuRepository();
    final stok = const MenuModel(
            categoryId: "Ca7QNFUudrFbc63yRT8d",
            desc: "test",
            image: "test",
            isRecomended: false,
            menuId: "test",
            merchantId: "test",
            name: "test",
            price: 2000,
            rulepreordermenuId: "test",
            tags: [],
            stock: 9,
            isPreOrder: true,
            resetTime: '20 : 20 PM',
            resetType: 'hari',
            autoResetStock: true)
        .copyWith(
            autoResetStock: false, stock: 10, resetType: "", resetTime: "");
    registerFallbackValue(stok);
    when(() => menuRepository.editStockMenu(
          stok,
          'merchant2',
        )).thenAnswer(
      (_) async => Future.value(),
    );
  });

  group('edit jumlah stok', () {
    //Arrange
    // ignore: prefer_const_declarations
    final stok = const MenuModel(
        categoryId: "Ca7QNFUudrFbc63yRT8d",
        desc: "Matcha Milk Tea",
        image:
            "https://firebasestorage.googleapis.com/v0/b/komplekku-575ee.appspot.com/o/images%2Fmenu%2Fchatimeboba.png?alt=media&token=b5d67bc5-713e-4650-931e-023e024751a1",
        isRecomended: false,
        menuId: "00c1d435-f921-4b10-b0f4-23c5df2035fb",
        merchantId: "merchant2",
        name: "Matcha Milk Tea",
        price: 2000,
        rulepreordermenuId: "CMgpzAqfvS5fdjU1Cp9i",
        tags: ["test1", "po"],
        stock: 9,
        isPreOrder: true,
        resetTime: '20 : 20 PM',
        resetType: 'hari',
        autoResetStock: true);
    //Test progress
    blocTest<AturStockBlocBloc, AturStockBlocState>(
      'calls edit stok menu',
      build: () {
        return AturStockBlocBloc(menuRepository: menuRepository);
      },
      //Act

      act: (bloc) => bloc.add(const AturStok(MenuModel(tags: []))),
      verify: (_) {
        verify(() => menuRepository.editStockMenu(
              any(),
              any(),
            )).called(1);
      },
    );
    blocTest<AturStockBlocBloc, AturStockBlocState>(
      'emits [submissionInProgress, submissionSuccess] '
      'when save category succeeds',
      build: () {
        return AturStockBlocBloc(
          menuRepository: menuRepository,
        );
      },
      act: (bloc) => bloc.add(
        AturStok(stok.copyWith(
            autoResetStock: false,
            stock: 10,
            resetType: "hari",
            resetTime: "10:30 AM")),
      ),
      expect: () => const <AturStockBlocState>[
        AturStockBlocState(status: FormzStatus.submissionInProgress),
        AturStockBlocState(status: FormzStatus.submissionSuccess)
      ],
    );
    blocTest<AturStockBlocBloc, AturStockBlocState>(
      'emits [submissionInProgress, submissionFailed] '
      'when save stok failed',
      build: () {
        when(() => menuRepository.editStockMenu(
              any(),
              any(),
            )).thenThrow(
          Exception(),
        );
        return AturStockBlocBloc(
          menuRepository: menuRepository,
        );
      },
      act: (bloc) => bloc.add(
        AturStok(
            //Arrange
            stok),
      ),
      expect: () => const <AturStockBlocState>[
        AturStockBlocState(status: FormzStatus.submissionInProgress),
        AturStockBlocState(status: FormzStatus.submissionFailure)
      ],
    );
  });

  group('Input Edit Stok', () {
    blocTest<AturStockBlocBloc, AturStockBlocState>(
      'calls Stok Input change',
      build: () {
        return AturStockBlocBloc(
          menuRepository: menuRepository,
        );
      },
      act: (bloc) => bloc.add(AturStokJumlah('10')),
      expect: () => [
        isA<AturStockBlocState>().having(
          (request) => request.stokInput,
          'stok input',
          equals(StokInput.dirty('10')),
        ),
      ],
    );
    blocTest<AturStockBlocBloc, AturStockBlocState>(
      'calls CanRestok change',
      build: () {
        return AturStockBlocBloc(
          menuRepository: menuRepository,
        );
      },
      act: (bloc) => bloc.add(AturStokRestok(true)),
      expect: () => [
        isA<AturStockBlocState>().having(
          (request) => request.restok,
          'CanRestok',
          equals(true),
        ),
      ],
    );
    blocTest<AturStockBlocBloc, AturStockBlocState>(
      'calls isAvailable change',
      build: () {
        return AturStockBlocBloc(
          menuRepository: menuRepository,
        );
      },
      act: (bloc) => bloc.add(AturStokTersedia(true)),
      expect: () => [
        isA<AturStockBlocState>().having(
          (request) => request.tersedia,
          'IsAvailable',
          equals(true),
        ),
      ],
    );
    blocTest<AturStockBlocBloc, AturStockBlocState>(
      'calls AturStokTime change',
      build: () {
        return AturStockBlocBloc(
          menuRepository: menuRepository,
        );
      },
      act: (bloc) => bloc.add(AturStokTime("12:20")),
      expect: () => [
        isA<AturStockBlocState>().having(
          (request) => request.timeReset,
          'AturStokTime',
          equals(TimeInput.dirty("12:20")),
        ),
      ],
    );
    blocTest<AturStockBlocBloc, AturStockBlocState>(
      'calls Restok Tipe change',
      build: () {
        return AturStockBlocBloc(
          menuRepository: menuRepository,
        );
      },
      act: (bloc) => bloc.add(AturStokRestokType("minggu")),
      expect: () => [
        isA<AturStockBlocState>().having(
          (request) => request.tipeRestok,
          'Restok Tipe',
          equals(RestokTipeInput.dirty("minggu")),
        ),
      ],
    );
  });
}
