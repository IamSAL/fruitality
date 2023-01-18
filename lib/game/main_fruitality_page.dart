import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:fruitality/game/fruitality_game.dart';

import '../helpers/direction.dart';
import '../helpers/joypad.dart';
import '../screens/game_over.dart';
import '../screens/game_pause.dart';
import '../screens/game_start.dart';

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
      backgroundColor: Colors.blueGrey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/outside_map_bg_lg.png"),
              fit: BoxFit.cover,
              repeat: ImageRepeat.repeatX),
        ),
        child: Stack(
          children: [
            GameWidget(
              game: _fruitaLityGame,
              overlayBuilderMap: <String,
                  Widget Function(BuildContext, FruitaLityGame)>{
                'startMenuOverlay': (context, game) =>
                    GameStartMenuOverlay(game: game),
                'pauseMenuOverlay': (context, game) => GamePauseOverlay(),
                'gameOverOverlay': (context, game) => GameOverOverlay(),
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                child: Joypad(onDirectionChanged: onJoypadDirectionChanged),
              ),
            )
          ],
        ),
      ),
    );
  }
}
