import 'package:email_validator/email_validator.dart';
import 'package:formz/formz.dart';

enum EmailValidationError { empty, notValid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String? value) {
    if (value?.isNotEmpty == true) {
      if (EmailValidator.validate(value!) == true) {
        return null;
      } else {
        return EmailValidationError.notValid;
      }
    } else {
      return EmailValidationError.empty;
    }
  }
}
