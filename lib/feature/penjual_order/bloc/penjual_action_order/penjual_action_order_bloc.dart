import 'package:bloc/bloc.dart';
import 'package:penjual_order_repository/penjual_order_repository.dart';

import 'penjual_action_order_event.dart';
import 'penjual_action_order_state.dart';

class PenjualActionOrderBloc
    extends Bloc<PenjualActionOrderEvent, PenjualActionOrderState> {
  final PenjualOrderRepository _repository;

  PenjualActionOrderBloc(PenjualOrderRepository repository)
      : _repository = repository,
        super(const PenjualActionOrderState.initial()) {
    on<ActionPenjualToOrder>((event, emit) => _action(event, emit));
    on<ActionPenjualInitial>((event, emit) => _initial(event, emit));
    on<ActionPenjualUpdateKeterangan>(
        (event, emit) => _updateKeterangan(event, emit));
  }

  void _initial(
      ActionPenjualInitial event, Emitter<PenjualActionOrderState> emit) {
    emit(state.setOrder(event.order));
  }

  void _updateKeterangan(ActionPenjualUpdateKeterangan event,
      Emitter<PenjualActionOrderState> emit) {
    emit(state.setKeterangan(event.value));
  }

  void _action(
      ActionPenjualToOrder event, Emitter<PenjualActionOrderState> emit) async {
    emit(state.setLoading());
    try {
      await _repository.actionToOrder(event.data, event.docId);
      emit(state.setDone());
    } catch (e) {
      emit(state.setError(error: e.toString()));
    }
  }
}
