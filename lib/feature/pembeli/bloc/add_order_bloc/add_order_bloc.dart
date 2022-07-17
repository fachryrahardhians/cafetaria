import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cafetaria/feature/pembeli/model/order_input.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:order_repository/order_repository.dart';

part 'add_order_event.dart';
part 'add_order_state.dart';

class AddOrderBloc extends Bloc<AddOrderEvent, AddOrderState> {
  final OrderRepository _orderRepository;
  AddOrderBloc({
    required OrderRepository orderRepository,
  })  : _orderRepository = orderRepository,
        super(const AddOrderState()) {
    ///
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
      await _orderRepository.addOrder(HistoryModel(
          cash: 75000,
          change: '0',
          deviceToken: '',
          orderId: '',
          isCutlery: true,
          isPreorder: event.preOrder,
          pickupDate: event.pickupDate,
          timestamp: event.timestamp,
          statusOrder: 'process',
          typePickup: 'by user',
          total: 75000,
          userId: '7goTPZo9N2c9O1jm7A6bL0YIyMb2',
          merchantId: 'merchant1',
          menus: const [
            OrderMenu(
                menuId: 'menu-1',
                notes: 'sambal dipisah',
                price: 10500,
                qty: 50,
                toppings: [
                  OrderTopping(
                      items: [ToppingItem(name: 'Level 1-5', price: 1000)])
                ])
          ]));

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
