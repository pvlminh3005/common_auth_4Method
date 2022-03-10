import 'package:get/get.dart';

class SnackBarCustom {
  static showShackBar({String? errorText, String? successText}) => Get.snackbar(
        errorText != null ? 'ERROR' : 'SUCCESS',
        errorText ?? successText ?? '',
        snackPosition: SnackPosition.BOTTOM,
      );
}
