part of 'opsi_menu_makanan_bloc.dart';

abstract class OpsiMenuMakananEvent extends Equatable {
  const OpsiMenuMakananEvent();

  @override
  List<Object> get props => [];
}

class GetOpsiMenuMakanan extends OpsiMenuMakananEvent {
  final String idMerchant;

  const GetOpsiMenuMakanan(this.idMerchant);

  @override
  List<Object> get props => [idMerchant];
}
