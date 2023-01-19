import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final textStyle = GoogleFonts.racingSansOne(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    shadows: const [
      Shadow(
          // bottomLeft
          offset: Offset(-1.5, -1.5),
          color: Color(0xFF3D3D3D)),
      Shadow(
          // bottomRight
          offset: Offset(1.5, -1.5),
          color: Color(0xFF3D3D3D)),
      Shadow(
          // topRight
          offset: Offset(1.5, 1.5),
          color: Color(0xFF3D3D3D)),
      Shadow(
          // topLeft
          offset: Offset(-1.5, 1.5),
          color: Color(0xFF3D3D3D)),
    ]);

class GameButton extends StatefulWidget {
  const GameButton({Key? key, required this.onTap, required this.label})
      : super(key: key);

  final String label;
  final VoidCallback onTap;

  @override
  _GameButtonState createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: Container(
            width: 160,
            height: 45,
            decoration: BoxDecoration(
                color: Colors.black,
                image: const DecorationImage(
                    image: AssetImage("assets/images/btn_bg.png"),
                    fit: BoxFit.cover),
                // button text
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFC2C2C2), width: 2)),
            child: Center(
              child: Text(
                widget.label,
                style: textStyle,
              ),
            )));
  }
}
