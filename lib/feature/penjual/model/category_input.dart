import 'package:formz/formz.dart';

enum CategoryInputValidationError { invalid }

class CategoryInput extends FormzInput<String, CategoryInputValidationError> {
  const CategoryInput.pure() : super.pure('');
  const CategoryInput.dirty([String value = '']) : super.dirty(value);

  @override
  CategoryInputValidationError? validator(String value) {
    return value.isNotEmpty == true
        ? null
        : CategoryInputValidationError.invalid;
  }
}
