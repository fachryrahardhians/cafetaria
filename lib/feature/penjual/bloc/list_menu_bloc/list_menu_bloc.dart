import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'list_menu_event.dart';
part 'list_menu_state.dart';

class ListMenuBloc extends Bloc<ListMenuEvent, ListMenuState> {
  final MenuRepository _menuRepository;

  ListMenuBloc({
    required MenuRepository menuRepository,
  })  : _menuRepository = menuRepository,
        super(const ListMenuState.initial()) {
    on<GetListMenu>(_getListMenu);
    on<GetListMenuTidakTersedia>(_getListMenuTidakTersedia);
  }

  Future<void> _getListMenu(
    GetListMenu event,
    Emitter<ListMenuState> emit,
  ) async {
    emit(const ListMenuState.loading());
    SharedPreferences logindata = await SharedPreferences.getInstance();
    String idMerchant = logindata.getString('merchantId').toString();
    print(idMerchant);
    try {
      final items = await _menuRepository.getMenu(
        idMerchant,
        event.idCategory,
      );

      emit(ListMenuState.success(items));
    } catch (error) {
      emit(ListMenuState.failure(error.toString()));
    }
  }

  Future<void> _getListMenuTidakTersedia(
    GetListMenuTidakTersedia event,
    Emitter<ListMenuState> emit,
  ) async {
    emit(const ListMenuState.loading());
    SharedPreferences logindata = await SharedPreferences.getInstance();
    String idMerchant = logindata.getString('merchantId').toString();
    print(idMerchant);
    try {
      final items = await _menuRepository.getMenuStokTidakTersedia(
        idMerchant,
        event.idCategory,
      );

      emit(ListMenuState.success(items));
    } catch (error) {
      emit(ListMenuState.failure(error.toString()));
    }
  }
}
