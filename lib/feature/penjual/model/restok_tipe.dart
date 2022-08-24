import 'package:formz/formz.dart';

enum RestokTipeInputValidationError { invalid }

class RestokTipeInput
    extends FormzInput<String, RestokTipeInputValidationError> {
  const RestokTipeInput.pure() : super.pure('');
  const RestokTipeInput.dirty([String value = '']) : super.dirty(value);

  @override
  RestokTipeInputValidationError? validator(String value) {
    return value.isNotEmpty == true
        ? null
        : RestokTipeInputValidationError.invalid;
  }
}
