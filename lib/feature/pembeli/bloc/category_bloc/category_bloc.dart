import 'package:bloc/bloc.dart';
import 'package:category_repository/category_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryBloc({
    required CategoryRepository categoryRepository,
  })  : _categoryRepository = categoryRepository,
        super(const CategoryState.initial()) {
    on<GetMenuMakanan>((event, emit) => _getMenuMakanan(emit, event));

  }

  Future<void> _getMenuMakanan(
    Emitter<CategoryState> emit,
    GetMenuMakanan event,
  ) async {
    emit(const CategoryState.loading());
    try {
      final items =
          await _categoryRepository.getCategoryMenuMerchant(event.idMerchant);
      emit(CategoryState.success(items));
    } catch (error) {
      emit(CategoryState.failure(error.toString()));
    }
  }
  
}
