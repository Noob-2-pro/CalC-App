import 'package:flutter/material.dart';
import 'button.dart';

void main() {
  runApp(CalC());
}

class CalC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List text = [0, '00', '.', '=', 1, 2, 3, '+', 4, 5, 6, '-', 7, 8, 9, 'x', 'C', '%', '⌫', '÷'];
  List<Color> textColor = [
    Colors.black,
    Colors.black,
    Colors.black,
    Color(0xFF35d5d2),
    Colors.black,
    Colors.black,
    Colors.black,
    Color(0xFF35d5d2),
    Colors.black,
    Colors.black,
    Colors.black,
    Color(0xFF35d5d2),
    Colors.black,
    Colors.black,
    Colors.black,
    Color(0xFF35d5d2),
    Colors.black,
    Colors.black,
    Colors.black,
    Color(0xFF35d5d2)
  ];
  List<Function> callbacks = [];
  String _history = '';
  String _value = '';

  backspace() {
    print('ok');
  }

  allClear() {
    setState(() {
      _history = '';
      _value = '';
    });

    print('cleared');
  }

  action(int int) {
    setState(() {
      _value += text[int].toString();
    });

    print(_value);
  }

  evaluate() {
    print('okev');
  }

  callback(int int) {
    if (int == 3) {
      return evaluate();
    } else if (int == 16) {
      allClear();
    } else if (int == 18) {
      backspace();
    } else {
      return action(int);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Align(
        alignment: Alignment.centerRight,
        child: SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(right: 20, bottom: 20),
            child: Text(
              _value,
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      Padding(
          padding: EdgeInsets.only(right: 20),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              _history,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black45),
            ),
          )),
      GridView.builder(
        padding: EdgeInsets.only(top: 25),
        reverse: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 20,
        itemBuilder: (context, int) {
          return Button(
              text: text[int].toString(),
              textColor: textColor[int],
              callback: () {
                callback(int);
              });
        },
      ),
    ]);
  }
}
