import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruitality/game/fruitality_game.dart';
import 'package:fruitality/helpers/date_utils.dart';

import '../helpers/joypad.dart';

class InGameOverlay extends StatelessWidget {
  const InGameOverlay({Key? key, required this.game}) : super(key: key);

  final FruitaLityGame game;

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topRight: Radius.circular(8.0),
      bottomRight: Radius.circular(8.0),
    );

    return Container(
      child: Stack(
        children: [
          Positioned(
              top: 20,
              child: Transform.translate(
                offset: const Offset(-1, 0),
                child: Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: radius,
                      border: Border.all(color: Colors.white, width: 0)),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.transparent, borderRadius: radius),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/fruit_generic.svg",
                          color: Colors.white,
                          width: 30,
                          height: 25,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        ValueListenableBuilder(
                            valueListenable: game.gameManager.fruits,
                            builder: (context, value, child) {
                              return Text(
                                value.toString(),
                                style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              )),
          Positioned(
              top: 20,
              right: 0,
              child: Transform.translate(
                offset: const Offset(1, 0),
                child: Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                      ),
                      border: Border.all(color: Colors.white, width: 0)),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.alarm,
                          size: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        ValueListenableBuilder(
                            valueListenable: game.gameManager.elapsedSecs,
                            builder: ((context, value, child) {
                              return Text(
                                formatedTime(time: value),
                                style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                              );
                            }))
                      ],
                    ),
                  ),
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Transform.translate(
              offset: const Offset(1, 4),
              child: Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(0),
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(0),
                    ),
                    border: Border.all(color: Colors.white, width: 0)),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Level",
                        style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        "1",
                        style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "2",
                        style:
                            TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.75), fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "3",
                        style:
                            TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.25), fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "4",
                        style:
                            TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.25), fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "5",
                        style:
                            TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.25), fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 75),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        game.togglePauseState();
                      },
                      icon: Icon(
                        Icons.pause_circle,
                        color: Colors.white.withOpacity(0.75),
                        size: 35,
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
                        size: 35,
                      )),
                ],
              ),
            ),
          ),
          ValueListenableBuilder(
              valueListenable: game.gameManager.pointerPosition,
              builder: (context, value, child) {
                return Positioned(
                    top: value.y - 50,
                    left: value.x - 50,
                    child: Joypad(onDirectionChanged: game.onJoypadDirectionChanged));
              })
        ],
      ),
    );
  }
}
