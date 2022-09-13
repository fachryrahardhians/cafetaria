part of 'add_menu_to_cart_bloc.dart';

class AddMenuToCartState extends Equatable {
  const AddMenuToCartState();

  @override
  List<Object?> get props => [];
}

class MenuAddedToTheCart extends AddMenuToCartState {}

class MenuInCartRetrieveLoading extends AddMenuToCartState {}

class MenuInCartRetrieved extends AddMenuToCartState {
  final List<Keranjang> menuInCart;
  final int totalPrice;
  const MenuInCartRetrieved(this.menuInCart, this.totalPrice);
}

class MenuInCartRetrieveFailed extends AddMenuToCartState {
  final String message;
  const MenuInCartRetrieveFailed(this.message);
}

class AllMenuRemoveLoading extends AddMenuToCartState {}

class AllMenuRemoved extends AddMenuToCartState {}
