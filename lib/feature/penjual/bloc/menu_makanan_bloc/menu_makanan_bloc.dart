import 'package:bloc/bloc.dart';
import 'package:category_repository/category_repository.dart';
import 'package:equatable/equatable.dart';

part 'menu_makanan_event.dart';
part 'menu_makanan_state.dart';

class MenuMakananBloc extends Bloc<MenuMakananEvent, MenuMakananState> {
  final CategoryRepository _categoryRepository;

  MenuMakananBloc({
    required CategoryRepository categoryRepository,
  })  : _categoryRepository = categoryRepository,
        super(const MenuMakananState.initial()) {
    on<GetMenuMakanan>((event, emit) => _getMenuMakanan(emit, event));
  }

  Future<void> _getMenuMakanan(
    Emitter<MenuMakananState> emit,
    GetMenuMakanan event,
  ) async {
    emit(const MenuMakananState.loading());
    try {
      final items = await _categoryRepository.getCategoryMenu(event.idMerchant);
      emit(MenuMakananState.success(items));
    } catch (error) {
      emit(MenuMakananState.failure(error.toString()));
    }
  }
}
