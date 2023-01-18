import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:fruitality/game/fruitality_game.dart';

class GameStartMenuOverlay extends StatelessWidget {
  FruitaLityGame game;
  GameStartMenuOverlay({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Starts overlay"),
          ElevatedButton(
              onPressed: () {
                game.startGame();
              },
              child: Text("Start game")),
        ],
      ),
    );
  }
}
