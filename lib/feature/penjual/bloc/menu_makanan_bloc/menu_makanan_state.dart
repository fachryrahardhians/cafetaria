part of 'menu_makanan_bloc.dart';

abstract class MenuMakananState extends Equatable {
  const MenuMakananState();

  @override
  List<Object> get props => [];
}

class MenuMakananInitial extends MenuMakananState {}

class MenuMakananLoading extends MenuMakananState {}

class MenuMakananSuccess extends MenuMakananState {
  final List<CategoryMenuModel> items;

  const MenuMakananSuccess(this.items);

  @override
  List<Object> get props => [items];
}

class MenuMakananFailurre extends MenuMakananState {
  final String errorMessage;

  const MenuMakananFailurre(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
