import 'package:flame/components.dart';
import 'package:fruitality/helpers/has_opacity_mixin.dart';

class GridImageBackground extends SpriteComponent
    with HasGameRef, HasOpacityProvider {
  @override
  // TODO: implement opacity
  double get opacity => 0.75;
  @override
  Future<void>? onLoad() async {
    position = Vector2(0, 0);
    sprite = await gameRef.loadSprite("bg_grid.png");
    size = sprite!.originalSize;
    scale = Vector2.all(0.01);
    return super.onLoad();
  }
}
