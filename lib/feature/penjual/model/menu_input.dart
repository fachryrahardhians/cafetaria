import 'package:formz/formz.dart';

enum MenuInputValidationError { invalid }

class MenuInput extends FormzInput<String, MenuInputValidationError> {
  const MenuInput.pure() : super.pure('');
  const MenuInput.dirty([String value = '']) : super.dirty(value);

  @override
  MenuInputValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : MenuInputValidationError.invalid;
  }
}
