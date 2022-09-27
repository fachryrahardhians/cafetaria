//import 'dart:async';

// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
//import 'package:cafetaria/feature/pembeli/model/order_input.dart';
import 'package:equatable/equatable.dart';
//import 'package:formz/formz.dart';
import 'package:menu_repository/menu_repository.dart';
//import 'package:order_repository/order_repository.dart';

part 'add_menu_to_cart_event.dart';
part 'add_menu_to_cart_state.dart';

class AddMenuToCartBloc extends Bloc<AddMenuToCartEvent, AddMenuToCartState> {
  final MenuRepository _menuRepository;
  AddMenuToCartBloc({
    required MenuRepository menuRepository,
  })  : _menuRepository = menuRepository,
        super(const AddMenuToCartState()) {
    ///
    on<AddMenuToCart>(_addMenuToCart);
    on<GetMenusInCart>(_getMenusInCart);
    on<RemoveAllMenuInCart>(_deleteAllMenuInKeranjang);
  }

  void _addMenuToCart(
    AddMenuToCart event,
    Emitter<AddMenuToCartState> emit,
  ) async {
    try {
      await _menuRepository.addMenutoKeranjang(
          event.menuModel, event.quantity, event.totalPrice, event.notes);
      emit.call(MenuAddedToTheCart());
    } catch (e) {
      print(e);
    }
  }

  void _getMenusInCart(
    GetMenusInCart event,
    Emitter<AddMenuToCartState> emit,
  ) async {
    emit.call(MenuInCartRetrieveLoading());
    try {
      var data = await _menuRepository.getMenuInKeranjang();
      var totalPrice = 0;
      data.forEach((element) {
        totalPrice += element.totalPrice;
      });
      emit.call(MenuInCartRetrieved(data, totalPrice));
    } catch (e) {
      emit.call(MenuInCartRetrieveFailed(e.toString()));
    }
  }

  void _deleteAllMenuInKeranjang(
    RemoveAllMenuInCart event,
    Emitter<AddMenuToCartState> emit,
  ) async {
    emit.call(AllMenuRemoveLoading());
    await _menuRepository
        .deleteAllMenuInKeranjang()
        .then((value) => emit.call(AllMenuRemoved()));
  }
}
