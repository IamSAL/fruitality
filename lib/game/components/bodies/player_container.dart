import 'package:flame/components.dart';
import 'package:fruitality/game/fruitality_game.dart';

class PlayerContainer extends SpriteComponent with HasGameRef<FruitaLityGame> {
  @override
  void onLoad() async {
    sprite = await gameRef.loadSprite('player_container.png');
    size = gameRef.player.size;
    position = Vector2(position.x, position.y - 0.03);
    anchor = Anchor.center;
    final arrowImage = await gameRef.loadSprite('arrow_head.png');
    // final playerArrow = SpriteComponent(
    //   size: Vector2.all(24),
    //   sprite: arrowImage,
    //   anchor: Anchor.center,
    //   position: Vector2(position.x + 50, position.y - 20),
    // );
    // add(playerArrow);
  }

}
