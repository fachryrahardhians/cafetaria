import 'package:equatable/equatable.dart';
import 'package:penjual_order_repository/penjual_order_repository.dart';

abstract class PenjualActionOrderEvent extends Equatable{}

class ActionPenjualInitial extends PenjualActionOrderEvent{
  final PenjualOrderModel order;

  ActionPenjualInitial(this.order);

  @override
  // TODO: implement props
  List<Object?> get props => [order];

}

class ActionPenjualUpdateKeterangan extends PenjualActionOrderEvent{
  final String value;

  ActionPenjualUpdateKeterangan(this.value);

  @override
  // TODO: implement props
  List<Object?> get props => [value];

}

class ActionPenjualToOrder extends PenjualActionOrderEvent {
  final Map<String,dynamic> data;
  final String docId;

  ActionPenjualToOrder({required this.data, required this.docId});

  @override
  List<Object?> get props => [data,docId];
}

