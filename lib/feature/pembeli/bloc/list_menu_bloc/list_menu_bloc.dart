// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';

part 'list_menu_event.dart';
part 'list_menu_state.dart';

class ListMenuBloc extends Bloc<ListMenuEvent, ListMenuState> {
  final MenuRepository _menuRepository;

  ListMenuBloc({
    required MenuRepository menuRepository,
  })  : _menuRepository = menuRepository,
        super(const ListMenuState.initial()) {
    on<GetListMenu>(_getListMenu);
  }

  Future<void> _getListMenu(
    GetListMenu event,
    Emitter<ListMenuState> emit,
  ) async {
    emit(const ListMenuState.loading());

    try {
      final items = await _menuRepository.getMenuByMerchant(
        event.idMerchant,
      );

      emit(ListMenuState.success(items));
    } catch (error) {
      emit(ListMenuState.failure(error.toString()));
    }
  }
}
