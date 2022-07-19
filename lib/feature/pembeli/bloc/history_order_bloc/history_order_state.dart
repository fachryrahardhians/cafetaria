part of 'history_order_bloc.dart';

enum HistoryOrderStatus { initial, loading, success, failure }

class HistoryOrderState extends Equatable {
  const HistoryOrderState.__({
    required this.status,
    this.items,
    this.errorMessage,
  });

  final HistoryOrderStatus status;
  final List<HistoryModel>? items;
  final String? errorMessage;

  const HistoryOrderState.initial()
      : this.__(status: HistoryOrderStatus.initial);

  const HistoryOrderState.loading()
      : this.__(status: HistoryOrderStatus.loading);

  const HistoryOrderState.success(List<HistoryModel> items)
      : this.__(
          status: HistoryOrderStatus.success,
          items: items,
        );

  const HistoryOrderState.failure(String errorMessage)
      : this.__(
          status: HistoryOrderStatus.failure,
          errorMessage: errorMessage,
        );

  @override
  List<Object?> get props => [status, items, errorMessage];

  HistoryOrderState copyWith({
    HistoryOrderStatus? status,
    List<HistoryModel>? items,
    String? errorMessage,
  }) {
    return HistoryOrderState.__(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
