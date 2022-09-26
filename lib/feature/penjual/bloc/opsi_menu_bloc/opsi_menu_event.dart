part of 'opsi_menu_bloc.dart';

abstract class OpsiMenuEvent extends Equatable {
  const OpsiMenuEvent();

  @override
  List<Object> get props => [];
}

class OpsiMenuChange extends OpsiMenuEvent {
  final String name;
  const OpsiMenuChange(this.name);
  @override
  List<Object> get props => [name];
}

class OptionChange extends OpsiMenuEvent {
  final Option option;
  const OptionChange(this.option);
  @override
  List<Object> get props => [option];
}

class OptionIsiChange extends OpsiMenuEvent {
  final int index;
  final Option option;
  const OptionIsiChange(this.option, this.index);
  @override
  List<Object> get props => [option];
}

class WajibChecked extends OpsiMenuEvent {
  final bool wajib;
  const WajibChecked(this.wajib);
  @override
  List<Object> get props => [wajib];
}

class BanyakPorsiChecked extends OpsiMenuEvent {
  final bool porsi;
  const BanyakPorsiChecked(this.porsi);
  @override
  List<Object> get props => [porsi];
}

class SaveOpsi extends OpsiMenuEvent {
  final String menuId;
  const SaveOpsi(this.menuId);

  @override
  List<Object> get props => [menuId];
}
