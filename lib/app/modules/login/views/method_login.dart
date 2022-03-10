import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_auth_firebase/app/routes/app_pages.dart';

class MethodLogin extends StatelessWidget {
  const MethodLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: 5.0,
          children: [
            _TextButton(
              'Sign in with Email',
              icon: Icons.email,
              onPressed: () => Get.toNamed(Routes.LOGIN + Routes.LOGIN_EMAIL),
            ),
            _TextButton(
              'Sign in with Phone',
              icon: Icons.phone,
              onPressed: () => Get.toNamed(Routes.LOGIN + Routes.LOGIN_PHONE),
            ),
            _TextButton(
              'Sign in with Google',
              icon: CupertinoIcons.globe,
              onPressed: () => Get.toNamed(Routes.LOGIN + Routes.LOGIN_PHONE),
            ),
            _TextButton(
              'Sign in with Facebook',
              icon: Icons.facebook,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _TextButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onPressed;

  const _TextButton(
    this.title, {
    this.icon,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(title),
    );
  }
}
