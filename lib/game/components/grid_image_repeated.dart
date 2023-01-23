import 'package:flame/components.dart';
import 'package:fruitality/game/components/bodies/fruits/common_fruit.dart';
import 'package:fruitality/game/components/grid_image.dart';
import 'package:fruitality/helpers/constants.dart';

class GridImageRepeated extends Component with HasGameRef {
  @override
  Future<void>? onLoad() async {
    int row = 0;
    double newPositionY = 0;
    while (row < Constants.SCALE_FACTOR) {
      int column = 0;
      double newPositionX = 0;
      while (column < Constants.SCALE_FACTOR) {
        GridImageBackground _firstBg = GridImageBackground(
            positionVector: Vector2(newPositionX, newPositionY));
        add(_firstBg);
        newPositionX += Constants.WORLD_SIZE.x / Constants.SCALE_FACTOR;

        column++;
      }
      newPositionY += Constants.WORLD_SIZE.y / Constants.SCALE_FACTOR;
      row++;
    }
    return super.onLoad();
  }
}
