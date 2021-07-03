import 'package:flutter/material.dart';
import 'button.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
  List text = [0, '00', '.', '=', 1, 2, 3, '+', 4, 5, 6, '-', 7, 8, 9, '*', 'C', '%', '⌫', '/'];
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
    setState(() {
      _value = _value.substring(0, _value.length - 1);
    });
  }

  allClear() {
    setState(() {
      _history = '';
      _value = '';
    });
  }

  action(int int) {
    setState(() {
      _value += text[int].toString();
    });

    print(_value);
  }

  evaluate() {
    Parser p = Parser();
    Expression exp = p.parse(_value);
    ContextModel cm = ContextModel();

    setState(() {
      _history = _value;
      try {
        _value = exp.evaluate(EvaluationType.REAL, cm).toString();
      } catch (e) {
        _value = 'Error';
      }
    });

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
        padding: EdgeInsets.all(0),
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
