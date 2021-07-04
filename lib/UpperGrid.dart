import 'package:flutter/material.dart';
import 'Constants.dart';

class UpperGrid extends StatefulWidget {
  final bool selected;
  final Function actions;
  UpperGrid({this.selected, this.actions});

  @override
  _UpperGridState createState() => _UpperGridState();
}

class _UpperGridState extends State<UpperGrid> {
  bool invselected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // duration: Duration(seconds: 5),
      // curve: Curves.fastOutSlowIn,
      color: Color(0xFF32363a),
      child: widget.selected
          ? GridView.builder(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, childAspectRatio: 2, mainAxisSpacing: 5),
              itemCount: 15,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, int) {
                return GestureDetector(
                  onTap: () {
                    if (int == 12) {
                      print('12');
                      setState(() {
                        invselected = !invselected;
                      });
                    } else if (int == 13) {
                      throw 'it doesn\'t work yet';
                    } else if (int == 14) {
                      throw 'it doesn\'t work yet';
                    } else
                      widget.actions(int, invselected ? kUpperINVGridText : kUpperGridText);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      invselected ? kUpperINVGridText[int].toString() : kUpperGridText[int].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w300),
                    ),
                  ),
                );
              },
            )
          : null,
    );
  }
}
