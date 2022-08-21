part of 'opsi_menu_makanan_bloc.dart';

abstract class OpsiMenuMakananEvent extends Equatable {
  const OpsiMenuMakananEvent();

  @override
  List<Object> get props => [];
}

class GetOpsiMenuMakanan extends OpsiMenuMakananEvent {
  final String menuId;

  const GetOpsiMenuMakanan(this.menuId);

  @override
  List<Object> get props => [menuId];
}
