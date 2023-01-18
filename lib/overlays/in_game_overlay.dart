import 'package:flutter/material.dart';
import 'package:fruitality/game/fruitality_game.dart';

import '../helpers/joypad.dart';

class InGameOverlay extends StatelessWidget {
  const InGameOverlay({Key? key, required this.game}) : super(key: key);

  final FruitaLityGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 60),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        game.togglePauseState();
                      },
                      icon: Icon(
                        Icons.pause_circle,
                        color: Colors.white.withOpacity(0.75),
                        size: 40,
                      )),
                  IconButton(
                      onPressed: () {
                        // game.overlays.remove('inGameOverlay');
                        if (game.overlays.isActive('debugOverlay')) {
                          game.overlays.remove('debugOverlay');
                        } else {
                          game.overlays.add('debugOverlay');
                        }
                      },
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white.withOpacity(0.75),
                        size: 40,
                      ))
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
              child: Joypad(onDirectionChanged: game.onJoypadDirectionChanged),
            ),
          ),
        ],
      ),
    );
  }
}
