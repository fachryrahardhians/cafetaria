import 'package:formz/formz.dart';

enum StokInputValidationError { invalid }

class StokInput extends FormzInput<String, StokInputValidationError> {
  const StokInput.pure() : super.pure('');
  const StokInput.dirty([String value = '']) : super.dirty(value);

  @override
  StokInputValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : StokInputValidationError.invalid;
  }
}
