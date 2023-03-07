part of 'list_merchant_login_bloc.dart';

enum ListMerchantLoginStatus { initial, loading, success, failure }

class ListMerchantLoginState extends Equatable {
  const ListMerchantLoginState.__({
    required this.status,
    this.items,
    this.errorMessage,
  });

  final ListMerchantLoginStatus status;
  final List<MerchantModel>? items;
  final String? errorMessage;

  const ListMerchantLoginState.initial()
      : this.__(status: ListMerchantLoginStatus.initial);

  const ListMerchantLoginState.loading()
      : this.__(status: ListMerchantLoginStatus.loading);

  const ListMerchantLoginState.success(List<MerchantModel> items)
      : this.__(
          status: ListMerchantLoginStatus.success,
          items: items,
        );

  const ListMerchantLoginState.failure(String errorMessage)
      : this.__(
          status: ListMerchantLoginStatus.failure,
          errorMessage: errorMessage,
        );

  @override
  List<Object?> get props => [status, items, errorMessage];

  ListMerchantLoginState copyWith({
    ListMerchantLoginStatus? status,
    List<MerchantModel>? items,
    String? errorMessage,
  }) {
    return ListMerchantLoginState.__(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
