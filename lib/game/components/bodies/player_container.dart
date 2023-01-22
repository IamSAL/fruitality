import 'package:flame/components.dart';
import 'package:fruitality/game/fruitality_game.dart';

class PlayerContainer extends SpriteComponent with HasGameRef<FruitaLityGame> {
  @override
  void onLoad() async {
    sprite = await gameRef.loadSprite('player_container.png');
    size = gameRef.player.size;
    position = Vector2(position.x, position.y - 3);
    anchor = Anchor.center;

    final arrowImage = await gameRef.loadSprite('arrow_head.png');
    final playerArrow = SpriteComponent(
      size: Vector2.all(24),
      sprite: arrowImage,
      position: Vector2(position.x + 40, position.y - 20),
    );
    add(playerArrow);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }
}
