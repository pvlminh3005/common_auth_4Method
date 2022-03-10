import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_auth_firebase/app/widgets/button_custom.dart';
import 'package:test_auth_firebase/app/widgets/input_custom.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/validator.dart';
import '../controllers/login_email_controller.dart';

class LoginEmailView extends GetView<LoginEmailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginView'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            key: controller.formKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputCustom(
                    controller: controller.usernameCtrl,
                    hintText: 'Username',
                    validator: Validator.validateEmail,
                    prefixIcon: Icon(Icons.account_circle_rounded),
                  ),
                  const SizedBox(height: 10),
                  InputCustom(
                    controller: controller.passwordCtrl,
                    hintText: 'Password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 10),
                  ButtonCustom(
                    'Sign In',
                    color: Colors.green,
                    onPressed: controller.signIn,
                  ),
                  SizedBox(height: 20),
                  ButtonCustom(
                    'Sign Up',
                    onPressed: () => Get.offAndToNamed(Routes.REGISTER),
                    width: Get.size.width * .4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
