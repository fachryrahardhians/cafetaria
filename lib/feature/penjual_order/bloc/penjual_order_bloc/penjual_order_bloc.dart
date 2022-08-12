import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:penjual_order_repository/penjual_order_repository.dart';

import 'penjual_order_event.dart';
import 'penjual_order_state.dart';

class PenjualOrderBloc extends Bloc<PenjualOrderEvent, PenjualOrderState> {
  final PenjualOrderRepository _repository;
  PenjualOrderBloc(PenjualOrderRepository repository) :_repository = repository,
        super(PenjualOrderInit()) {
    // on<InitEvent>(_init);
    on<GetPenjualOrder>((event, emit) => _getListOrder(event, emit));
  }

  Future<void> _getListOrder(GetPenjualOrder event,Emitter<PenjualOrderState>
  emitter)
  async {
    emitter(PenjualOrderLoading());

    try{
      var result = await _repository.getOrder();
      if(kDebugMode){
        print("RESULT : ${result.length}");
      }
      emitter(PenjualOrderSuccess(result));

    }catch(e){
      emitter(PenjualOrderError(e.toString()));
    }

  }
}
