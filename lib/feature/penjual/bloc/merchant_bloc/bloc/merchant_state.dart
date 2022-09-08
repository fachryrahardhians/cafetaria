part of 'merchant_bloc.dart';

enum MerchantStatus { initial, loading, success, failure }

class MerchantState extends Equatable {
  const MerchantState.__(
      {this.merchantModel, required this.status, this.error});
  final MerchantModel? merchantModel;
  final MerchantStatus status;
  final String? error;
  const MerchantState.initial() : this.__(status: MerchantStatus.initial);

  const MerchantState.loading() : this.__(status: MerchantStatus.loading);

  const MerchantState.success(MerchantModel items)
      : this.__(
          status: MerchantStatus.success,
          merchantModel: items,
        );

  const MerchantState.failure(String errorMessage)
      : this.__(
          status: MerchantStatus.failure,
          error: errorMessage,
        );

  @override
  List<Object?> get props => [status, merchantModel, error];

  MerchantState copyWith({
    MerchantStatus? status,
    MerchantModel? merchantModel,
    String? error,
  }) {
    return MerchantState.__(
      status: status ?? this.status,
      merchantModel: merchantModel ?? this.merchantModel,
      error: error ?? this.error,
    );
  }
}
