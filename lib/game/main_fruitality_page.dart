import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:fruitality/game/fruitality_game.dart';
import 'package:fruitality/overlays/debug_overlay.dart';

import '../overlays/game_over.dart';
import '../overlays/game_pause.dart';
import '../overlays/game_start.dart';
import '../overlays/in_game_overlay.dart';

class MainFruitalityPage extends StatefulWidget {
  const MainFruitalityPage({Key? key}) : super(key: key);

  @override
  _MainFruitalityPageState createState() => _MainFruitalityPageState();
}

class _MainFruitalityPageState extends State<MainFruitalityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/outside_map_bg_lg.png"),
                fit: BoxFit.cover,
                repeat: ImageRepeat.repeatX),
          ),
          child: GameWidget(
            game: FruitaLityGame(deviceSize: MediaQuery.of(context).size),
            overlayBuilderMap: <String,
                Widget Function(BuildContext, FruitaLityGame)>{
              'startMenuOverlay': (context, game) =>
                  GameStartMenuOverlay(game: game),
              'pauseMenuOverlay': (context, game) => GamePauseOverlay(
                    game: game,
                  ),
              'gameOverOverlay': (context, game) => GameOverOverlay(
                    game: game,
                  ),
              'inGameOverlay': (context, game) => InGameOverlay(
                    game: game,
                  ),
              'debugOverlay': (context, game) => DebugOverlay(
                    game: game,
                  ),
            },
          )),
    );
  }
}
