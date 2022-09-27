part of 'list_opsi_menu_bloc.dart';

abstract class ListOpsiMenuEvent extends Equatable {
  const ListOpsiMenuEvent();

  @override
  List<Object> get props => [];
}

class GetListOpsiMenu extends ListOpsiMenuEvent {
  final String idmenu;
  const GetListOpsiMenu(this.idmenu);
  @override
  List<Object> get props => [idmenu];
}
