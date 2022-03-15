import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerifyPhoneView extends StatefulWidget {
  final String yourPhone, verificationId;
  final int otpCount;
  final Function(UserCredential)? onSuccessVerify;
  final VoidCallback? onSendOTP;
  final Function(dynamic)? onErrorVerify;

  const VerifyPhoneView({
    required this.yourPhone,
    required this.verificationId,
    required this.otpCount,
    this.onSuccessVerify,
    this.onErrorVerify,
    this.onSendOTP,
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyPhoneView> createState() => _VerifyPhoneViewState();
}

class _VerifyPhoneViewState extends State<VerifyPhoneView> {
  final _smsCtr = TextEditingController();
  String get smsCode => _smsCtr.text;
  bool disable = true;
  final isLoading = ValueNotifier(false);

  @override
  void dispose() {
    _smsCtr.dispose();
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
              controller: _smsCtr,
              length: widget.otpCount,
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
                            : Text('Continue');
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

  void verifyOtp() async {
    if (smsCode.length == widget.otpCount) {
      isLoading.value = true;
      var credentials = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: smsCode,
      );
      await FirebaseAuth.instance
          .signInWithCredential(credentials)
          .then(widget.onSuccessVerify ?? _buildSuccessVerify)
          .catchError(widget.onErrorVerify ?? _buildErrorVerify);
      isLoading.value = false;
    }
  }

  void _buildSuccessVerify(value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Đăng nhập thành công'),
    ));
  }

  void _buildErrorVerify(error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Đăng nhập thất bại'),
    ));
  }
}
