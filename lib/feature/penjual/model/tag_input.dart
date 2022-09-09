import 'package:formz/formz.dart';

enum TagInputValidationError { invalid }

class TagInput extends FormzInput<String, TagInputValidationError> {
  const TagInput.pure() : super.pure('');
  const TagInput.dirty([String value = '']) : super.dirty(value);

  @override
  TagInputValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : TagInputValidationError.invalid;
  }
}
