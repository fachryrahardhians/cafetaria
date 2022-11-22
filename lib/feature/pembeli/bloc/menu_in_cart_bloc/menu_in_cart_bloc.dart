import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';
part 'menu_in_cart_event.dart';
part 'menu_in_cart_state.dart';

class MenuInCartBloc extends Bloc<MenuInCartEvent, MenuInCartState> {
  final MenuRepository _menuRepository;
  MenuInCartBloc({
    required MenuRepository menuRepository,
  })  : _menuRepository = menuRepository,
        super(const MenuInCartState()) {
    on<GetMenusInCart>(_getMenusInCart);
    on<DeleteMenuInCart>(_deleteMenuInCart);
    on<UpdateMenuInCart>(_updateMenuInCart);
  }

  void _getMenusInCart(
    GetMenusInCart event,
    Emitter<MenuInCartState> emit,
  ) async {
    emit.call(MenuInCartRetrieveLoading());
    try {
      var data = await _menuRepository.getMenuInKeranjang();
      var totalPrice = 0;
      for (var element in data) {
        totalPrice += element.totalPrice;
        // if (element.options != null) {
        //   for (var e in element.options!) {
        //     totalPrice += int.parse(e.price.toString());
        //   }
        // }
        if (element.toppings != null) {
          element.toppings?.forEach((element) {
            element.items?.forEach((element2) {
              totalPrice += int.parse(element2.price.toString());
            });
          });
        }
      }
      emit.call(MenuInCartRetrieved(data, totalPrice));
    } catch (e) {
      emit.call(MenuInCartRetrieveFailed(e.toString()));
    }
  }

  void _deleteMenuInCart(
    DeleteMenuInCart event,
    Emitter<MenuInCartState> emit,
  ) async {
    await _menuRepository.deleteMenuFromKeranjang(event.menuKeranjang);
    emit.call(MenuInCartDeleted());
  }

  void _updateMenuInCart(
    UpdateMenuInCart event,
    Emitter<MenuInCartState> emit,
  ) async {
    await _menuRepository.updateMenuKeranjang(event.menuKeranjang);
    emit.call(MenuInCartUpdated());
  }
}
