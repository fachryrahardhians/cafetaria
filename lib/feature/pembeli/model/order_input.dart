import 'package:formz/formz.dart';

enum OrderInputValidationError { invalid }

class OrderInput extends FormzInput<String, OrderInputValidationError> {
  const OrderInput.pure() : super.pure('');
  const OrderInput.dirty([String value = '']) : super.dirty(value);

  @override
  OrderInputValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : OrderInputValidationError.invalid;
  }
}
