import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruitality/game/fruitality_game.dart';
import 'package:fruitality/widgets/game_button.dart';
import 'package:fruitality/widgets/game_overlay_card.dart';
import 'package:fruitality/widgets/horizontal_line_text.dart';

class GameStartMenuOverlay extends StatelessWidget {
  GameStartMenuOverlay({Key? key, required this.game}) : super(key: key);

  FruitaLityGame game;

  @override
  Widget build(BuildContext context) {
    return GameOverlayCard(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 5,
            ),
            SvgPicture.asset(
              "assets/images/frutality_logo.svg",
              width: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                hintText: 'visible to players in multiplayer mode.',
                labelText: 'Your name',
                prefixIcon: Icon(
                  Icons.masks,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const HorizontalLineText(
              label: "Choose avatar",
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/character_dino_circle.png",
                  width: 60,
                ),
                const SizedBox(
                  width: 20,
                ),
                Image.asset(
                  "assets/images/default_player.png",
                  width: 60,
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GameButton(
              onTap: () {
                game.startGame();
              },
              label: "Lets Feast",
            )
          ],
        ),
      ),
    ));
  }
}
