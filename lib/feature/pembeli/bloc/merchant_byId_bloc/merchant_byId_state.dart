part of 'merchant_byId_bloc.dart';

enum MerchantByIdStatus { initial, loading, success, failure }

class MerchantByIdState extends Equatable {
  const MerchantByIdState.__({
    required this.status,
    this.model,
    this.errorMessage,
  });

  final MerchantByIdStatus status;
  final MerchantModel? model;
  final String? errorMessage;

  const MerchantByIdState.initial()
      : this.__(status: MerchantByIdStatus.initial);

  const MerchantByIdState.loading()
      : this.__(status: MerchantByIdStatus.loading);

  const MerchantByIdState.success(MerchantModel item)
      : this.__(
    status: MerchantByIdStatus.success,
    model: item,
  );

  const MerchantByIdState.failure(String errorMessage)
      : this.__(
    status: MerchantByIdStatus.failure,
    errorMessage: errorMessage,
  );

  @override
  List<Object?> get props => [status, model, errorMessage];

  MerchantByIdState copyWith({
    MerchantByIdStatus? status,
    MerchantModel? item,
    String? errorMessage,
  }) {
    return MerchantByIdState.__(
      status: status ?? this.status,
      model: item ?? this.model,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
