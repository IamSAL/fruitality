import 'package:flame/components.dart';

class World extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite("black_transparent_grid_sm.png");
    size = sprite!.originalSize;
    // size = Vector2(gameRef.size.length, gameRef.size.length);
    return super.onLoad();
  }
}
