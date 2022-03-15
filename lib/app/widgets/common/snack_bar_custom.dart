import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarCustom {
  static showShackBar({String? errorText, String? successText}) => Get.snackbar(
        errorText != null ? 'ERROR' : 'SUCCESS',
        errorText ?? successText ?? '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: errorText != null ? Colors.red.shade200 : null,
      );
}
