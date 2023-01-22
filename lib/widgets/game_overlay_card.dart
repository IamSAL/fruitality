import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fruitality/helpers/num_utils.dart';

class GameOverlayCard extends StatelessWidget {
  final Widget child;
  const GameOverlayCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
      child: Container(
        width: MediaQuery.of(context).size.width.percent(100),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                  maxWidth: 550, maxHeight: 450, minHeight: 300, minWidth: 500),
              child: Card(
                  color: Colors.white,
                  elevation: 12, // Change this
                  shadowColor: Colors.black45, // Change this
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: child),
            ),
          ),
        ),
      ),
    );
  }
}
