import 'package:equatable/equatable.dart';
import 'package:penjual_order_repository/penjual_order_repository.dart';

class PenjualActionOrderState extends Equatable {
  final PenjualActionStatus? status;
  final String? error;
  final PenjualOrderModel? order;
  final String? keterangan;

  const PenjualActionOrderState.__(
      {required this.status, this.error, this.order, this.keterangan});

  const PenjualActionOrderState.initial()
      : this.__(status: PenjualActionStatus.init);

  PenjualActionOrderState copyWith({
    PenjualActionStatus? status,
    String? error,
    PenjualOrderModel? order,
    String? keterangan,
  }) =>
      PenjualActionOrderState.__(
          status: status ?? this.status,
          error: error ?? '',
          order: order ?? this.order,
          keterangan: keterangan ?? this.keterangan);

  ///set state initial
  PenjualActionOrderState setOrder(PenjualOrderModel order) =>
      copyWith(status: PenjualActionStatus.init, order: order);

  ///set state edit keterangan
  PenjualActionOrderState setKeterangan(String keterangan) =>
      copyWith(keterangan: keterangan);

  ///set state on loading
  PenjualActionOrderState setLoading() =>
      copyWith(status: PenjualActionStatus.loading);

  ///set state done
  PenjualActionOrderState setDone() =>
      copyWith(status: PenjualActionStatus.done);

  ///set state error
  PenjualActionOrderState setError({required String error}) =>
      copyWith(status: PenjualActionStatus.error, error: error);

  @override
  List<Object?> get props => [status, error, order, keterangan];
}

enum PenjualActionStatus { init, loading, done, error }
