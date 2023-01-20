// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruitality/game/components/bodies/bombs/green_bomb.dart';
import 'package:fruitality/game/components/bodies/fruits/common_fruit.dart';

import 'package:fruitality/game/components/grid_image.dart';

import 'package:fruitality/game/components/moving_parallax.dart';

import 'package:fruitality/game/components/world_border.dart';
import 'package:fruitality/helpers/direction.dart';

import '../helpers/constants.dart';

import '../helpers/managers/managers.dart';

import 'components/bodies/player.dart';

class FruitaLityGame extends Forge2DGame with HasTappables, KeyboardEvents {
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

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);
    print(info);
  }

  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    Direction? keyDirection = null;

    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      keyDirection = Direction.left;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      keyDirection = Direction.right;
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      keyDirection = Direction.up;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      keyDirection = Direction.down;
    }

    if (isKeyDown && keyDirection != null) {
      player.direction = keyDirection;
    } else {
      player.direction = Direction.none;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  void zoomOut() {
    double newZoom = camera.zoom - 0.1;
    if (newZoom > 0.25) {
      camera.zoom = newZoom;
    }
  }

  void zoomIn() {
    camera.zoom += 0.1;
  }

  void initializeGameStart() {
    setCharacter();

    gameManager.reset();

    if (children.contains(objectManager)) objectManager.removeFromParent();
    if (children.contains(player)) player.removeFromParent();

    add(player);
    player.mounted.whenComplete(() {
      camera.followBodyComponent(player,
          worldBounds: Rect.fromLTRB(0, 0, Constants.WORLD_SIZE.x, Constants.WORLD_SIZE.y));
      player.body.applyLinearImpulse(Vector2.all(550));
    });
    levelManager.reset();

    objectManager = ObjectManager(
        minVerticalDistanceToNextObject: levelManager.minDistance,
        maxVerticalDistanceToNextObject: levelManager.maxDistance);

    add(objectManager);

    objectManager.configure(levelManager.level, levelManager.difficulty);
    totalBodies = TextComponent(scale: Vector2.all(0.5))..positionType = PositionType.viewport;
    totalBodies.position = Vector2(12, size.y - 50);
    final fps = FpsTextComponent(position: Vector2(12, size.y - 35), scale: Vector2.all(0.5))
      ..positionType = PositionType.viewport;
    final paint = BasicPalette.red.paint()..style = PaintingStyle.stroke;
    final circle = CircleComponent(radius: 50.0, position: Constants.WORLD_SIZE / 2, paint: paint);
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
    overlays.add('inGameOverlay');
    overlays.remove('startMenuOverlay');
  }

  void resetGame() {
    removeAll(children);
    overlays.remove('inGameOverlay');
    overlays.add('startMenuOverlay');
  }

  void onLose() {
    gameManager.state = GameState.gameOver;
    gameManager.result = GameResult.loose;
    overlays.remove('inGameOverlay');
    overlays.add('gameOverOverlay');
  }

  void onWin() {
    gameManager.state = GameState.gameOver;
    gameManager.result = GameResult.win;
    overlays.remove('inGameOverlay');
    overlays.add('gameOverOverlay');
  }

  void togglePauseState() {
    if (paused) {
      overlays.remove('pauseMenuOverlay');
      overlays.add('inGameOverlay');
      resumeEngine();
    } else {
      overlays.add('pauseMenuOverlay');
      overlays.remove('inGameOverlay');
      pauseEngine();
    }
  }

  void checkLevelUp() {
    if (levelManager.shouldLevelUp(gameManager.fruits.value)) {
      levelManager.increaseLevel();

      objectManager.configure(levelManager.level, levelManager.difficulty);

      player.setJumpSpeed(levelManager.jumpSpeed);
    }
  }
}
