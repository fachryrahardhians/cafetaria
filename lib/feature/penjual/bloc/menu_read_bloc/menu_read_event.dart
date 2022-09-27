part of 'menu_read_bloc.dart';

abstract class MenuReadEvent extends Equatable {
  const MenuReadEvent();

  @override
  List<Object> get props => [];
}

class GetMenuRead extends MenuReadEvent {
  final String idMerchant;

  const GetMenuRead(this.idMerchant);

  @override
  List<Object> get props => [idMerchant];
}
