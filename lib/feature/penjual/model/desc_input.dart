import 'package:formz/formz.dart';

enum DeskripsiInputValidationError { invalid }

class DeskripsiInput extends FormzInput<String, DeskripsiInputValidationError> {
  const DeskripsiInput.pure() : super.pure('');
  const DeskripsiInput.dirty([String value = '']) : super.dirty(value);

  @override
  DeskripsiInputValidationError? validator(String value) {
    return value.isNotEmpty == true
        ? null
        : DeskripsiInputValidationError.invalid;
  }
}
