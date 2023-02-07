// ignore_for_file: prefer_const_constructors

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fruitality/game/components/grid_image.dart';

import 'package:fruitality/game/components/moving_parallax.dart';

import 'package:fruitality/game/components/world_border.dart';
import 'package:fruitality/helpers/direction.dart';
import 'package:fruitality/helpers/managers/actor_manager.dart';

import '../helpers/constants.dart';

import '../helpers/managers/managers.dart';

import '../helpers/num_utils.dart';
import 'components/bodies/player.dart';

class FruitaLityGame extends Forge2DGame
    with
        HasTappables,
        KeyboardEvents,
        MouseMovementDetector,
        MultiTouchDragDetector {
  FruitaLityGame() : super(zoom: kIsWeb ? 100 : 80, gravity: Vector2(0, 0));

  ActorManager actorManager = ActorManager();
  GameManager gameManager = GameManager();
  LevelManager levelManager = LevelManager();
  ObjectManager objectManager = ObjectManager();
  final MovingParallax overlayParallax = MovingParallax();
  late PlayerBody player;
  final LowPassFilter _filterX = LowPassFilter(cutoffFrequency: 10);
  final LowPassFilter _filterY = LowPassFilter(cutoffFrequency: 10);
  Vector2 pointerPosition = Vector2.zero();
  // int screenBufferSpace = 300;

  @override
  Color backgroundColor() {
    return Color.fromARGB(255, 5, 53, 77).withOpacity(0.75);
    //return super.backgroundColor();
  }

  @override
  bool get debugMode => false;

  @override
  void onDragEnd(int pointerId, DragEndInfo info) {
    actorManager.hideJoyPad();
    super.onDragEnd(pointerId, info);
  }

  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo details) {
    super.onDragUpdate(pointerId, details);
    actorManager.moveToPointerDirector(details.eventPosition.game);

    return true;
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    Direction? keyDirection;

    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      actorManager.moveToPointerDirector(
          Vector2(player.position.x - 25, player.position.y));
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      actorManager.moveToPointerDirector(
          Vector2(player.position.x + 25, player.position.y));
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      actorManager.moveToPointerDirector(
          Vector2(player.position.x, player.position.y - 25));
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      actorManager.moveToPointerDirector(
          Vector2(player.position.x, player.position.y + 25));
    }

    if (isKeyDown && keyDirection != null) {
      player.direction = keyDirection;
    } else {
      player.direction = Direction.none;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await add(gameManager);
    overlays.add('startMenuOverlay');
    await add(levelManager);
    add(overlayParallax);
    add(actorManager);
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);
    actorManager.moveToPointerDirector(info.eventPosition.game);
    gameManager.pointerPosition.value = info.eventPosition.global;
  }

  @override
  void onTapUp(int pointerId, TapUpInfo info) {
    actorManager.hideJoyPad();
    super.onTapUp(pointerId, info);
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
      checkLevelUp();
    }
  }

  void onJoypadDirectionChanged(Direction direction) {
    player.direction = direction;
  }

  void zoomOut() {
    double newZoom = camera.zoom - 1;
    if (newZoom > 0.25) {
      camera.zoom = newZoom;
    }
  }

  void zoomIn() {
    camera.zoom += 1;
  }

  void initializeGameStart() {
    setCharacter();

    if (children.contains(objectManager)) objectManager.removeFromParent();
    if (children.contains(gameManager)) gameManager.removeFromParent();
    if (children.contains(levelManager)) levelManager.removeFromParent();
    if (children.contains(actorManager)) actorManager.removeFromParent();
    if (children.contains(player)) player.removeFromParent();

    objectManager = ObjectManager(
        minVerticalDistanceToNextObject: levelManager.minDistance,
        maxVerticalDistanceToNextObject: levelManager.maxDistance);

    gameManager = GameManager();
    levelManager = LevelManager();
    actorManager = ActorManager();

    final GridImageBackground gridImageBackground = GridImageBackground();
    gridImageBackground.removeFromParent();

    add(gridImageBackground);
    add(objectManager);
    add(gameManager);
    add(levelManager);
    add(actorManager);
    add(player);

    player.mounted.whenComplete(() {
      camera.followBodyComponent(player,
          worldBounds: Rect.fromLTRB(
              0, 0, Constants.WORLD_SIZE.x, Constants.WORLD_SIZE.y));
    });

    objectManager.configure(levelManager.level, levelManager.difficulty);

    final paint = BasicPalette.red.paint()..style = PaintingStyle.stroke;
    final circle = CircleComponent(
        radius: 0.25, position: Constants.WORLD_SIZE / 2, paint: paint);
    circle.removeFromParent();

    add(circle);

    add(WorldBorder());
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
