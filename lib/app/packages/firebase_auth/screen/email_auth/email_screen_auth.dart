import 'package:flutter/material.dart';
import 'package:test_auth_firebase/app/packages/firebase_auth/firebase_auth.dart';
import 'package:test_auth_firebase/app/packages/firebase_auth/widgets/scaffold_messenger.dart';
import 'package:test_auth_firebase/app/widgets/common/input_custom.dart';
import '../../../../utils/validator.dart';

class EmailScreenAuth extends StatefulWidget {
  const EmailScreenAuth({
    required this.onSuccess,
    this.onError,
    this.changeTab,
    Key? key,
  }) : super(key: key);

  final VoidCallback onSuccess;
  final Function(dynamic)? onError;
  final VoidCallback? changeTab;

  @override
  State<EmailScreenAuth> createState() => _EmailScreenAuthState();
}

class _EmailScreenAuthState extends State<EmailScreenAuth>
    with FirebaseAuthMixin {
  final isLoading = ValueNotifier(false);
  bool get _isLoading => isLoading.value;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String get emailText => emailController.text.trim();
  String get passwordText => passwordController.text;

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
        title: Text('LoginEmailView'),
        centerTitle: true,
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
                        await loginWithEmail(
                          email: emailText,
                          password: passwordText,
                        )
                            .then((value) => widget.onSuccess())
                            .catchError((error) {
                          if (widget.onError == null) {
                            customScaffoldMessenger(context,
                                errorText: error.message!.toString());
                          } else {
                            widget.onError!(error);
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
                                : Text('Sign In');
                          },
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: widget.changeTab,
                    child: Text('Sign up with Email'),
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
