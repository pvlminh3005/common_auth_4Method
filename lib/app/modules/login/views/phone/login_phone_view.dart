import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_auth_firebase/app/packages/firebase_auth/screen/phone_screen_auth.dart';
import 'package:test_auth_firebase/app/packages/firebase_auth/widgets/scaffold_messenger.dart';
import '../../../../routes/app_pages.dart';
import '/app/modules/login/controllers/login_phone_controller.dart';

class LoginPhoneBuilder extends GetView<LoginPhoneController> {
  const LoginPhoneBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhoneScreenAuth(
        onVerifySuccess: (userCredential) {
          Get.offAllNamed(Routes.HOME);
        },
        onVerifyFailed: (value) {
          customScaffoldMessenger(context, errorText: 'Mã OTP không đúng');
        },
      ),
    );
  }
}
