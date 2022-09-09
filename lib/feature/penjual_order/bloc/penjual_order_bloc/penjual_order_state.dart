import 'package:equatable/equatable.dart';
import 'package:penjual_order_repository/penjual_order_repository.dart';

abstract class PenjualOrderState extends Equatable {}


class PenjualOrderInit extends PenjualOrderState{
  @override
  List<Object?> get props => [];
}
class PenjualOrderLoading extends PenjualOrderState{
  @override
  List<Object?> get props => [];
}
class PenjualOrderSuccess extends PenjualOrderState{

  final List<PenjualOrderModel> list;

  PenjualOrderSuccess(this.list);

  @override
  List<Object?> get props => [list];
}
class PenjualOrderError extends PenjualOrderState{
  final String error;

  PenjualOrderError(this.error);
  @override
  List<Object?> get props => [error];
}
