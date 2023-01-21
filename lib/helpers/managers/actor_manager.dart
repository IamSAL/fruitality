// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:fruitality/game/fruitality_game.dart';

enum activeActors { player, power, bot }

class ActorManager extends Component with HasGameRef<FruitaLityGame> {
  ActorManager();
  late Body groundBody;
  MouseJoint? mouseJoint;
  void moveToPointerDirector(EventPosition eventPosition) {
    if (!game.gameManager.isPlaying) return;
    final mouseJointDef = MouseJointDef()
      ..maxForce = 10000 * (game.player.body.mass + 1) * 10
      ..dampingRatio = 0.1
      ..frequencyHz = 5
      ..target.setFrom(game.player.body.position)
      ..collideConnected = false
      ..bodyA = groundBody
      ..bodyB = game.player.body;

    mouseJoint ??= MouseJoint(mouseJointDef);
    game.world.createJoint(mouseJoint!);

    mouseJoint?.setTarget(eventPosition.game);
  }

  @override
  void onLoad() {
    groundBody = game.world.createBody(BodyDef());
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
