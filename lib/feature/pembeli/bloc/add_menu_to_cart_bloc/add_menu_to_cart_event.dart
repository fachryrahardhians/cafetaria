part of 'add_menu_to_cart_bloc.dart';

abstract class AddMenuToCartEvent extends Equatable {
  const AddMenuToCartEvent();

  @override
  List<Object> get props => [];
}

class AddMenuToCart extends AddMenuToCartEvent {
  final MenuModel menuModel;
  final int quantity;
  final int totalPrice;
  final List<Option>? option;
  final List<OrderTopping>? multiple;
  final String? notes;

  const AddMenuToCart(
      {required this.menuModel,
      required this.quantity,
      required this.totalPrice,
      this.multiple,
      this.option,
      this.notes});

  @override
  List<Object> get props => [menuModel];
}

class GetMenusInCart extends AddMenuToCartEvent {}

class RemoveAllMenuInCart extends AddMenuToCartEvent {}
