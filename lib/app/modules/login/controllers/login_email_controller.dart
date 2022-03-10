import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_auth_firebase/app/data/services/auth_service.dart';

import '../../../routes/app_pages.dart';

class LoginEmailController extends GetxController {
  final AuthService _authService = Get.find();
  final formKey = GlobalKey<FormState>();
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> signIn() async {
    if (formKey.currentState!.validate()) {
      await _authService
          .signInWithEmail(
            email: usernameCtrl.text,
            password: passwordCtrl.text,
          )
          .then((value) => Get.offAllNamed(Routes.HOME))
          .catchError((error) {
        return error;
      });
    }
  }

  @override
  void onClose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
  }
}
