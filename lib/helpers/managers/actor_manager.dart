// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:fruitality/game/fruitality_game.dart';
import 'package:fruitality/helpers/constants.dart';

enum activeActors { player, power, bot }

class ActorManager extends Component with HasGameRef<FruitaLityGame> {
  ActorManager();

  final fps = FpsTextComponent(scale: Vector2.all(0.5))..positionType = PositionType.viewport;

  final totalBodies = TextComponent(scale: Vector2.all(0.5))..positionType = PositionType.viewport;

  void moveToPointerDirector(Vector2 pointerPosition) {
    game.player.moveTo(pointerPosition);
  }

  void hideJoyPad() {
    game.gameManager.pointerPosition.value = Constants.JOYPAD_POSITION;
  }

  @override
  void onLoad() {
    super.onLoad();
    fps.position = Vector2(12, game.camera.canvasSize.y - 35);
    totalBodies.position = Vector2(12, game.camera.canvasSize.y - 50);
    if (game.children.contains(fps)) fps.removeFromParent();
    if (game.children.contains(totalBodies)) totalBodies.removeFromParent();
    //HUDs must be direct child of game.
    game.add(fps);
    game.add(totalBodies);
  }

  @override
  void update(double dt) {
    super.update(dt);
    totalBodies.text = 'Bodies: ${game.world.bodies.length}';
  }
}
