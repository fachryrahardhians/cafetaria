import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cafetaria/feature/pembeli/model/order_input.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:order_repository/order_repository.dart';
import 'package:uuid/uuid.dart';

part 'add_order_event.dart';
part 'add_order_state.dart';

class AddOrderBloc extends Bloc<AddOrderEvent, AddOrderState> {
  final OrderRepository _orderRepository;
  final AuthenticationRepository _authtenticationRepository;
  AddOrderBloc(
      {required OrderRepository orderRepository,
      required AuthenticationRepository authenticationRepository})
      : _orderRepository = orderRepository,
        _authtenticationRepository = authenticationRepository,
        super(const AddOrderState()) {
    on<SaveOrder>(_saveOrder);
    on<OrderChange>(_orderChange);
  }

  final _uuid = const Uuid();

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
      User? user = await _authtenticationRepository.getCurrentUser();
      await _orderRepository.addOrder(HistoryModel(
          deviceToken: await _authtenticationRepository.getFcmToken(),
          orderId: _uuid.v4(),
          isCutlery: true,
          isPreorder: event.preOrder,
          pickupDate: event.pickupDate,
          timestamp: event.timestamp,
          statusOrder: 'process',
          typePickup: 'by user',
          total: event.grandTotalPrice,
          userId: user?.uid,
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
