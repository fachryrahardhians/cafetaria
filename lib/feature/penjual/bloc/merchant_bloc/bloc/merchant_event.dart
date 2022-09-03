part of 'merchant_bloc.dart';

abstract class MerchantEvent extends Equatable {
  const MerchantEvent();

  @override
  List<Object> get props => [];
}

class GetMerchant extends MerchantEvent {
  final String idUser;

  const GetMerchant(this.idUser);

  @override
  List<Object> get props => [idUser];
}
