import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_auth_firebase/app/data/services/auth_service.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/common/snack_bar_custom.dart';

class LoginPhoneController extends GetxController {
  final AuthService _authService = Get.find();

  late TextEditingController numberCodeController;
  late TextEditingController phoneController;
  late TextEditingController verifyController;
  late String verificationId;

  Rx<bool> _disableButton = true.obs;
  bool get disableButton => _disableButton.value;
  set disableButton(bool status) => _disableButton(status);

  String get phoneNumber => phoneController.text;
  @override
  void onInit() {
    numberCodeController = TextEditingController(text: '+84');
    phoneController = TextEditingController();
    verifyController = TextEditingController();
    super.onInit();
  }

  void changePhone() {
    if (phoneController.text.length > 10) {
      _disableButton(false);
      return;
    }
    _disableButton(true);
  }

  void completedVerify() {
    if (verifyController.text.length >= 6) {
      _disableButton(false);
      return;
    }
    _disableButton(true);
  }

  void goBack() {
    Get.back();
    verifyController.clear();
  }

  void verifyPhoneNumber() async {
    String yourPhone = phoneNumber.replaceFirst('0', numberCodeController.text);
    _authService.signInWithPhoneNumber(
      yourPhone,
      onSuccess: (String ved) => verificationId = ved,
      onFailed: (error) {
        return SnackBarCustom.showShackBar(errorText: error.message);
      },
    );
  }

  void sendVerifyOTP() async {
    await _authService.verifyOTP(
        verificationId: verificationId,
        code: verifyController.text,
        onSuccess: (userCredential) {
          Get.offAllNamed(Routes.HOME);
          verifyController.clear();
        },
        onError: (error) {
          return SnackBarCustom.showShackBar(
              errorText: error.message.toString());
        });
  }

  @override
  void onClose() {
    phoneController.dispose();
    verifyController.dispose();
  }
}
