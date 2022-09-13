part of 'menu_in_cart_bloc.dart';

abstract class MenuInCartEvent extends Equatable {
  const MenuInCartEvent();

  @override
  List<Object> get props => [];
}

class GetMenusInCart extends MenuInCartEvent {}

class UpdateMenuInCart extends MenuInCartEvent {
  Keranjang menuKeranjang;
  UpdateMenuInCart(this.menuKeranjang);
}

class DeleteMenuInCart extends MenuInCartEvent {
  Keranjang menuKeranjang;
  DeleteMenuInCart(this.menuKeranjang);
}
