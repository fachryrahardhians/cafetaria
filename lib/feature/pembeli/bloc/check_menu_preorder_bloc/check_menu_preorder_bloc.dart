// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import 'package:menu_repository/menu_repository.dart';

part 'check_menu_preorder_event.dart';
part 'check_menu_preorder_state.dart';

class MenuPreorderBloc extends Bloc<MenuPreorderEvent, MenuPreorderState> {
  final MenuRepository _menuRepository;
  MenuPreorderBloc({
    required MenuRepository menuRepository,
  })  : _menuRepository = menuRepository,
        super(const MenuPreorderState()) {
    ///
    on<CheckMenuPreorder>(_checkMenuPreorder);
  }

  void _checkMenuPreorder(
    CheckMenuPreorder event,
    Emitter<MenuPreorderState> emit,
  ) async {
    emit.call(CheckLoading());
    try {
      var data = await _menuRepository.getMenuInKeranjang();
      bool result = false;
      for (var element in data) {
        if (element.rulepreordermenuId != '') result = true;
      }
      emit.call(CheckResult(result));
    } catch (e) {
      emit.call(CheckFailed(e.toString()));
    }
  }
}
