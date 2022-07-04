part of 'list_menu_bloc.dart';

abstract class ListMenuState extends Equatable {
  const ListMenuState();

  @override
  List<Object> get props => [];
}

class ListMenuInitial extends ListMenuState {}

class ListMenuLoading extends ListMenuState {}

class ListMenuSuccess extends ListMenuState {
  final List<MenuModel> items;

  const ListMenuSuccess(this.items);

  @override
  List<Object> get props => [items];
}

class ListMenuFailure extends ListMenuState {
  final String errorMessage;

  const ListMenuFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
