import 'dart:math';

import 'package:flame/components.dart';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:fruitality/game/fruitality_game.dart';

import '../../../helpers/constants.dart';
import '../../../helpers/direction.dart';
import '../../../helpers/managers/game_manager.dart';

class PlayerBody extends BodyComponent<FruitaLityGame> {
  Direction direction = Direction.none;
  double jumpSpeed = 7000;
  Vector2 position = Constants.WORLD_SIZE / 2;
  late Vector2 size;
  Character character;

  PlayerBody({
    Vector2? position,
    required this.character,
    Vector2? size,
    double? jumpSpeed,
  }) : size = size ?? Vector2(100, 100);

  setJumpSpeed(double jumpSpeed) {
    jumpSpeed = jumpSpeed;
  }

  void resetPosition() {
    position = Constants.WORLD_SIZE / 2;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // await loadSprite("default_player.png");
    priority = 2;
    renderBody = false;
    final sprite = await gameRef.loadSprite("default_player.png");
    add(
      SpriteComponent(
        sprite: sprite,
        size: size,
        anchor: Anchor.center,
        priority: 1,
      ),
    );

    //add(PlayerSpriteComponent());
  }

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 100;

    final fixtureDef = FixtureDef(
      shape,
      userData: this, // To be able to determine object in collision
      restitution: 0,
      density: 0,
      friction: 0,
    );

    final bodyDef = BodyDef(
      position: position,
      type: BodyType.dynamic,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  void moveUp(double delta) {
    body.linearVelocity = Vector2(0, -(delta)) * jumpSpeed;
  }

  void moveDown(double delta) {
    body.linearVelocity = Vector2(0, delta) * jumpSpeed;
  }

  void moveLeft(double delta) {
    //body.applyLinearImpulse(Vector2(-(delta ), 0));
    body.linearVelocity = Vector2(-(delta), 0) * jumpSpeed;
  }

  void moveRight(double delta) {
    //body.applyForce(Vector2(delta , 0));
    body.linearVelocity = Vector2(delta, 0) * jumpSpeed;
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
    if (gameRef.gameManager.isIntro || gameRef.gameManager.isGameOver) return;
    super.update(dt);

    movePlayer(dt);
  }
}
