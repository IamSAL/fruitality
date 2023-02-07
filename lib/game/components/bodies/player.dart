import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:fruitality/game/components/bodies/player_container.dart';
import 'package:fruitality/game/fruitality_game.dart';
import 'package:fruitality/helpers/num_utils.dart';

import '../../../helpers/constants.dart';
import '../../../helpers/direction.dart';
import '../../../helpers/managers/game_manager.dart';

enum PlayerSpriteState { normal, drunk, jumping, speeding, wasted }

class PlayerBody extends BodyComponent<FruitaLityGame> with OpacityProvider {
  PlayerSpriteState playerSpriteState = PlayerSpriteState.normal;
  PlayerSpriteState lastState = PlayerSpriteState.normal;
  DateTime lastSpriteStateUpdateTime = DateTime.now();

  PlayerBody({
    Vector2? position,
    required this.character,
    Vector2? size,
    double? jumpSpeed,
  }) : size = size ?? Constants.INIT_ACTOR_SIZE;
  @override
  double get opacity => 0.5;
  Character character;
  Direction direction = Direction.none;
  late Body groundBody;
  double initialDistance = 0;
  double jumpSpeed = 7000;
  MouseJoint? mouseJoint;
  PlayerContainer playerContainer = PlayerContainer();
  Vector2 position = Constants.WORLD_SIZE / 2;
  late Vector2 size;
  Vector2 targetPosition = Constants.WORLD_SIZE / 2;
  late SpriteComponent sprite;
  @override
  Body createBody() {
    final shape = CircleShape()..radius = size.x;

    final fixtureDef = FixtureDef(
      shape,
      userData: this, // To be able to determine object in collision
      restitution: 0.0,
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
  Future<void> onLoad() async {
    await super.onLoad();
    groundBody = game.world.createBody(BodyDef());
    priority = 2;

    renderBody = false;
    final spriteImg = await gameRef.loadSprite("default_player.png");
    sprite = SpriteComponent(
      sprite: spriteImg,
      size: size * 2.3,
      paint: Paint()..color = Colors.white.withOpacity(1),
      anchor: Anchor.center,
    );
    add(playerContainer);
    playerContainer.lookAt(targetPosition);
    add(sprite);
  }

  @override
  void update(double dt) {
    if (gameRef.gameManager.isIntro || gameRef.gameManager.isGameOver) return;
    super.update(dt);

    if (playerSpriteState == PlayerSpriteState.drunk) {
      if (DateTime.now().difference(lastSpriteStateUpdateTime).inSeconds > 5) {
        setPlayerSpriteState(PlayerSpriteState.normal);
      }
    }

    playerContainer.angle += angleBetweenVectors(targetPosition, body.position);
    if (body.linearVelocity.isZero()) {
      playerContainer.opacity = 0;
    } else {
      playerContainer.opacity = 1;
    }

    double newDistance = sqrt((targetPosition.x - body.position.x) *
            (targetPosition.x - body.position.x) +
        (targetPosition.y - body.position.y) *
            (targetPosition.y - body.position.y));

    if (newDistance < 1 && mouseJoint != null) {
      game.world.destroyJoint(mouseJoint!);
      mouseJoint = null;
    }
  }

  setJumpSpeed(double jumpSpeed) {
    jumpSpeed = jumpSpeed;
  }

  setPlayerSpriteState(PlayerSpriteState state) {
    switch (state) {
      case PlayerSpriteState.normal:
        playerSpriteState = state;
        sprite.paint = Paint()..color = Colors.white.withOpacity(1);
        lastSpriteStateUpdateTime = DateTime.now();
        break;
      case PlayerSpriteState.drunk:
        playerSpriteState = state;
        sprite.paint = Paint()..color = Colors.white.withOpacity(0.5);
        body.linearVelocity /= 2;
        lastSpriteStateUpdateTime = DateTime.now();
        break;
      default:
        playerSpriteState = state;
        lastSpriteStateUpdateTime = DateTime.now();
    }
  }

  void resetPosition() {
    position = Constants.WORLD_SIZE / 2;
  }

  void moveTo(Vector2 position) {
    if (!game.gameManager.isPlaying) return;
    if (mouseJoint != null) {
      game.world.destroyJoint(mouseJoint!);
      mouseJoint = null;
      // body.linearVelocity = body.linearVelocity / 2;

      // double currentAngle = body.angle;
      // double newAngle = currentAngle + pi;
      // body.setTransform(body.position, newAngle);
    }
    final mouseJointDef = MouseJointDef()
      ..maxForce = 10 * body.mass * 0.05
      ..dampingRatio = 0
      ..frequencyHz = 5
      ..target.setFrom(game.player.body.position)
      ..collideConnected = false
      ..bodyA = groundBody
      ..bodyB = body;

    mouseJoint ??= MouseJoint(mouseJointDef);
    game.world.createJoint(mouseJoint!);
    Vector2 furthestPoint = getFurthestPoint(position, body.position);
    //Vector2 furthestPoint = position;
    mouseJoint?.setTarget(furthestPoint);
    targetPosition = furthestPoint;

    initialDistance = sqrt((targetPosition.x - body.position.x) *
            (targetPosition.x - body.position.x) +
        (targetPosition.y - body.position.y) *
            (targetPosition.y - body.position.y));
  }
}
