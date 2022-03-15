import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_auth_firebase/app/modules/login/controllers/login_phone_controller.dart';
import 'package:test_auth_firebase/app/modules/login/views/phone/verify_phone_view.dart';
import 'package:test_auth_firebase/app/widgets/common/snack_bar_custom.dart';

import '../../../../routes/app_pages.dart';
import '../../../../widgets/common/input_phone_custom.dart';

class LoginPhoneBuilder extends GetView<LoginPhoneController> {
  const LoginPhoneBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginPhoneView'),
        centerTitle: true,
      ),
      body: PhoneLoginBuilder(
        numCodeController: controller.numberCodeController,
        phoneController: controller.phoneController,
        onFailed: (error) {
          SnackBarCustom.showShackBar(errorText: error.message.toString());
        },
        onTimeout: (timeOut) {
          SnackBarCustom.showShackBar(errorText: 'Quá thời gian kết nối');
        },
        onSuccessVerify: (_) => Get.offAllNamed(Routes.HOME),
      ),
    );
  }
}

class PhoneLoginBuilder extends StatefulWidget {
  const PhoneLoginBuilder({
    this.numCodeController,
    this.phoneController,
    this.otpCount = 6,
    this.onFailed,
    this.onCompleted,
    required this.onSuccessVerify,
    this.onSuccess,
    this.onTimeout,
    this.onErrorVerify,
    this.onSendOTP,
    Key? key,
  }) : super(key: key);
  final TextEditingController? numCodeController;
  final TextEditingController? phoneController;
  final int otpCount;
  final Function(FirebaseAuthException)? onFailed;
  final Function(PhoneAuthCredential)? onCompleted;
  final Function(String, int?)? onSuccess;
  final Function(dynamic)? onTimeout, onErrorVerify;
  final VoidCallback? onSendOTP;
  final Function(UserCredential)? onSuccessVerify;
  @override
  State<PhoneLoginBuilder> createState() => _PhoneLoginBuilderState();
}

class _PhoneLoginBuilderState extends State<PhoneLoginBuilder> {
  bool disableButton = true;
  final isLoading = ValueNotifier(false);
  String yourPhone = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputPhoneCustom(
              numCodeController: widget.numCodeController,
              phoneController: widget.phoneController,
              onChanged: (value) {
                final newValue = value!.replaceAll(' ', '');
                if (newValue.length >= 10) {
                  disableButton = false;
                } else {
                  disableButton = true;
                }
                setState(() {});
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
                                color: Colors.white,
                                strokeWidth: 1.5,
                              )
                            : Text('Continue');
                      }),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: const EdgeInsets.all(10.0),
              ),
              onPressed: widget.phoneController!.text.isEmpty
                  ? null
                  : () {
                      FocusScope.of(context).unfocus();
                      isLoading.value = true;
                      yourPhone = widget.phoneController!.text
                          .replaceFirst('0', widget.numCodeController!.text)
                          .replaceAll(' ', '');

                      FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: yourPhone,
                        verificationCompleted:
                            (PhoneAuthCredential credential) {
                          isLoading.value = false;
                          widget.onCompleted?.call(credential);
                          print(credential);
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          isLoading.value = false;
                          widget.onFailed?.call(e);
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          isLoading.value = false;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => VerifyPhoneView(
                                yourPhone: yourPhone,
                                verificationId: verificationId,
                                otpCount: widget.otpCount,
                                onSendOTP: widget.onSendOTP,
                                onSuccessVerify: widget.onSuccessVerify,
                                onErrorVerify: widget.onErrorVerify,
                              ),
                            ),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          isLoading.value = false;
                          widget.onTimeout?.call(verificationId);
                        },
                      );
                    },
            ),
          ],
        ),
      ),
    );
  }
}
