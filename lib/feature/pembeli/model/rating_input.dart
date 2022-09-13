import 'package:formz/formz.dart';

enum RatingInputValidationError { invalid }

class RatingInput extends FormzInput<String, RatingInputValidationError> {
  const RatingInput.pure() : super.pure('');
  const RatingInput.dirty([String value = '']) : super.dirty(value);

  @override
  RatingInputValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : RatingInputValidationError.invalid;
  }
}
