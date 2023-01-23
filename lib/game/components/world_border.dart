import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:fruitality/helpers/constants.dart';

class WorldBorder extends BodyComponent {
  late Vector2 size;

  WorldBorder({
    Vector2? size,
  }) : size = size ?? Constants.WORLD_SIZE;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    priority = 2;
    renderBody = false;

    //add(PlayerSpriteComponent());
  }

  @override
  Body createBody() {
    final shape = ChainShape();
    shape.createChain([
      Vector2(0, 0),
      Vector2(0, Constants.WORLD_SIZE.y),
      Vector2(Constants.WORLD_SIZE.x, Constants.WORLD_SIZE.y),
      Vector2(Constants.WORLD_SIZE.x, 0),
      Vector2(0, 0),
    ]);

    final fixtureDef = FixtureDef(
      shape,
      userData: this, // To be able to determine object in collision
      restitution: 0,
      density: 0,
      friction: 0,
    );

    final bodyDef = BodyDef(
      position: Vector2(0, 0),
      type: BodyType.static,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
