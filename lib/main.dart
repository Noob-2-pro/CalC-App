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
  List scientificText = ['sin', 'cos', 'tan', 'log', 'In', '(', ')', '^', '√', '!', 'π', 'e', 'INV', 'RAD', 'DEG'];

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
  bool selected = false;

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
      Column(
        children: [
          SizedBox(
            height: 100,
          ),
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
        ],
      ),
      SizedBox(height: 30),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Color(0xFF32363a)),
        child: GestureDetector(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, childAspectRatio: 2),
            itemCount: 15,
            itemBuilder: (context, int) {
              return GestureDetector(
                onTap: () {
                  print(scientificText[int].toString());
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    scientificText[int].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w300),
                  ),
                ),
              );
            },
          ),
          onTap: () {},
        ),
      ),
      Container(
        color: Color(0xFFe4f7f7),
        width: double.infinity,
        child: Icon(Icons.menu),
      ),
      GridView.builder(
        padding: EdgeInsets.all(0),
        reverse: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 1.5),
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
