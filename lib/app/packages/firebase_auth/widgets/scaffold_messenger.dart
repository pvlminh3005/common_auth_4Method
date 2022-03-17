import 'package:flutter/material.dart';

void customScaffoldMessenger(
  BuildContext context, {
  String? successText,
  String? errorText,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(successText ?? errorText ?? ''),
    backgroundColor: errorText != null ? Colors.red.shade300 : Colors.green,
  ));
}
