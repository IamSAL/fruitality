import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruitality/game/fruitality_game.dart';
import 'package:fruitality/helpers/date_utils.dart';
import 'package:fruitality/helpers/managers/game_manager.dart';
import 'package:fruitality/widgets/game_button.dart';
import 'package:fruitality/widgets/game_overlay_card.dart';
import 'package:fruitality/widgets/horizontal_line_text.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverOverlay extends StatelessWidget {
  GameOverOverlay({Key? key, required this.game}) : super(key: key);

  FruitaLityGame game;

  final textStyle = GoogleFonts.rancho(fontSize: 40, fontWeight: FontWeight.w600, color: const Color(0xFF151515));

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
            _getWinOrLooseBlock(),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFC2C2C2), width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/fruit_generic.svg",
                        color: const Color(0xFF494949),
                        width: 30,
                        height: 25,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        game.gameManager.fruits.value.toString(),
                        style: const TextStyle(fontSize: 20, color: Color(0xFF494949), fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.alarm,
                        size: 30,
                        color: Color(0xFF494949),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        formatedTime(time: game.gameManager.elapsedSecs.value),
                        style: const TextStyle(fontSize: 20, color: Color(0xFF494949), fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
            ),
            const HorizontalLineText(
              label: "Fruitatistics",
              height: 35,
            ),
            const SizedBox(
              height: 10,
            ),
            GameButton(
              onTap: () {
                game.overlays.remove('gameOverOverlay');
                game.startGame();
              },
              label: "TRY AGAIN",
            )
          ],
        ),
      ),
    ));
  }

  Row _getWinOrLooseBlock() {
    switch (game.gameManager.result) {
      case GameResult.win:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/dino_dancing.png",
              width: 65,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              "Congrats!",
              style: textStyle,
            )
          ],
        );

      case GameResult.loose:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/dino_crying.png",
              width: 65,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              "You Loose!",
              style: textStyle,
            )
          ],
        );

      default:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/dino_dancing.png",
              width: 65,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              "Keep Playing!",
              style: textStyle,
            )
          ],
        );
    }
  }
}
