import 'dart:math';

import 'package:flame/components.dart';

import 'package:flame_forge2d/flame_forge2d.dart';

import '../../helpers/direction.dart';

class PlayerBody extends BodyComponent {
  Direction direction = Direction.none;
  final double _playerSpeed = 7000;
  Vector2 position = Vector2(768 / 2, 360 / 2);
  late Vector2 size;

  PlayerBody({
    Vector2? position,
    Vector2? size,
  }) : size = size ?? Vector2(100, 100);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    priority = 2;
    renderBody = false;
    final sprite = Sprite(gameRef.images.fromCache("default_player.png"));
    add(
      SpriteComponent(
        sprite: sprite,
        size: size,
        anchor: Anchor.center,
      ),
    );

    //add(PlayerSpriteComponent());
  }

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 0;

    final fixtureDef = FixtureDef(
      shape,
      userData: this, // To be able to determine object in collision
      restitution: 0,
      density: 0,
      friction: 0,
    );

    final bodyDef = BodyDef(
      position: position,
      angle: (position.x + position.y) / 2 * pi,
      type: BodyType.dynamic,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  void moveUp(double delta) {
    body.linearVelocity = Vector2(0, -(delta)) * _playerSpeed;
  }

  void moveDown(double delta) {
    body.linearVelocity = Vector2(0, delta) * _playerSpeed;
  }

  void moveLeft(double delta) {
    //body.applyLinearImpulse(Vector2(-(delta ), 0));
    body.linearVelocity = Vector2(-(delta), 0) * _playerSpeed;
  }

  void moveRight(double delta) {
    //body.applyForce(Vector2(delta , 0));
    body.linearVelocity = Vector2(delta, 0) * _playerSpeed;
  }

  void movePlayer(double delta) {
    if (direction != Direction.none) {
      print("delta $delta");
      print("direction $direction");
    }
    switch (direction) {
      case Direction.up:
        moveUp(delta);

        break;
      case Direction.down:
        moveDown(delta);
        break;
      case Direction.left:
        moveLeft(delta);
        break;
      case Direction.right:
        moveRight(delta);
        break;
      case Direction.none:
        break;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    movePlayer(dt);
  }
}
