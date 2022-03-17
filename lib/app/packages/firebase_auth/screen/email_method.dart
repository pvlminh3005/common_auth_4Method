import 'package:flutter/material.dart';
import 'package:test_auth_firebase/app/packages/firebase_auth/screen/email_auth/email_screen_auth.dart';
import 'package:test_auth_firebase/app/packages/firebase_auth/screen/email_auth/email_screen_register_auth.dart';

enum EmailMethodType {
  login,
  register,
}

class EmailMethodBuilder extends StatefulWidget {
  final VoidCallback onSuccessLogin, onSuccessRegister;
  final Function(dynamic)? onErrorLogin, onErrorRegister;

  const EmailMethodBuilder({
    required this.onSuccessLogin,
    required this.onSuccessRegister,
    this.onErrorLogin,
    this.onErrorRegister,
    Key? key,
  }) : super(key: key);

  @override
  State<EmailMethodBuilder> createState() => _EmailMethodBuilderState();
}

class _EmailMethodBuilderState extends State<EmailMethodBuilder> {
  final _viewType = ValueNotifier(EmailMethodType.login);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _viewType,
        builder: (context, value, child) => AnimatedSwitcher(
          duration: kTabScrollDuration,
          child: _bodyBuilder(),
        ),
      ),
    );
  }

  Widget _bodyBuilder() {
    switch (_viewType.value) {
      case EmailMethodType.login:
        return EmailScreenAuth(
          onSuccess: widget.onSuccessLogin,
          onError: widget.onErrorLogin,
          changeTab: () => changeTab(EmailMethodType.register),
        );
      default:
        return EmailScreenRegisterAuth(
          onSuccess: widget.onSuccessRegister,
          onError: widget.onErrorRegister,
          changeTab: () => changeTab(EmailMethodType.login),
        );
    }
  }

  void changeTab(EmailMethodType type) => _viewType.value = type;
}
