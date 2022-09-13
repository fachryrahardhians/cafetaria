part of 'add_order_bloc.dart';

class AddOrderState extends Equatable {
  const AddOrderState({
    this.formzStatus = FormzStatus.pure,
    this.orderInput = const OrderInput.pure(),
  });

  final FormzStatus formzStatus;
  final OrderInput orderInput;

  @override
  List<Object?> get props => [
        formzStatus,
        OrderInput,
      ];

  AddOrderState copyWith({
    String? errorMessage,
    FormzStatus? formzStatus,
    OrderInput? orderInput,
  }) {
    return AddOrderState(
      formzStatus: formzStatus ?? this.formzStatus,
      orderInput: orderInput ?? this.orderInput,
    );
  }
}
