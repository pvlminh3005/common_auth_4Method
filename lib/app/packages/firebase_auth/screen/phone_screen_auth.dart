import 'package:flutter/material.dart';

import '../firebase_auth.dart';

class PhoneScreenAuth extends StatefulWidget {
  const PhoneScreenAuth({Key? key}) : super(key: key);

  @override
  State<PhoneScreenAuth> createState() => _PhoneScreenAuthState();
}

class _PhoneScreenAuthState extends State<PhoneScreenAuth>
    with FirebaseAuthMixin {
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: loginWithGoogle, child: Text('Login'));
  }
}
