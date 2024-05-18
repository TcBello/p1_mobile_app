import 'package:email_validator/email_validator.dart';

class ValidatorUtil {
  static String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return "Missing field";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Missing field";
    }

    if (!EmailValidator.validate(value)) {
      return "Invalid email";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Missing field";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Missing field";
    }

    if (value != password) {
      return "Password does not match";
    }

    return null;
  }
}
