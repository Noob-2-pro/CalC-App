import 'package:flutter/material.dart';
import 'Constants.dart';

class UpperGrid extends StatelessWidget {
  final bool selected;
  final Function callback;
  UpperGrid({this.selected, this.callback});
  @override
  Widget build(BuildContext context) {
    return Container(
      // duration: Duration(seconds: 5),
      // curve: Curves.fastOutSlowIn,
      color: Color(0xFF32363a),
      child: selected
          ? GridView.builder(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, childAspectRatio: 2, mainAxisSpacing: 5),
              itemCount: 15,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, int) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      kscientificGridText[int].toString(),
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
