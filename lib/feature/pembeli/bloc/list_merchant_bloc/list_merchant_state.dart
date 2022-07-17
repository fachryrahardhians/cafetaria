part of 'list_merchant_bloc.dart';

enum ListMerchantStatus { initial, loading, success, failure }

class ListMerchantState extends Equatable {
  const ListMerchantState.__({
    required this.status,
    this.items,
    this.errorMessage,
  });

  final ListMerchantStatus status;
  final List<MerchantModel>? items;
  final String? errorMessage;

  const ListMerchantState.initial()
      : this.__(status: ListMerchantStatus.initial);

  const ListMerchantState.loading()
      : this.__(status: ListMerchantStatus.loading);

  const ListMerchantState.success(List<MerchantModel> items)
      : this.__(
          status: ListMerchantStatus.success,
          items: items,
        );

  const ListMerchantState.failure(String errorMessage)
      : this.__(
          status: ListMerchantStatus.failure,
          errorMessage: errorMessage,
        );

  @override
  List<Object?> get props => [status, items, errorMessage];

  ListMerchantState copyWith({
    ListMerchantStatus? status,
    List<MerchantModel>? items,
    String? errorMessage,
  }) {
    return ListMerchantState.__(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
