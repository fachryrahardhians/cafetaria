import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:penjual_repository/penjual_repository.dart';

part 'list_menu_event.dart';
part 'list_menu_state.dart';

class ListMenuBloc extends Bloc<ListMenuEvent, ListMenuState> {
  final MenuRepository _menuRepository;

  ListMenuBloc({
    required MenuRepository menuRepository,
  })  : _menuRepository = menuRepository,
        super(ListMenuInitial()) {
    on<GetListMenu>((event, emit) => _getListMenu(emit, event));
  }

  Future<void> _getListMenu(
    Emitter<ListMenuState> emit,
    GetListMenu event,
  ) async {
    emit(ListMenuLoading());

    try {
      final items = await _menuRepository.getMenu(
        event.idMerchant,
        event.idCategory,
      );

      emit(ListMenuSuccess(items));
    } catch (error) {
      emit(ListMenuFailure(error.toString()));
    }
  }
}
