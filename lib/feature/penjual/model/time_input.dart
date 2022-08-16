import 'package:formz/formz.dart';

enum TimeInputValidationError { invalid }

class TimeInput extends FormzInput<String, TimeInputValidationError> {
  const TimeInput.pure() : super.pure('');
  const TimeInput.dirty([String value = '']) : super.dirty(value);

  @override
  TimeInputValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : TimeInputValidationError.invalid;
  }
}
