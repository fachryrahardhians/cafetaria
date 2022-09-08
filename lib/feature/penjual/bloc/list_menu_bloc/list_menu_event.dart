part of 'list_menu_bloc.dart';

abstract class ListMenuEvent extends Equatable {
  const ListMenuEvent();

  @override
  List<Object> get props => [];
}

class GetListMenu extends ListMenuEvent {
  final String idMerchant;
  final String idCategory;

  const GetListMenu(this.idMerchant, this.idCategory);

  @override
  List<Object> get props => [idMerchant, idCategory];
}

class GetListMenuTidakTersedia extends ListMenuEvent {
  final String idCategory;

  const GetListMenuTidakTersedia(this.idCategory);

  @override
  List<Object> get props => [idCategory];
}
