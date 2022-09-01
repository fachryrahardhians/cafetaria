part of 'check_menu_preorder_bloc.dart';

abstract class MenuPreorderEvent extends Equatable {
  const MenuPreorderEvent();

  @override
  List<Object> get props => [];
}

class MenuPreorder extends MenuPreorderEvent {
  final MenuModel menuModel;
  final int quantity;
  final int totalPrice;
  final String? notes;

  const MenuPreorder(
      {required this.menuModel,
      required this.quantity,
      required this.totalPrice,
      this.notes});

  @override
  List<Object> get props => [menuModel];
}

class CheckMenuPreorder extends MenuPreorderEvent {}

