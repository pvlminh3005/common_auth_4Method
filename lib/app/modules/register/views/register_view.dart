import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:test_auth_firebase/app/utils/validator.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/common/button_custom.dart';
import '../../../widgets/common/input_custom.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RegisterView'),
        centerTitle: true,
        leading: null,
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
                    'Sign Up',
                    color: Colors.green,
                    onPressed: controller.register,
                  ),
                  SizedBox(height: 20),
                  ButtonCustom(
                    'Sign In',
                    width: Get.size.width * .4,
                    onPressed: () => Get.offAndToNamed(Routes.LOGIN),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
