import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../firebase_auth.dart';

class VerifyPhoneScreenAuth extends StatefulWidget {
  final String verificationId;
  final String? yourPhone;
  final Function(UserCredential) onVerifySuccess;
  final Function(dynamic) onVerifyFailed;

  const VerifyPhoneScreenAuth({
    required this.verificationId,
    this.yourPhone,
    required this.onVerifySuccess,
    required this.onVerifyFailed,
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyPhoneScreenAuth> createState() => _VerifyPhoneScreenAuthState();
}

class _VerifyPhoneScreenAuthState extends State<VerifyPhoneScreenAuth>
    with FirebaseAuthMixin {
  final _smsCtrl = TextEditingController();
  String get smsCode => _smsCtrl.text;
  bool disable = true;
  final isLoading = ValueNotifier(false);

  @override
  void dispose() {
    _smsCtrl.dispose();
    isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Verify OTP ${widget.yourPhone}'),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Pinput(
              controller: _smsCtrl,
              length: 6,
              onChanged: (value) {
                setState(() {
                  disable = value.length != 6;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: SizedBox(
                width: double.infinity,
                height: 35.0,
                child: Center(
                  child: ValueListenableBuilder(
                      valueListenable: isLoading,
                      builder: (ctx, status, child) {
                        return isLoading.value
                            ? CircularProgressIndicator(
                                color: Theme.of(context).backgroundColor,
                                strokeWidth: 1.5,
                              )
                            : Text('Verify OTP');
                      }),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(10.0),
              ),
              onPressed: disable ? null : verifyOtp,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyOtp() async {
    isLoading.value = true;
    await verifyPhoneNumber(
      verificationId: widget.verificationId,
      smsCode: smsCode,
      onError: (error) {
        isLoading.value = false;
        widget.onVerifyFailed(error);
      },
      onSuccess: (value) {
        isLoading.value = false;
        widget.onVerifySuccess(value);
      },
    );
  }
}
