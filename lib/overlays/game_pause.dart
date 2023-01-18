import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fruitality/widgets/game_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../game/fruitality_game.dart';

class GamePauseOverlay extends StatelessWidget {
  GamePauseOverlay({Key? key, required this.game}) : super(key: key);

  FruitaLityGame game;

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    game.togglePauseState();
                    game.resetGame();
                  },
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        // image: const DecorationImage(
                        //     image: AssetImage("assets/images/btn_bg.png"),
                        //     fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Quit game",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                )),
            Center(
                child: GestureDetector(
              onTap: () {
                game.togglePauseState();
              },
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 150,
              ),
            )),
            SlidingUpPanel(
              parallaxEnabled: true,
              margin: const EdgeInsets.only(left: 100, right: 100, top: 40),
              collapsed: Container(
                decoration:
                    BoxDecoration(color: Colors.white, borderRadius: radius),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Drag up for more options.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
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
                              Text(
                                "Fruits 4",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.blue[900]),
                              ),
                              Text(
                                "Points 45",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.blue[900]),
                              ),
                              Text(
                                "Level 3",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.blue[900]),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              panel: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You haven't played enough for game statistics.",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GameButton(
                        onTap: () {
                          game.togglePauseState();
                          game.resetGame();
                        },
                        label: "Quit Game")
                  ],
                ),
              ),
              borderRadius: radius,
            ),
          ],
        ),
      ),
    );
  }
}
