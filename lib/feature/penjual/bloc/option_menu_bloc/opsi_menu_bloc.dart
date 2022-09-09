import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:option_menu_repository/option_menu_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'opsi_menu_event.dart';
part 'opsi_menu_state.dart';

class OpsiMenuBloc extends Bloc<OpsiMenuEvent, OpsiMenuState> {
  final OptionMenuRepository _opsimenuRepository;

  OpsiMenuBloc({
    required OptionMenuRepository opsimenuRepository,
  })  : _opsimenuRepository = opsimenuRepository,
        super(const OpsiMenuState.initial()) {
    on<GetOpsiMenu>(_getOpsiMenu);
  }

  Future<void> _getOpsiMenu(
    GetOpsiMenu event,
    Emitter<OpsiMenuState> emit,
  ) async {
    emit(const OpsiMenuState.loading());
    SharedPreferences id = await SharedPreferences.getInstance();
    String idMerchant = id.getString("merchantId").toString();
    try {
      final items = await _opsimenuRepository.getOpsiMenu(
        idMerchant,
        event.idMenu,
      );
      emit(OpsiMenuState.success(items));
    } catch (error) {
      emit(OpsiMenuState.failure(error.toString()));
    }
  }
}
