part of 'list_menu_bloc.dart';

abstract class ListMenuEvent extends Equatable {
  const ListMenuEvent();

  @override
  List<Object> get props => [];
}

class GetListMenu extends ListMenuEvent {
  final String idMerchant;

  const GetListMenu(this.idMerchant);

  @override
  List<Object> get props => [
        idMerchant,
      ];
}
