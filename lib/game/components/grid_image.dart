import 'package:flame/components.dart';

class GridImageBackground extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    position = Vector2(0, 0);
    sprite = await gameRef.loadSprite("bg_grid.png");
    size = sprite!.originalSize;
    scale = Vector2.all(0.01);
    return super.onLoad();
  }
}
