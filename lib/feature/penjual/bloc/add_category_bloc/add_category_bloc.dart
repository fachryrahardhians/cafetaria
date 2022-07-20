import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cafetaria/feature/penjual/model/category_input.dart';
import 'package:category_repository/category_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'add_category_event.dart';
part 'add_category_state.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  final CategoryRepository _categoryRepository;
  AddCategoryBloc({
    required CategoryRepository categoryRepository,
  })  : _categoryRepository = categoryRepository,
        super(const AddCategoryState()) {
    ///
    on<SaveCategory>(_saveCategory);

    on<CategoryChange>(_categoryChange);

    on<Increment>(_increment);
  }

  Future<void> _saveCategory(
    SaveCategory event,
    Emitter<AddCategoryState> emit,
  ) async {
    emit(state.copyWith(
      formzStatus: FormzStatus.submissionInProgress,
    ));

    try {
      await _categoryRepository.addCategory(
        event.idMerchant,
        event.category,
      );

      emit(state.copyWith(
          formzStatus: FormzStatus.submissionSuccess, counter: state.counter));
    } catch (e) {
      emit(state.copyWith(
        formzStatus: FormzStatus.submissionFailure,
      ));
    }
  }

  void _categoryChange(
    CategoryChange event,
    Emitter<AddCategoryState> emit,
  ) {
    final category = CategoryInput.dirty(event.name);

    emit(state.copyWith(
        categoryInput: category,
        formzStatus: Formz.validate([category]),
        counter: state.counter));
  }

  FutureOr<void> _increment(
    Increment event,
    Emitter<AddCategoryState> emit,
  ) {
    emit(state.copyWith(
      formzStatus: state.formzStatus,
      categoryInput: state.categoryInput,
      counter: state.counter + event.jumlahIncrement,
    ));
  }
}
