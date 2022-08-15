part of 'add_order_bloc.dart';

abstract class AddOrderEvent extends Equatable {
  const AddOrderEvent();

  @override
  List<Object> get props => [];
}

class SaveOrder extends AddOrderEvent {
  final bool preOrder;
  final String timestamp;
  final String pickupDate;
  final int grandTotalPrice;
  final String merchantId;
  final List<Keranjang> listKeranjang;

  const SaveOrder(
      {required this.preOrder,
      required this.grandTotalPrice,
      required this.timestamp,
      required this.pickupDate,
      required this.merchantId,
      required this.listKeranjang});

  @override
  List<Object> get props => [preOrder, timestamp, pickupDate];
}

class OrderChange extends AddOrderEvent {
  final String date;

  const OrderChange(this.date);

  @override
  List<Object> get props => [date];
}
