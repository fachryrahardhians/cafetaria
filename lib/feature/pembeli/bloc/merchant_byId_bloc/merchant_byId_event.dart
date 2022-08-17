part of 'merchant_byId_bloc.dart';

abstract class MerchantByIdEvent extends Equatable {
  const MerchantByIdEvent();

  @override
  List<Object> get props => [];
}

class GetMerchantById extends MerchantByIdEvent {
  final String merchantId;

  const GetMerchantById(this.merchantId);

  @override
  List<Object> get props => [merchantId];
}
