import 'package:flutter/material.dart';
import 'package:test_auth_firebase/app/packages/firebase_auth/firebase_auth.dart';
import 'package:test_auth_firebase/app/utils/validator.dart';
import '../../../../widgets/common/input_custom.dart';
import '../../widgets/scaffold_messenger.dart';

class EmailScreenRegisterAuth extends StatefulWidget {
  const EmailScreenRegisterAuth({
    required this.onSuccess,
    this.onError,
    this.changeTab,
    Key? key,
  }) : super(key: key);

  final Function() onSuccess;
  final Function(dynamic)? onError;
  final VoidCallback? changeTab;

  @override
  State<EmailScreenRegisterAuth> createState() =>
      _EmailScreenRegisterAuthState();
}

class _EmailScreenRegisterAuthState extends State<EmailScreenRegisterAuth>
    with FirebaseAuthMixin {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String get emailText => emailController.text.trim();
  String get passwordText => passwordController.text;

  final isLoading = ValueNotifier(false);
  bool get _isLoading => isLoading.value;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputCustom(
                    controller: emailController,
                    hintText: 'Username',
                    validator: Validator.validateEmail,
                    prefixIcon: Icon(Icons.account_circle_rounded),
                  ),
                  const SizedBox(height: 10),
                  InputCustom(
                    controller: passwordController,
                    hintText: 'Password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      WidgetsBinding.instance!.focusManager.primaryFocus
                          ?.unfocus();
                      isLoading.value = true;
                      if (formKey.currentState!.validate()) {
                        await createAccountWithEmail(
                          email: emailText,
                          password: passwordText,
                        )
                            .then((value) => widget.onSuccess())
                            .catchError((error) {
                          if (widget.onError == null) {
                            customScaffoldMessenger(context,
                                errorText: error.text!.toString());
                          }
                        });
                      }
                      isLoading.value = false;
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
                                : Text('Sign Up');
                          },
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    child: Text('Sign In'),
                    onPressed: widget.changeTab,
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
