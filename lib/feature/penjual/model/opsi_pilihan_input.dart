import 'package:formz/formz.dart';

enum OpsiPilihanInputValidationError { invalid }

class OpsiPilihanInput
    extends FormzInput<String, OpsiPilihanInputValidationError> {
  const OpsiPilihanInput.pure() : super.pure('');
  const OpsiPilihanInput.dirty([String value = '']) : super.dirty(value);

  @override
  OpsiPilihanInputValidationError? validator(String value) {
    return value.isNotEmpty == true
        ? null
        : OpsiPilihanInputValidationError.invalid;
  }
}
