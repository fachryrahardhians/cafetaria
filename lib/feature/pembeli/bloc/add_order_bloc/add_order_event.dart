part of 'add_order_bloc.dart';

abstract class AddOrderEvent extends Equatable {
  const AddOrderEvent();

  @override
  List<Object> get props => [];
}

class SaveOrder extends AddOrderEvent {
  final bool preOrder;
  final bool alat;
  final String timestamp;
  final String pickupDate;
  final int grandTotalPrice;
  final String merchantId;
  final List<Keranjang> listKeranjang;
  final String? catatan;

  const SaveOrder(
      {required this.preOrder,
      required this.alat,
      required this.grandTotalPrice,
      this.catatan,
      required this.timestamp,
      required this.pickupDate,
      required this.merchantId,
      required this.listKeranjang});

  @override
  List<Object> get props => [preOrder, alat, timestamp, pickupDate, catatan!];
}

class OrderChange extends AddOrderEvent {
  final String date;

  const OrderChange(this.date);

  @override
  List<Object> get props => [date];
}
