import 'package:equatable/equatable.dart';
import 'package:penjual_order_repository/penjual_order_repository.dart';

abstract class PenjualOrderState extends Equatable {}

class PenjualOrderInit extends PenjualOrderState {
  @override
  List<Object?> get props => [];
}

class PenjualOrderLoading extends PenjualOrderState {
  @override
  List<Object?> get props => [];
}

class PenjualOrderSuccess extends PenjualOrderState {
  final List<PenjualOrderModel> list;
  List<PenjualOrderModel> get listBaru => _getterList("new");
  List<PenjualOrderModel> get listBooking => _getterList("booking");
  List<PenjualOrderModel> get diterima => _getterList("process");
  List<PenjualOrderModel> get ditolak => _getterList("declined");

  PenjualOrderSuccess(this.list);

  List<PenjualOrderModel> _getterList(String filter) {
    try {
      List<PenjualOrderModel> _temp = [];
      // _temp.removeWhere((el) => el.statusOrder != filter);
      for (var item in list) {
        if (item.statusOrder == filter) {
          _temp.add(item);
        }
      }
      return _temp;
    } catch (e) {
      return [];
    }
  }

  @override
  List<Object?> get props => [list];
}

class PenjualOrderError extends PenjualOrderState {
  final String error;

  PenjualOrderError(this.error);
  @override
  List<Object?> get props => [error];
}
