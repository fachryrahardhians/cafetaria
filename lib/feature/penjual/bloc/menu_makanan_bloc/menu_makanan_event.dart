part of 'menu_makanan_bloc.dart';

abstract class MenuMakananEvent extends Equatable {
  const MenuMakananEvent();

  @override
  List<Object> get props => [];
}

class GetMenuMakanan extends MenuMakananEvent {
  final String idMerchant;

  const GetMenuMakanan(this.idMerchant);

  @override
  List<Object> get props => [idMerchant];
}
