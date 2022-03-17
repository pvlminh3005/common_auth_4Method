import 'package:get/get.dart';

class Validator {
  factory Validator() => _instance;
  Validator._internal();
  static final Validator _instance = Validator._internal();

  static String? validateEmail(String? value) {
    const String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    final RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Please enter email'.tr;
    } else if (!regex.hasMatch(value)) {
      return 'Please enter the correct email'.tr;
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    const String pattern = r'^.{6,}$';
    final RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Please enter password'.tr;
    } else if (!regex.hasMatch(value)) {
      return 'Password must be at least 6 characters.'.tr;
    } else {
      return null;
    }
  }

  static String? validateUserName(String? value) {
    return value != null && value.isEmpty ? 'Please enter a username.' : null;
  }

  static String? validateEmpty(String? value) {
    return value != null && value.isEmpty ? "Can't be left blank" : null;
  }
}
