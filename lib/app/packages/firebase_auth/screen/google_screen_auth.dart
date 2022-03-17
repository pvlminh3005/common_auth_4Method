import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_auth_firebase/app/packages/firebase_auth/firebase_auth.dart';

class GoogleScreenAuth extends StatefulWidget {
  final VoidCallback onSuccess;
  final Function(dynamic)? onError;

  const GoogleScreenAuth({
    required this.onSuccess,
    this.onError,
    Key? key,
  }) : super(key: key);

  @override
  State<GoogleScreenAuth> createState() => _GoogleScreenAuthState();
}

class _GoogleScreenAuthState extends State<GoogleScreenAuth>
    with FirebaseAuthMixin {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await loginWithGoogle();
          widget.onSuccess();
        } on FirebaseAuthException catch (error) {
          if (widget.onError == null) {
            //...
          } else {
            widget.onError!(error);
          }
        }
      },
      child: SizedBox(
        height: 40.0,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network('https://freesvg.org/img/1534129544.png'),
            Expanded(
              child: Center(
                child: Text(
                  'Login with Google',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(10.0),
        primary: Colors.white,
      ),
    );
  }
}
