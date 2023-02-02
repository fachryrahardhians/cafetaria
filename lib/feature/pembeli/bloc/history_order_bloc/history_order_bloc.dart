// ignore_for_file: depend_on_referenced_packages

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_repository/order_repository.dart';

part 'history_order_event.dart';
part 'history_order_state.dart';

class HistoryOrderBloc extends Bloc<HistoryOrderEvent, HistoryOrderState> {
  final OrderRepository _orderRepository;
  final AuthenticationRepository _authenticationRepository;

  HistoryOrderBloc(
      {required OrderRepository orderRepository,
      required AuthenticationRepository authenticationRepository})
      : _orderRepository = orderRepository,
        _authenticationRepository = authenticationRepository,
        super(const HistoryOrderState.initial()) {
    on<GetHistoryOrder>(_getHistoryOrder);
  }

  Future<void> _getHistoryOrder(
    GetHistoryOrder event,
    Emitter<HistoryOrderState> emit,
  ) async {
    emit(const HistoryOrderState.loading());
    User? user = await _authenticationRepository.getCurrentUser();
    try {
      final items = await _orderRepository.getListOrderHistory(
          event.status, user!.uid.toString());

      emit(HistoryOrderState.success(items));
    } catch (error) {
      emit(HistoryOrderState.failure(error.toString()));
    }
  }
}
