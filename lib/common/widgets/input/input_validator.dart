import 'package:decimal/decimal.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:sapiency_app/common/widgets/input/date_input/date_input_helper.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class InputValidator {
  static String Function(BuildContext)? validateDateInput(String date) {
    if (date.length < 10) return (context) => context.strings.dateInput.error.required;
    if (!DateHelper.isInputValid(date)) return (context) => context.strings.dateInput.error.format;
    return null;
  }

  static String Function(BuildContext)? validateRequiredInput(String text) {
    if (text.isEmpty) return (context) => context.strings.input.error.required;
    return null;
  }

  static String Function(BuildContext)? validateEmailInput(String email) {
    if (email.isEmpty) return (context) => context.strings.emailInput.error.required;
    if (!EmailValidator.validate(email)) return (context) => context.strings.emailInput.error.format;
    return null;
  }

  static String Function(BuildContext)? validateMetatagsInput(List<String> tags) {
    if (tags.length < 3) return (context) => context.strings.matetagsInput.error.required;
    return null;
  }

  static String Function(BuildContext)? validatePassword(String value) {
    if (value.isEmpty) return (context) => context.strings.input.error.required;
    if (value.length < 8) return (context) => context.strings.nicknameInput.error.minLength(amount: "8");
    return null;
  }

  static String Function(BuildContext)? validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) return (context) => context.strings.input.error.required;
    if (confirmPassword != password) return (context) => context.strings.confirmPasswordInput.error.notMatch;
    return null;
  }

  static String Function(BuildContext)? validateTokenAmount(String value, Decimal totalAmount) {
    if (value.isEmpty) return (context) => context.strings.input.error.required;
    if (Decimal.parse(value) > totalAmount) return (context) => context.strings.tokenInput.error.notEnough;
    return null;
  }
}
