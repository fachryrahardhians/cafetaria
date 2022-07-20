// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:cafetaria/feature/penjual/bloc/add_category_bloc/add_category_bloc.dart';
import 'package:cafetaria/feature/penjual/model/category_input.dart';
import 'package:category_repository/category_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late CategoryRepository categoryRepository;

  setUp(() {
    categoryRepository = MockCategoryRepository();

    when(() => categoryRepository.addCategory(
          any(),
          any(),
        )).thenAnswer(
      (_) async => Future.value(),
    );
  });

  group('add category', () {
    blocTest<AddCategoryBloc, AddCategoryState>(
      'calls add category',
      build: () {
        return AddCategoryBloc(
          categoryRepository: categoryRepository,
        );
      },
      act: (bloc) => bloc.add(
        const SaveCategory(category: 'category', idMerchant: 'idMerchant'),
      ),
      verify: (_) {
        verify(() => categoryRepository.addCategory(
              any(),
              any(),
            )).called(1);
      },
    );

    blocTest<AddCategoryBloc, AddCategoryState>(
      'emits [submissionInProgress, submissionSuccess] '
      'when save category succeeds',
      build: () {
        return AddCategoryBloc(
          categoryRepository: categoryRepository,
        );
      },
      act: (bloc) => bloc.add(
        const SaveCategory(category: 'category', idMerchant: 'idMerchant'),
      ),
      expect: () => const <AddCategoryState>[
        AddCategoryState(formzStatus: FormzStatus.submissionInProgress),
        AddCategoryState(formzStatus: FormzStatus.submissionSuccess)
      ],
    );
    blocTest<AddCategoryBloc, AddCategoryState>(
      'emits [submissionInProgress, submissionFailed] '
      'when save category failed',
      build: () {
        when(() => categoryRepository.addCategory(
              any(),
              any(),
            )).thenThrow(
          Exception(),
        );
        return AddCategoryBloc(
          categoryRepository: categoryRepository,
        );
      },
      act: (bloc) => bloc.add(
        const SaveCategory(category: 'category', idMerchant: 'idMerchant'),
      ),
      expect: () => const <AddCategoryState>[
        AddCategoryState(formzStatus: FormzStatus.submissionInProgress),
        AddCategoryState(formzStatus: FormzStatus.submissionFailure)
      ],
    );
  });

  group('CategoryChanges', () {
    blocTest<AddCategoryBloc, AddCategoryState>(
      'calls Category change',
      build: () {
        return AddCategoryBloc(
          categoryRepository: categoryRepository,
        );
      },
      act: (bloc) => bloc.add(CategoryChange('test')),
      expect: () => [
        isA<AddCategoryState>().having(
          (request) => request.categoryInput,
          'category',
          equals(CategoryInput.dirty('test')),
        ),
      ],
    );
  });
}
