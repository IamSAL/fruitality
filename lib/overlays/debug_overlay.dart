import 'package:flame_forge2d/flame_forge2d.dart' hide Transform;
import 'package:flutter/material.dart';

import '../game/fruitality_game.dart';

class DebugOverlay extends StatelessWidget {
  DebugOverlay({Key? key, required this.game}) : super(key: key);

  FruitaLityGame game;

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      bottomLeft: Radius.circular(24.0),
      bottomRight: Radius.circular(24.0),
    );

    return Transform.translate(
      offset: const Offset(0, -2),
      child: Container(
        color: Colors.transparent,
        child: Container(
          height: 75,
          margin: const EdgeInsets.symmetric(horizontal: 150),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: radius,
              border: Border.all(color: Colors.white, width: 1)),
          child: Container(
            decoration:
                BoxDecoration(color: Colors.transparent, borderRadius: radius),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    game.overlays.remove("debugOverlay");
                  },
                  child: Transform.translate(
                    offset: const Offset(0, 18),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.close,
                          size: 25,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: game.zoomIn,
                              icon: const Icon(
                                Icons.zoom_in,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: game.zoomOut,
                              icon: const Icon(
                                Icons.zoom_out,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                game.camera.zoom = 100;
                              },
                              icon: const Icon(
                                Icons.fullscreen,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                game.camera.zoom = 1;
                              },
                              icon: const Icon(
                                Icons.fullscreen_exit,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                game.camera.shake(duration: 1, intensity: 5);
                                game.player.body
                                    .applyLinearImpulse(Vector2.all(550));
                              },
                              icon: const Icon(
                                Icons.fast_forward,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                // game.actorManager.ce;
                              },
                              icon: const Icon(
                                Icons.fork_right,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
