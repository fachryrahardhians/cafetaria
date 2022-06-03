import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:penjual_repository/penjual_repository.dart';

part 'menu_makanan_event.dart';
part 'menu_makanan_state.dart';

class MenuMakananBloc extends Bloc<MenuMakananEvent, MenuMakananState> {
  final MenuRepository _menuRepository;

  MenuMakananBloc({
    required MenuRepository menuRepository,
  })  : _menuRepository = menuRepository,
        super(MenuMakananInitial()) {
    on<GetMenuMakanan>((event, emit) => _getMenuMakanan(emit, event));
  }

  Future<void> _getMenuMakanan(
    Emitter<MenuMakananState> emit,
    GetMenuMakanan event,
  ) async {
    emit(MenuMakananLoading());
    try {
      final items = await _menuRepository.getCategoryMenu(event.idMerchant);
      emit(MenuMakananSuccess(items));
    } catch (error) {
      emit(MenuMakananFailurre(error.toString()));
    }
  }
}
