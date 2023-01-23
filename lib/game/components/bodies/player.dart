import 'dart:math';

import 'package:flame/components.dart';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:fruitality/game/components/bodies/player_container.dart';
import 'package:fruitality/game/fruitality_game.dart';
import 'package:fruitality/helpers/num_utils.dart';

import '../../../helpers/constants.dart';
import '../../../helpers/direction.dart';
import '../../../helpers/managers/game_manager.dart';

class PlayerBody extends BodyComponent<FruitaLityGame> {
  PlayerBody({
    Vector2? position,
    required this.character,
    Vector2? size,
    double? jumpSpeed,
  }) : size = size ?? Vector2(1, 1);

  Character character;
  Direction direction = Direction.none;
  late Body groundBody;
  double jumpSpeed = 7000;
  MouseJoint? mouseJoint;
  PlayerContainer playerContainer = PlayerContainer();
  Vector2 position = Constants.WORLD_SIZE / 2;
  late Vector2 size;
  Vector2 targetPosition = Constants.WORLD_SIZE / 2;

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 1 / 2.35;

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

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    groundBody = game.world.createBody(BodyDef());
    priority = 2;
    renderBody = false;
    final sprite = await gameRef.loadSprite("default_player.png");
    add(playerContainer);
    playerContainer.lookAt(targetPosition);
    add(
      SpriteComponent(
        sprite: sprite,
        size: size,
        anchor: Anchor.center,
      ),
    );
  }

  @override
  void update(double dt) {
    if (gameRef.gameManager.isIntro || gameRef.gameManager.isGameOver) return;
    super.update(dt);
    playerContainer.angle += angleBetweenVectors(targetPosition, body.position);
    if (body.linearVelocity.isZero()) {
      playerContainer.opacity = 0;
    } else {
      playerContainer.opacity = 1;
    }
  }

  setJumpSpeed(double jumpSpeed) {
    jumpSpeed = jumpSpeed;
  }

  void resetPosition() {
    position = Constants.WORLD_SIZE / 2;
  }

  void moveTo(Vector2 position) {
    if (!game.gameManager.isPlaying) return;

    final mouseJointDef = MouseJointDef()
      ..maxForce = (game.player.body.mass + 1) * 2
      ..dampingRatio = 0.01
      ..frequencyHz = 0.01
      ..target.setFrom(game.player.body.position)
      ..collideConnected = false
      ..bodyA = groundBody
      ..bodyB = body;

    mouseJoint ??= MouseJoint(mouseJointDef);
    game.world.createJoint(mouseJoint!);
    targetPosition = position;

    mouseJoint?.setTarget(position);
  }
}
