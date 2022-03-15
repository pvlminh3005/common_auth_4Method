import 'package:flutter/material.dart';

class ButtonCustom extends StatefulWidget {
  final String title;
  final Function? onPressed;
  final Color color;
  final double? width;
  final bool disable;

  const ButtonCustom(
    this.title, {
    this.onPressed,
    this.color = Colors.blue,
    this.width,
    this.disable = false,
    Key? key,
  }) : super(key: key);

  @override
  State<ButtonCustom> createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom> {
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        primary: widget.onPressed != null ? widget.color : Colors.grey.shade300,
      ),
      child: SizedBox(
        width: widget.width ?? double.infinity,
        height: 35.0,
        child: Center(
          child: loading
              ? CircularProgressIndicator(
                  strokeWidth: 1.5,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
              : Text(widget.title),
        ),
      ),
      onPressed: widget.disable
          ? null
          : () async {
              setState(() => loading = true);
              await widget.onPressed!();
              if (mounted) {
                setState(() => loading = false);
              }
            },
    );
  }
}
