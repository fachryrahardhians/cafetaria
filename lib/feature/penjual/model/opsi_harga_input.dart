import 'package:formz/formz.dart';

enum OpsiHargaValidationError { invalid }

class OpsiHarga extends FormzInput<String, OpsiHargaValidationError> {
  const OpsiHarga.pure() : super.pure('');
  const OpsiHarga.dirty([String value = '']) : super.dirty(value);

  @override
  OpsiHargaValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : OpsiHargaValidationError.invalid;
  }
}
