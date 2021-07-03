import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color textColor;
  final Function callback;
  final double textSize;
  Button({this.text, this.textColor, this.callback, this.textSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        child: Center(
            child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: textSize, color: textColor, fontWeight: FontWeight.w300),
        )),
        decoration: BoxDecoration(color: Color(0xFFe4f7f7)),
      ),
    );
  }
}
