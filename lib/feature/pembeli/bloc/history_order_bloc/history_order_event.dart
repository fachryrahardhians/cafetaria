part of 'history_order_bloc.dart';

abstract class HistoryOrderEvent extends Equatable {
  const HistoryOrderEvent();

  @override
  List<Object> get props => [];
}

class GetHistoryOrder extends HistoryOrderEvent {
  final String status;

  const GetHistoryOrder(this.status);

  @override
  List<Object> get props => [status];
}
