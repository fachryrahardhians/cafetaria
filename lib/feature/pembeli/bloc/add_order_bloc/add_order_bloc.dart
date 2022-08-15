import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cafetaria/feature/pembeli/model/order_input.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:order_repository/order_repository.dart';

part 'add_order_event.dart';
part 'add_order_state.dart';

class AddOrderBloc extends Bloc<AddOrderEvent, AddOrderState> {
  final OrderRepository _orderRepository;
  AddOrderBloc({
    required OrderRepository orderRepository,
  })  : _orderRepository = orderRepository,
        super(const AddOrderState()) {
    on<SaveOrder>(_saveOrder);
    on<OrderChange>(_orderChange);
  }

  Future<void> _saveOrder(
    SaveOrder event,
    Emitter<AddOrderState> emit,
  ) async {
    emit(state.copyWith(
      formzStatus: FormzStatus.submissionInProgress,
    ));

    try {
      var listMenu = event.listKeranjang.map((e) {
        return OrderMenu(
            menuId: e.menuId,
            notes: e.notes,
            price: e.price,
            qty: e.quantity,
            toppings: [OrderTopping(items: [])]);
      }).toList();
      await _orderRepository.addOrder(HistoryModel(
          cash: 0,
          change: '0',
          deviceToken: null,
          orderId: null,
          isCutlery: true,
          isPreorder: event.preOrder,
          pickupDate: event.pickupDate,
          timestamp: event.timestamp,
          statusOrder: 'process',
          typePickup: 'by user',
          total: event.grandTotalPrice,
          userId: '7goTPZo9N2c9O1jm7A6bL0YIyMb2',
          merchantId: event.merchantId,
          menus: listMenu));

      emit(state.copyWith(
        formzStatus: FormzStatus.submissionSuccess,
      ));
    } catch (e) {
      print(e);
      emit(state.copyWith(
        formzStatus: FormzStatus.submissionFailure,
      ));
    }
  }

  void _orderChange(
    OrderChange event,
    Emitter<AddOrderState> emit,
  ) {
    final order = OrderInput.dirty(event.date);

    emit(state.copyWith(
      orderInput: order,
      formzStatus: Formz.validate([order]),
    ));
  }
}
