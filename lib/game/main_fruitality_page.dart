import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:fruitality/game/fruitality_game.dart';

import '../helpers/direction.dart';
import '../helpers/joypad.dart';

class MainFruitalityPage extends StatefulWidget {
  const MainFruitalityPage({Key? key}) : super(key: key);

  @override
  _MainFruitalityPageState createState() => _MainFruitalityPageState();
}

class _MainFruitalityPageState extends State<MainFruitalityPage> {
  FruitaLityGame _fruitaLityGame = FruitaLityGame();

  void onJoypadDirectionChanged(Direction direction) {
    _fruitaLityGame.onJoypadDirectionChanged(direction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        children: [
          GameWidget(game: _fruitaLityGame),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Joypad(onDirectionChanged: onJoypadDirectionChanged),
            ),
          )
        ],
      ),
    );
  }
}
