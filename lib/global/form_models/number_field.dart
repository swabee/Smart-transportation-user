import 'package:formz/formz.dart';

enum NumberFieldValidationError { empty, invalid, belowMin, exceedsMax }

class NumberField extends FormzInput<String, NumberFieldValidationError> {
  const NumberField.pure({this.minValue = 0, this.maxValue}) : super.pure('');
  const NumberField.dirty({this.minValue = 0, this.maxValue, String value = ''})
      : super.dirty(value);

  final int minValue;
  final int? maxValue;

  @override
  NumberFieldValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return NumberFieldValidationError.empty;
    }
    final number = num.tryParse(value);
    if (number == null) {
      return NumberFieldValidationError.invalid;
    }
    if (number <= minValue) {
      return NumberFieldValidationError.belowMin;
    }
    if (maxValue != null && number > maxValue!) {
      return NumberFieldValidationError.exceedsMax;
    }
    return null;
  }
}
