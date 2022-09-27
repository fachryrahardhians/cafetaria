import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';

part 'menu_read_event.dart';
part 'menu_read_state.dart';

class MenuReadBloc extends Bloc<MenuReadEvent, MenuReadState> {
  final MenuRepository _menuRepository;

  MenuReadBloc({
    required MenuRepository menuRepository,
  })  : _menuRepository = menuRepository,
        super(const MenuReadState.initial()) {
    on<GetMenuRead>(_getMenuRead);
  }
  Future<void> _getMenuRead(
    GetMenuRead event,
    Emitter<MenuReadState> emit,
  ) async {
    emit(const MenuReadState.loading());

    try {
      final items = await _menuRepository.getMenuRead(
        event.idMerchant,
      );

      emit(MenuReadState.success(items));
    } catch (error) {
      emit(MenuReadState.failure(error.toString()));
    }
  }
}
