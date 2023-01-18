import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:fruitality/game/components/bodies/fruit.dart';
import 'package:fruitality/game/components/grid_image.dart';
import 'package:fruitality/game/components/grid_parallax.dart';
import 'package:fruitality/game/components/moving_parallax.dart';
import 'package:fruitality/game/components/ui/button_sprite_component.dart';
import 'package:fruitality/game/components/world_border.dart';
import 'package:fruitality/helpers/direction.dart';

import '../helpers/constants.dart';

import '../helpers/managers/managers.dart';
import 'components/bodies/player.dart';

// // Fixed viewport size
// final screenSize = Vector2(1280, 720);

// // // Scaled viewport size
// final worldSize = Vector2(12.8, 7.2);

class FruitaLityGame extends Forge2DGame with HasTappables {
  late PlayerBody player;
  late TextComponent totalBodies;
  final MovingParallax overlayParallax = MovingParallax();
  final LevelManager levelManager = LevelManager();
  final GameManager gameManager = GameManager();
  int screenBufferSpace = 300;
  ObjectManager objectManager = ObjectManager();

  FruitaLityGame() : super(zoom: 1, gravity: Vector2(0, 0));

  @override
  bool get debugMode => false;

  void onJoypadDirectionChanged(Direction direction) {
    player.direction = direction;
  }

  @override
  Color backgroundColor() {
    return Color.fromARGB(255, 5, 53, 77).withOpacity(0.75);
    //return super.backgroundColor();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await add(gameManager);
    overlays.add('startMenuOverlay');
    await add(levelManager);
    add(overlayParallax);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gameManager.isGameOver) {
      return;
    }

    if (gameManager.isIntro) {
      overlays.add('startMenuOverlay');
      return;
    }

    if (gameManager.isPlaying) {
      totalBodies.text = 'Bodies: ${world.bodies.length}';
      checkLevelUp();
    }
  }

  void initializeGameStart() {
    setCharacter();

    gameManager.reset();

    if (children.contains(objectManager)) objectManager.removeFromParent();
    if (children.contains(player)) player.removeFromParent();

    add(player);
    player.mounted.whenComplete(() => camera.followBodyComponent(player,
        worldBounds: Rect.fromLTRB(
            0, 0, Constants.WORLD_SIZE.x, Constants.WORLD_SIZE.y)));
    levelManager.reset();

    objectManager = ObjectManager(
        minVerticalDistanceToNextObject: levelManager.minDistance,
        maxVerticalDistanceToNextObject: levelManager.maxDistance);

    add(objectManager);

    objectManager.configure(levelManager.level, levelManager.difficulty);
    totalBodies = TextComponent(scale: Vector2.all(0.5))
      ..positionType = PositionType.viewport;
    totalBodies.position = Vector2(10, size.y - 40);
    final fps = FpsTextComponent(
        position: Vector2(10, size.y - 20), scale: Vector2.all(0.5))
      ..positionType = PositionType.viewport;
    final paint = BasicPalette.red.paint()..style = PaintingStyle.stroke;
    final circle = CircleComponent(
        radius: 50.0, position: Constants.WORLD_SIZE / 2, paint: paint);
    circle.removeFromParent();
    final GridImageBackground gridImageBackground = GridImageBackground();
    gridImageBackground.removeFromParent();
    fps.removeFromParent();
    totalBodies.removeFromParent();
    // player.position = gridImageBackground.size;
    add(circle);

    add(gridImageBackground);

    add(fps);
    add(totalBodies);
    add(NormalFruit(position: Constants.WORLD_SIZE / 2));
    add(ButtonSpriteComponent(
      label: "Zoom Out",
      position: Vector2(300, size.y - 20),
      onTap: () {
        double newZoom = camera.zoom - 0.1;
        if (newZoom > 0.25) {
          camera.zoom = newZoom;
        }
      },
    ));
    add(ButtonSpriteComponent(
      label: "Zoom In",
      position: Vector2(150, size.y - 20),
      onTap: () {
        camera.zoom += 0.1;
      },
    ));

    add(ButtonSpriteComponent(
      label: "Reset",
      position: Vector2(size.x - 400, 30),
      onTap: () {
        resetGame();
      },
    ));

    add(ButtonSpriteComponent(
      label: "Play/Pause",
      position: Vector2(size.x - 100, 30),
      onTap: () {
        togglePauseState();
      },
    ));

    add(ButtonSpriteComponent(
      label: "Stop player",
      position: Vector2(530, size.y - 20),
      onTap: () {
        player.body.linearVelocity = Vector2.all(0);
      },
    ));

    add(ButtonSpriteComponent(
      label: "Boost player",
      position: Vector2(680, size.y - 20),
      onTap: () {
        player.body.applyLinearImpulse(Vector2.all(550));
      },
    ));

    add(WorldBorder());
    camera.zoom = 0.7;
  }

  void setCharacter() {
    player = PlayerBody(
      character: gameManager.character,
      jumpSpeed: levelManager.startingJumpSpeed,
    );
  }

  void startGame() {
    initializeGameStart();
    gameManager.state = GameState.playing;
    overlays.remove('startMenuOverlay');
  }

  void resetGame() {
    print("total children : ${children.length}");
    removeAll(children);
    overlays.add('startMenuOverlay');
  }

  void onLose() {
    gameManager.state = GameState.gameOver;
    removeAll([]);
    overlays.add('gameOverOverlay');
  }

  void togglePauseState() {
    if (paused) {
      overlays.remove('pauseMenuOverlay');
      resumeEngine();
    } else {
      overlays.add('pauseMenuOverlay');
      pauseEngine();
    }
  }

  void checkLevelUp() {
    if (levelManager.shouldLevelUp(gameManager.score.value)) {
      levelManager.increaseLevel();

      objectManager.configure(levelManager.level, levelManager.difficulty);

      player.setJumpSpeed(levelManager.jumpSpeed);
    }
  }
}
