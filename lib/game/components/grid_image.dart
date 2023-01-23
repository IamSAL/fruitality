import 'package:flame/components.dart';
import 'package:fruitality/helpers/constants.dart';

class GridImageBackground extends SpriteComponent with HasGameRef {
  final Vector2 positionVector;
  GridImageBackground({required this.positionVector})
      : super(position: positionVector);
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite("bg_grid.png");
    size = sprite!.originalSize;
    scale = Vector2.all(1 / (Constants.SCALE_FACTOR * 5));

    return super.onLoad();
  }
}
