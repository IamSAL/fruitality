
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
  late Body groundBody;
  MouseJoint? mouseJoint;
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
    groundBody = game.world.createBody(BodyDef());
    priority = 2;
    renderBody = false;
    final sprite = await gameRef.loadSprite("default_player.png");
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
    final shape = CircleShape()..radius = 100 / 2.35;

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

  void moveTo(Vector2 position) {
    if (!game.gameManager.isPlaying) return;

    final mouseJointDef = MouseJointDef()
      ..maxForce = 10000 * (game.player.body.mass + 1) * 10
      ..dampingRatio = 0.1
      ..frequencyHz = 5
      ..target.setFrom(game.player.body.position)
      ..collideConnected = false
      ..bodyA = groundBody
      ..bodyB = body;

    mouseJoint ??= MouseJoint(mouseJointDef);
    game.world.createJoint(mouseJoint!);

    mouseJoint?.setTarget(position);
    print("moved player to");
    print(position);
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
    if (direction != Direction.none) {}
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
