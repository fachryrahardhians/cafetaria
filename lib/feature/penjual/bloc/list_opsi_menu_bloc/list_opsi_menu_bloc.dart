import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:option_menu_repository/option_menu_repository.dart';

part 'list_opsi_menu_event.dart';
part 'list_opsi_menu_state.dart';

class ListOpsiMenuBloc extends Bloc<ListOpsiMenuEvent, ListOpsiMenuState> {
  final OptionMenuRepository _optionMenuRepository;
  ListOpsiMenuBloc({
    required OptionMenuRepository optionMenuRepository,
  })  : _optionMenuRepository = optionMenuRepository,
        super(const ListOpsiMenuState.initial()) {
    on<GetListOpsiMenu>(_getListOpsiMenu);
  }
  Future<void> _getListOpsiMenu(
      GetListOpsiMenu event, Emitter<ListOpsiMenuState> emit) async {
    emit(const ListOpsiMenuState.loading());
    try {
      final items = await _optionMenuRepository.getOptionMenu(event.idmenu);
      emit(ListOpsiMenuState.success(items));
    } catch (e) {
      emit(ListOpsiMenuState.failure(e.toString()));
    }
  }
}
