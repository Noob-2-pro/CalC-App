import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color textColor;
  final Function callback;
  Button({this.text, this.textColor, this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        child: Center(
            child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 45, color: textColor),
        )),
        decoration: BoxDecoration(color: Color(0xFFe4f7f7)),
      ),
    );
  }
}
