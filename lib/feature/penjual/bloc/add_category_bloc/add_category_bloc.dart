import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:penjual_repository/penjual_repository.dart';

part 'add_category_event.dart';
part 'add_category_state.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  final MenuRepository _menuRepository;
  AddCategoryBloc({
    required MenuRepository menuRepository,
  })  : _menuRepository = menuRepository,
        super(AddCategoryInitial()) {
    ///
    on<SaveCategory>((event, emit) => _saveCategory(event, emit));
  }

  Future<void> _saveCategory(
    SaveCategory event,
    Emitter<AddCategoryState> emit,
  ) async {
    emit(AddCategoryLoading());

    try {
      await _menuRepository.addCategory(
        event.idMerchant,
        event.category,
      );

      emit(AddCategorySuccess());
    } catch (e) {
      emit(AddCategoryFailure(e.toString()));
    }
  }
}
