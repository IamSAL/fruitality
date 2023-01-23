import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:fruitality/game/testing/test_game.dart';

class TestGamePage extends StatelessWidget {
  const TestGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GameWidget(
        game: TestGame(),
      ),
    );
  }
}
