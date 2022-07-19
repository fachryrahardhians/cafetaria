import 'package:formz/formz.dart';

enum HargaInputValidationError { invalid }

class HargaInput extends FormzInput<String, HargaInputValidationError> {
  const HargaInput.pure() : super.pure('');
  const HargaInput.dirty([String value = '']) : super.dirty(value);

  @override
  HargaInputValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : HargaInputValidationError.invalid;
  }
}
