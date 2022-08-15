part of 'menu_in_cart_bloc.dart';

class MenuInCartState extends Equatable {
  const MenuInCartState();

  @override
  List<Object?> get props => [];
}

class MenuInCartRetrieveLoading extends MenuInCartState {}

class MenuInCartRetrieved extends MenuInCartState {
  final List<Keranjang> menuInCart;
  final int totalPrice;
  const MenuInCartRetrieved(this.menuInCart, this.totalPrice);
}

class MenuInCartRetrieveFailed extends MenuInCartState {
  final String message;
  const MenuInCartRetrieveFailed(this.message);
}
