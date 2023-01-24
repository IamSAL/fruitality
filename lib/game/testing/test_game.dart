import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:fruitality/game/components/bodies/player_test.dart';
import 'package:fruitality/game/components/grid_image.dart';

import '../../helpers/constants.dart';

// Fixed viewport size
final screenSize = Vector2(1280, 720);

// Scaled viewport size
final worldSize = Vector2(12.8, 7.2);

class TestGame extends Forge2DGame with KeyboardEvents, HasTappables, MouseMovementDetector {
  // Keep track of the number of bodies in the world.
  final totalBodies = TextComponent(position: Vector2(5, 690))..positionType = PositionType.viewport;

  // Keep track of the frames per second
  final fps = FpsTextComponent();
  late PlayerBodyTest player;
  // Scale the screenSize by 100 and set the gravity of 15
  TestGame() : super(zoom: 100, gravity: Vector2(0, 0));
  @override
  // TODO: implement debugMode
  bool get debugMode => false;
  @override
  Future<void> onLoad() async {
    // Set the FixedResolutionViewport
    // camera.viewport = FixedResolutionViewport(screenSize);
    await loadSprite("default_player.png");
    // Adds a black background to the viewport
    // add(_Background(size: screenSize)..positionType = PositionType.viewport);
    add(GridImageBackground());
    add(fps);
    fps.position = Vector2(5, size.y);
    add(totalBodies);

    add(Floor());
    add(Box());
    add(Box());
    player = PlayerBodyTest(size: Vector2(0.25, 0.25), position: Vector2(10, 5));
    add(player);

    player.mounted.whenComplete(() {
      camera.followBodyComponent(player,
          worldBounds: Rect.fromLTRB(0, 0, Constants.WORLD_SIZE.x, Constants.WORLD_SIZE.y));
    });
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Updated the number of bodies in the world
    totalBodies.text = 'Bodies: ${world.bodies.length}';
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);
    player.moveTo(info.eventPosition.game);
    //print("move called");
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    player.moveTo(info.eventPosition.game);
    super.onMouseMove(info);
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 5, 53, 77).withOpacity(0.75);
    //return super.backgroundColor();
  }
}

class Box extends BodyComponent {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: Vector2(10, 0),
      type: BodyType.dynamic,
    );

    final shape = PolygonShape()..setAsBoxXY(.25, .25);
    final fixtureDef = FixtureDef(shape)
      ..density = 5
      ..friction = .25
      ..restitution = .1;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class Floor extends BodyComponent {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: Vector2(0, worldSize.y - .75),
      type: BodyType.static,
    );

    final shape = EdgeShape()..set(Vector2.zero(), Vector2(worldSize.x, 0));

    final fixtureDef = FixtureDef(shape)..friction = .1;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

final Paint blackPaint = BasicPalette.black.paint();

// Helper component that paints a black background
class _Background extends PositionComponent {
  _Background();

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), blackPaint);
  }
}
