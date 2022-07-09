import 'package:bloc/bloc.dart';
import 'package:category_repository/category_repository.dart';
import 'package:equatable/equatable.dart';

part 'add_category_event.dart';
part 'add_category_state.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  final CategoryRepository _categoryRepository;
  AddCategoryBloc({
    required CategoryRepository categoryRepository,
  })  : _categoryRepository = categoryRepository,
        super(AddCategoryInitial()) {
    ///
    on<SaveCategory>(_saveCategory);
  }

  Future<void> _saveCategory(
    SaveCategory event,
    Emitter<AddCategoryState> emit,
  ) async {
    emit(AddCategoryLoading());

    try {
      await _categoryRepository.addCategory(
        event.idMerchant,
        event.category,
      );

      emit(AddCategorySuccess());
    } catch (e) {
      emit(AddCategoryFailure(e.toString()));
    }
  }
}
