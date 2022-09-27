import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cafetaria/feature/pembeli/model/order_input.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:order_repository/order_repository.dart';

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
      data.forEach((element) {
        if (element.rulepreordermenuId != '') result = true;
      });
      emit.call(CheckResult(result));
    } catch (e) {
      emit.call(CheckFailed(e.toString()));
    }
  }
}
