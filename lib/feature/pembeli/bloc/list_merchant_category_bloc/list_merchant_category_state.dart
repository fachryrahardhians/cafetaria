part of 'list_merchant_category_bloc.dart';

enum ListMerchantCategoryStatus { initial, loading, success, failure }

class ListMerchantCategoryState extends Equatable {
  const ListMerchantCategoryState.__({
    required this.status,
    this.items,
    this.errorMessage,
  });

  final ListMerchantCategoryStatus status;
  final List<MenuCategory>? items;
  final String? errorMessage;

  const ListMerchantCategoryState.initial()
      : this.__(status: ListMerchantCategoryStatus.initial);

  const ListMerchantCategoryState.loading()
      : this.__(status: ListMerchantCategoryStatus.loading);

  const ListMerchantCategoryState.success(List<MenuCategory> items)
      : this.__(
          status: ListMerchantCategoryStatus.success,
          items: items,
        );

  const ListMerchantCategoryState.failure(String errorMessage)
      : this.__(
          status: ListMerchantCategoryStatus.failure,
          errorMessage: errorMessage,
        );

  @override
  List<Object?> get props => [status, items, errorMessage];

  ListMerchantCategoryState copyWith({
    ListMerchantCategoryStatus? status,
    List<MenuCategory>? items,
    String? errorMessage,
  }) {
    return ListMerchantCategoryState.__(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
