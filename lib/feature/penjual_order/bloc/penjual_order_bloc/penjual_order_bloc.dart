import 'package:bloc/bloc.dart';
import 'package:penjual_order_repository/penjual_order_repository.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';

import 'penjual_order_event.dart';
import 'penjual_order_state.dart';

class PenjualOrderBloc extends Bloc<PenjualOrderEvent, PenjualOrderState> {
  final PenjualOrderRepository _repository;
  final AppSharedPref _appSharedPref;
  PenjualOrderBloc(
      PenjualOrderRepository repository, AppSharedPref appSharedPref)
      : _repository = repository,
        _appSharedPref = appSharedPref,
        super(PenjualOrderInit()) {
    // on<InitEvent>(_init);
    on<GetPenjualOrder>((event, emit) => _getListOrder(event, emit));
  }

  Future<void> _getListOrder(
      GetPenjualOrder event, Emitter<PenjualOrderState> emitter) async {
    emitter(PenjualOrderLoading());
    final idMerchant = await _appSharedPref.getMerchantId();
    try {
      var result = await _repository.getOrder(idMerchant!);

      emitter(PenjualOrderSuccess(result));
    } catch (e) {
      emitter(PenjualOrderError(e.toString()));
    }
  }
}
