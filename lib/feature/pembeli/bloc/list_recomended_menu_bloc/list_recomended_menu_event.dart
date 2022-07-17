part of 'list_recomended_menu_bloc.dart';

abstract class ListRecomendedMenuEvent extends Equatable {
  const ListRecomendedMenuEvent();

  @override
  List<Object> get props => [];
}

class GetListRecomendedMenu extends ListRecomendedMenuEvent {
  final String idMerchant;

  const GetListRecomendedMenu(this.idMerchant);

  @override
  List<Object> get props => [
        idMerchant,
      ];
}
