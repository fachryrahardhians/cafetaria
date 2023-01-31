part of 'list_merchant_category_bloc.dart';

abstract class ListMerchantCategoryEvent extends Equatable {
  const ListMerchantCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetListMerchantCategory extends ListMerchantCategoryEvent {
  final String idMerchant;
  const GetListMerchantCategory(this.idMerchant);

  @override
  List<Object> get props => [];
}
