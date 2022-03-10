import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/validator.dart';

class InputCustom extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isPassword;
  final Icon? prefixIcon, suffixIcon;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const InputCustom({
    this.controller,
    this.hintText,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  State<InputCustom> createState() => _InputCustomState();
}

class _InputCustomState extends State<InputCustom> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      validator:
          widget.isPassword ? Validator.validatePassword : widget.validator,
      obscureText: widget.isPassword ? !showPassword : false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.grey.shade100,
            width: .5,
          ),
        ),
        hintStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Colors.black54,
        ),
        hintText: widget.hintText,
        prefixIconColor: Colors.black,
        suffixIconColor: Colors.black,
        prefixIcon: widget.isPassword ? Icon(Icons.lock) : widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: () => setState(() => showPassword = !showPassword),
                child: Icon(
                  showPassword
                      ? CupertinoIcons.eye_solid
                      : CupertinoIcons.eye_slash_fill,
                ),
              )
            : widget.suffixIcon,
      ),
    );
  }
}
