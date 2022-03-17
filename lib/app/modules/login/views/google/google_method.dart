import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_auth_firebase/app/packages/firebase_auth/screen/google_screen_auth.dart';
import 'package:test_auth_firebase/app/routes/app_pages.dart';

class LoginGoogleBuilder extends StatelessWidget {
  const LoginGoogleBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Sign in with Google'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GoogleScreenAuth(
            onSuccess: () => Get.offAllNamed(Routes.HOME),
          ),
        ),
      ),
    );
  }
}
