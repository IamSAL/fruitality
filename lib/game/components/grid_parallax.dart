import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class GridParallaxComponent extends ParallaxComponent {
  static final backgroundVelocity = Vector2(30.0, 0);
  static const framesPerSec = 60.0;
  static const threshold = 0.005;
  double defaultScale = 1;
  Vector2 lastCameraPosition = Vector2(0, 10);
  @override
  Future<void> onLoad() async {
    position = Vector2(0, 0);
    size = Vector2.all(7500);
    scale = Vector2.all(defaultScale);
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('square.png'),
      ],
      repeat: ImageRepeat.repeat,
      fill: LayerFill.none,
    );
    positionType = PositionType.viewport;
    super.onLoad();
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);
    final cameraPosition = gameRef.camera.position;
    final delta = dt > threshold ? 1.0 / (dt * framesPerSec) : 1.0;
    final baseVelocity = cameraPosition
      ..sub(lastCameraPosition)
      ..multiply(backgroundVelocity)
      ..multiply(Vector2(delta, delta));
    parallax!.baseVelocity.setFrom(baseVelocity);
    lastCameraPosition.setFrom(gameRef.camera.position);
    scale = Vector2.all(defaultScale * (gameRef.camera.zoom));
  }
}
