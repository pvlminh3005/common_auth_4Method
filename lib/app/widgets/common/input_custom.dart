import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/validator.dart';

class InputCustom extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isPassword, showBorder;
  final Icon? prefixIcon, suffixIcon;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLength;
  final TextStyle? style;
  final double? width;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const InputCustom({
    this.controller,
    this.hintText,
    this.isPassword = false,
    this.showBorder = true,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.maxLength,
    this.style,
    this.width,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    Key? key,
  }) : super(key: key);

  @override
  State<InputCustom> createState() => _InputCustomState();
}

class _InputCustomState extends State<InputCustom> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: BorderSide(
        color: widget.showBorder ? Colors.grey : Colors.transparent,
        width: .5,
      ),
    );

    return SizedBox(
      width: widget.width,
      child: TextFormField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        validator:
            widget.isPassword ? Validator.validatePassword : widget.validator,
        obscureText: widget.isPassword ? !showPassword : false,
        maxLength: widget.maxLength,
        style: widget.style,
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
      ),
    );
  }
}
