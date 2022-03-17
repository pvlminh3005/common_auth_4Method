import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase_auth.dart';
import '../widgets/country_item.dart';
import '../widgets/scaffold_messenger.dart';
import 'verify_phone_screen_auth.dart';

class PhoneScreenAuth extends StatefulWidget {
  const PhoneScreenAuth({
    required this.onVerifySuccess,
    required this.onVerifyFailed,
    Key? key,
  }) : super(key: key);

  final Function(UserCredential) onVerifySuccess;
  final Function(dynamic) onVerifyFailed;

  @override
  State<PhoneScreenAuth> createState() => _PhoneScreenAuthState();
}

class _PhoneScreenAuthState extends State<PhoneScreenAuth>
    with FirebaseAuthMixin {
  final isLoading = ValueNotifier(false);
  bool get _isLoading => isLoading.value;
  bool disable = true;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController numCodeController =
      TextEditingController(text: '+84');
  String get phoneText => phoneController.text;
  String get numCodeText => numCodeController.text;

  @override
  void dispose() {
    phoneController.dispose();
    numCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in with phone'),
        centerTitle: true,
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputPhoneCustom(
              phoneController: phoneController,
              numCodeController: numCodeController,
              onChanged: (value) => setState(() {
                disable = value!.length < 10;
              }),
            ),
            const SizedBox(height: 15.0),
            ElevatedButton(
              onPressed: disable
                  ? null
                  : () async {
                      isLoading.value = true;
                      loginWithPhone(
                        phoneNumber: numCodeText + phoneText,
                        onSuccess: (verificationId, codeSent) {
                          isLoading.value = false;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => VerifyPhoneScreenAuth(
                                yourPhone: numCodeText +
                                    phoneText.replaceFirst('0', ''),
                                verificationId: verificationId,
                                onVerifySuccess: widget.onVerifySuccess,
                                onVerifyFailed: widget.onVerifyFailed,
                              ),
                            ),
                          );
                        },
                        onFailed: (error) {
                          isLoading.value = false;
                          customScaffoldMessenger(
                            context,
                            errorText: error!.message,
                          );
                        },
                        onTimeout: (String timeout) {
                          isLoading.value = false;
                          customScaffoldMessenger(
                            context,
                            errorText: 'Quá thời gian kết nối',
                          );
                        },
                      );
                    },
              child: SizedBox(
                width: double.infinity,
                height: 38.0,
                child: Center(
                  child: ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (ctx, _, __) {
                      return _isLoading
                          ? CircularProgressIndicator(
                              color: Theme.of(context).backgroundColor,
                              strokeWidth: 1.5,
                            )
                          : Text('Send OTP & Continue');
                    },
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputPhoneCustom extends StatelessWidget {
  final TextEditingController? numCodeController;
  final TextEditingController? phoneController;
  final Function(String?)? onChanged;

  const InputPhoneCustom({
    this.numCodeController,
    this.phoneController,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: Colors.grey.shade400,
        width: .7,
      ),
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: .5),
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CountryItem(controller: numCodeController),
            Expanded(
              child: TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                  counterText: '',
                  hintStyle: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                onChanged: onChanged,
                inputFormatters: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
