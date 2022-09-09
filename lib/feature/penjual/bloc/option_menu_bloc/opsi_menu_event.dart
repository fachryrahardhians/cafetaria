part of 'opsi_menu_bloc.dart';

abstract class OpsiMenuEvent extends Equatable {
  const OpsiMenuEvent();

  @override
  List<Object> get props => [];
}

class GetOpsiMenu extends OpsiMenuEvent {
  final String idMenu;

  const GetOpsiMenu(this.idMenu);

  @override
  List<Object> get props => [idMenu];
}
