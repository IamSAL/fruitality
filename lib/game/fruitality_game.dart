import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:fruitality/game/components/bodies/fruit.dart';
import 'package:fruitality/game/components/grid_image.dart';
import 'package:fruitality/game/components/grid_parallax.dart';
import 'package:fruitality/game/components/moving_parallax.dart';
import 'package:fruitality/game/components/ui/button_sprite_component.dart';
import 'package:fruitality/helpers/direction.dart';
import 'package:fruitality/screens/game_end_loose.dart';
import 'package:fruitality/screens/game_end_win.dart';
import 'package:fruitality/screens/game_pause.dart';
import 'package:fruitality/game/main_fruitality_page.dart';
import 'package:fruitality/screens/game_start.dart';

import 'components/player.dart';

// // Fixed viewport size
// final screenSize = Vector2(1280, 720);

// // // Scaled viewport size
// final worldSize = Vector2(12.8, 7.2);

class FruitaLityGame extends Forge2DGame with HasTappables {
  late final RouterComponent router;

  final GridParallaxComponent bgGrid = GridParallaxComponent();
  final GridImageBackground gridImageBackground = GridImageBackground();
  final PlayerBody player = PlayerBody();
  final MovingParallax overlayParallax = MovingParallax();
  final totalBodies = TextComponent(scale: Vector2.all(0.5))
    ..positionType = PositionType.viewport;
  FruitaLityGame() : super(zoom: 1, gravity: Vector2(0, 0));

  @override
  bool get debugMode => true;

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
    dynamic currentBg = gridImageBackground;
    totalBodies.position = Vector2(10, size.y - 40);
    // Keep track of the frames per second
    final fps = FpsTextComponent(
        position: Vector2(10, size.y - 20), scale: Vector2.all(0.5))
      ..positionType = PositionType.viewport;
    final paint = BasicPalette.red.paint()..style = PaintingStyle.stroke;
    final circle =
        CircleComponent(radius: 50.0, position: size / 2, paint: paint);
    await loadSprite("default_player.png");
    // player.position = gridImageBackground.size;
    add(circle);
    // add(
    //   router = RouterComponent(
    //     routes: {
    //       'start': OverlayRoute((context, game) => GameStart(game: this)),
    //       'pause': OverlayRoute((context, game) => GamePause()),
    //       'end_win': OverlayRoute((context, game) => GameEndWin()),
    //       'end_loose': OverlayRoute((context, game) => GameEndLoose()),
    //     },
    //     initialRoute: 'start',
    //   ),
    // );
    // double maxSide = min(size.x, size.y);
    // camera.viewport = FixedResolutionViewport(Vector2.all(maxSide));

    add(currentBg);
    //add(_gridImageBackground);
    add(player);
    add(overlayParallax);
    add(fps);
    add(totalBodies);
    add(BrokenFruit());
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

    // add(ButtonSpriteComponent(
    //   label: "Switch BG",
    //   position: Vector2(150, size.y - 20),
    //   onTap: () {
    //     remove(currentBg);
    //     if (currentBg == _bgGrid) {
    //       currentBg = _gridImageBackground;
    //     } else {
    //       currentBg = _bgGrid;
    //     }

    //     add(currentBg);
    //   },
    // ));

    player.mounted.whenComplete(() => camera.followBodyComponent(player,
        worldBounds: Rect.fromLTRB(0, 0, currentBg.size.x, currentBg.size.y)));
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Updated the number of bodies in the world
    totalBodies.text = 'Bodies: ${world.bodies.length}';
  }
}
