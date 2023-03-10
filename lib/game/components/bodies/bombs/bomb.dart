import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:fruitality/helpers/constants.dart';

import '../../../fruitality_game.dart';
import '../player.dart';

abstract class Bomb<T> extends BodyComponent<FruitaLityGame>
    with ContactCallbacks {
  Vector2 position;
  T currentState;

  Bomb({required this.position, required this.currentState});

  @override
  Body createBody() {
    final shape = CircleShape()..radius = Constants.INIT_OBJECT_SIZE.x;

    final fixtureDef = FixtureDef(
      shape,
      userData: this, // To be able to determine object in collision
      restitution: 0.01,
      density: 5,
      friction: .25,
    );

    final bodyDef = BodyDef(
      position: position,
      type: BodyType.dynamic,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  onPlayerContactBegin(PlayerBody playerBody);

  @override
  void beginContact(Object other, Contact contact) {
    if (other is PlayerBody) {
      onPlayerContactBegin(other);
      gameRef.objectManager.objectsMarkedForRemoval.add(other);
      gameRef.objectManager.objectsMarkedForRemoval.add(this);
    }

    if (other is Bomb) {
      gameRef.objectManager.objectsMarkedForRemoval.add(other);
      gameRef.objectManager.objectsMarkedForRemoval.add(this);
    }
  }
}
