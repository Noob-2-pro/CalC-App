import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calc/bottomgrid.dart';
import 'UpperGrid.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _history = '';
  String _value = '';
  bool selected = false;

  void backspace() {
    if (_value.isNotEmpty) {
      setState(() {
        _value = _value.substring(0, _value.length - 1);
      });
    }
  }

  void allClear() {
    setState(() {
      _history = '';
      _value = '';
    });
  }

  void evaluate() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(valueManipulator());
      ContextModel cm = ContextModel();
       setState(() {
      _history = _value;
      try {
        _value = exp.evaluate(EvaluationType.REAL, cm).toString();
      } catch (e) {
        _value = 'Error';
      }
    });
    } on RangeError catch (e) {
      print(e);
    }

   
  }

  // ignore: missing_return
  String valueManipulator() {
    String c = '';
    if (_value.contains('π')) {
      c = _value.replaceAll(RegExp(r'π'), '*3.14285714*');
    } else if (_value.contains('sin⁻¹')) {
      c = _value.replaceAll(RegExp(r'sin⁻¹'), 'arcsin');
    } else if (_value.contains('cos⁻¹')) {
      c = _value.replaceAll(RegExp(r'cos⁻¹'), 'arccos');
    } else if (_value.contains('tan⁻¹')) {
      c = _value.replaceAll(RegExp(r'tan⁻¹'), 'arctan');
    } else if (_value.contains('²')) {
      c = _value.replaceAll(RegExp(r'²'), '');
      c = '$c*$c';
    } else
      return _value;

    print(c);
    return c;
  }

  void action(int int, List list) {
    setState(() {
      _value += list[int].toString();
    });

    print(_value);
  }

  void callbacks(int int, List list) {
    if (int == 3) {
      return evaluate();
    } else if (int == 16) {
      allClear();
    } else if (int == 18) {
      backspace();
    } else {
      return action(int, list);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 100, right: 20, bottom: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  _history,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black45),
                ),
              )),
          Align(
            alignment: Alignment.centerRight,
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              reverse: true,
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(right: 20, bottom: 50),
                child: Text(
                  _value,
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      UpperGrid(
        selected: selected,
        actions: action,
      ),
      Container(
        color: Color(0xFFe4f7f7),
        width: double.infinity,
        child: IconButton(
          icon: Icon(Icons.drag_handle),
          onPressed: () {
            setState(() {
              selected = !selected;
              print(selected);
            });
          },
        ),
      ),
      BottomGrid(
        selected: selected,
        callback: callbacks,
      ),
    ]);
  }
}
