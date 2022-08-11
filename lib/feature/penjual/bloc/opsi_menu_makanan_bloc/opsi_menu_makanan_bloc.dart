import 'package:bloc/bloc.dart';
import 'package:cafetaria/feature/penjual/views/menu_cafetaria_page.dart';
import 'package:equatable/equatable.dart';
import 'package:option_menu_repository/option_menu_repository.dart';

part 'opsi_menu_makanan_event.dart';
part 'opsi_menu_makanan_state.dart';

class OpsiMenuMakananBloc extends Bloc<OpsiMenuMakananEvent, OpsiMenuMakananState> {
  final OptionMenuRepository _opsiMenuRepository;

  OpsiMenuMakananBloc({
    required OptionMenuRepository menuRepository,
  })  : _opsiMenuRepository = menuRepository,
        super(const OpsiMenuMakananState.initial()) {
    on<GetOpsiMenuMakanan>(_getOpsiMenu);
  }

  Future<void> _getOpsiMenu(
    GetOpsiMenuMakanan event,
    Emitter<OpsiMenuMakananState> emit,
  ) async {
    emit(const OpsiMenuMakananState.loading());

    try {

   final items = await _opsiMenuRepository.getOptionMenu(event.menuId);
      emit(OpsiMenuMakananState.success(items));
    } catch (error) {
      emit(OpsiMenuMakananState.failure(error.toString()));
    }
  }
}
