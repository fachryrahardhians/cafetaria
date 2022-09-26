import 'package:formz/formz.dart';

enum OpsiInputValidationError { invalid }

class OpsiInput extends FormzInput<String, OpsiInputValidationError> {
  const OpsiInput.pure() : super.pure('');
  const OpsiInput.dirty([String value = '']) : super.dirty(value);

  @override
  OpsiInputValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : OpsiInputValidationError.invalid;
  }
}
