import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';

part 'list_recomended_menu_event.dart';
part 'list_recomended_menu_state.dart';

class ListRecomendedMenuBloc
    extends Bloc<ListRecomendedMenuEvent, ListRecomendedMenuState> {
  final MenuRepository _menuRepository;

  ListRecomendedMenuBloc({
    required MenuRepository menuRepository,
  })  : _menuRepository = menuRepository,
        super(const ListRecomendedMenuState.initial()) {
    on<GetListRecomendedMenu>(_getListRecomendedMenu);
  }

  Future<void> _getListRecomendedMenu(
    GetListRecomendedMenu event,
    Emitter<ListRecomendedMenuState> emit,
  ) async {
    emit(const ListRecomendedMenuState.loading());

    try {
      final items = await _menuRepository.getRecommendedMenuByMerchant(
        event.idMerchant,
      );

      emit(ListRecomendedMenuState.success(items));
    } catch (error) {
      emit(ListRecomendedMenuState.failure(error.toString()));
    }
  }
}
