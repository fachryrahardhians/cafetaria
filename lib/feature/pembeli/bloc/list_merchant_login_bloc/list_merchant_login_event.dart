part of 'list_merchant_login_bloc.dart';

abstract class ListMerchantLoginEvent extends Equatable {
  const ListMerchantLoginEvent();

  @override
  List<Object> get props => [];
}

class GetListMerchantLogin extends ListMerchantLoginEvent {
  final String userId;
  const GetListMerchantLogin(this.userId);

  @override
  List<Object> get props => [userId];
}
