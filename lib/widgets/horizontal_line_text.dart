import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HorizontalLineText extends StatelessWidget {
  const HorizontalLineText({
    required this.label,
    this.height = 20,
  });

  final double height;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: Divider(
              color: Colors.black,
              height: height,
            )),
      ),
      Text(label),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: Divider(
              color: Colors.black,
              height: height,
            )),
      ),
    ]);
  }
}
