// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:fruitality/game/fruitality_game.dart';

/// The supertype for all Fruits, including Enemies
/// This class adds a hitbox and Collision Callbacks to all subtypes,
/// It also allows the Fruit to move, if it wants to. All Fruits
/// know how to move, and have a 20% chance of being a moving Fruit
///
/// [T] should be an enum that is used to Switch between spirtes, if necessary
/// Many Fruits only need one Sprite, so [T] will be an enum that looks
/// something like: `enum { only }`

abstract class Fruit<T> extends SpriteGroupComponent<T>
    with HasGameRef<FruitaLityGame> {
  bool isMoving = false;
  double direction = 1;
  final Vector2 _velocity = Vector2.zero();
  double speed = 35;

  Fruit({
    super.position,
  }) : super(
          size: Vector2.all(100),
          priority: 2,
        );

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    final int rand = Random().nextInt(100);
    if (rand > 80) isMoving = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}

enum NormalFruitState { only }

class NormalFruit extends Fruit<NormalFruitState> {
  NormalFruit({super.position});

  final Map<String, Vector2> spriteOptions = {
    'Fruit_monitor': Vector2(115, 84),
    'Fruit_phone_center': Vector2(100, 55),
    'Fruit_terminal': Vector2(110, 83),
    'Fruit_laptop': Vector2(100, 63),
  };

  @override
  Future<void>? onLoad() async {
    var randSpriteIndex = Random().nextInt(spriteOptions.length);

    String randSprite = spriteOptions.keys.elementAt(randSpriteIndex);

    sprites = {
      NormalFruitState.only: await gameRef.loadSprite('game/$randSprite.png')
    };

    current = NormalFruitState.only;

    size = spriteOptions[randSprite]!;
    await super.onLoad();
  }
}

enum BrokenFruitState { cracked, broken }

class BrokenFruit extends Fruit<BrokenFruitState> {
  BrokenFruit({super.position});

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    sprites = <BrokenFruitState, Sprite>{
      BrokenFruitState.cracked:
          await gameRef.loadSprite('game/platform_cracked_monitor.png'),
      BrokenFruitState.broken:
          await gameRef.loadSprite('game/platform_monitor_broken.png'),
    };

    current = BrokenFruitState.cracked;
    size = Vector2(115, 84);
  }

  void breakFruit() {
    current = BrokenFruitState.broken;
  }
}

enum SpringState { down, up }

class SpringBoard extends Fruit<SpringState> {
  SpringBoard({
    super.position,
  });

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    sprites = <SpringState, Sprite>{
      SpringState.down:
          await gameRef.loadSprite('game/platform_trampoline_down.png'),
      SpringState.up:
          await gameRef.loadSprite('game/platform_trampoline_up.png'),
    };

    current = SpringState.up;

    size = Vector2(100, 45);
  }
}

enum EnemyFruitState { only }

class EnemyFruit extends Fruit<EnemyFruitState> {
  EnemyFruit({super.position});

  @override
  Future<void>? onLoad() async {
    var randBool = Random().nextBool();
    var enemySprite = randBool ? 'enemy_trash_can' : 'enemy_error';

    sprites = <EnemyFruitState, Sprite>{
      EnemyFruitState.only: await gameRef.loadSprite('game/$enemySprite.png'),
    };

    current = EnemyFruitState.only;

    return super.onLoad();
  }
}
