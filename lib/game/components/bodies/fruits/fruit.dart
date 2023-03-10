import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:fruitality/helpers/constants.dart';

import '../../../fruitality_game.dart';

class Fruit<T> extends BodyComponent<FruitaLityGame> with ContactCallbacks {
  Vector2 position;
  T currentState;

  Fruit({required this.position, required this.currentState});

  @override
  Body createBody() {
    final shape = CircleShape()..radius = Constants.INIT_OBJECT_SIZE.x;

    final fixtureDef = FixtureDef(
      shape,
      userData: this, // To be able to determine object in collision
      restitution: 0,
      density: 5,
      friction: 0,
    );

    final bodyDef = BodyDef(
      position: position,
      type: BodyType.dynamic,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
