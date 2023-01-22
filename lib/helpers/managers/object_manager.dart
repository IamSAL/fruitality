// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:fruitality/game/components/bodies/bombs/bomb.dart';
import 'package:fruitality/game/components/bodies/bombs/green_bomb.dart';
import 'package:fruitality/game/components/bodies/fruits/common_fruit.dart';
import 'package:fruitality/game/components/bodies/fruits/fruit.dart';
import 'package:fruitality/game/components/bodies/fruits/poison_fruit.dart';
import 'package:fruitality/game/components/bodies/fruits/special_fruit.dart';
import 'package:fruitality/game/fruitality_game.dart';
import 'package:fruitality/helpers/constants.dart';

import '../../game/components/powerup.dart';
import '../num_utils.dart';
import './managers.dart';

final Random _rand = Random();

class ObjectManager extends Component with HasGameRef<FruitaLityGame> {
  ObjectManager(
      {this.minVerticalDistanceToNextObject = 150,
      this.maxVerticalDistanceToNextObject = 1000,
      super.priority = 1});

  double maxVerticalDistanceToNextObject;
  double minVerticalDistanceToNextObject;
  Set<BodyComponent> objectsMarkedForRemoval = {};
  final probGen = ProbabilityGenerator();
  final Map<String, bool> specialItems = {
    'special_fruit': true, // level 1
    'rocket': false, // level 4
    'enemy': false, // level 5
  };

  final List<Bomb> _bombs = [];
  final List<PowerUp> _boosters = [];
  final List<Fruit> _commonFruits = [];

  @override
  void onMount() {
    super.onMount();

    //add some random fruits
    _commonFruits.addAll(List.generate(250, (index) {
      Fruit fruit =
          _semiRandomFruit(Vector2(_generateNextX(), _generateNextY()));
      add(fruit);
      return fruit;
    }));

    //add some bombs
    _bombs.addAll(List.generate(75, (index) {
      Bomb<PoisonBombState> bomb = PoisonBomb(
        position: Vector2(_generateNextX(), _generateNextY()),
      );
      add(bomb);
      return bomb;
    }));
  }

  @override
  void update(double dt) {
    if (!gameRef.world.isLocked) {
      removeObjectsMarkedForRemoval();
    }
    //max 5 items per second & max 500 items alive at once;
    if (probGen.generateWithProbability(10) && _commonFruits.length < 1000) {
      var newPlatY = _generateNextY();
      var newPlatX = _generateNextX();
      final nextPlat = _semiRandomFruit(Vector2(newPlatX, newPlatY));

      add(nextPlat);
      _commonFruits.add(nextPlat);
      _maybeRemoveFruits();
      _maybeAddBombs();
      // _maybeAddBoosters();
    }
    if (_commonFruits.length > 250) {
      _maybeRemoveFruits();
      _maybeAddBombs();
    }

    super.update(dt);
  }

  void enableSpecialty(String specialty) {
    specialItems[specialty] = true;
  }

  void enableLevelSpecialty(int level) {
    switch (level) {
      case 1:
        enableSpecialty('spring');
        break;
      case 2:
        enableSpecialty('broken');
        break;
      case 3:
        enableSpecialty('noogler');
        break;
      case 4:
        enableSpecialty('rocket');
        break;
      case 5:
        enableSpecialty('enemy');
        break;
    }
  }

  void resetSpecialties() {
    for (var key in specialItems.keys) {
      specialItems[key] = false;
    }
  }

  void configure(int nextLevel, Difficulty config) {
    minVerticalDistanceToNextObject = gameRef.levelManager.minDistance;
    maxVerticalDistanceToNextObject = gameRef.levelManager.maxDistance;

    for (int i = 1; i <= nextLevel; i++) {
      enableLevelSpecialty(i);
    }
  }

  void removeObjectsMarkedForRemoval() {
    if (objectsMarkedForRemoval.isNotEmpty) {
      objectsMarkedForRemoval.toList().forEach((BodyComponent object) {
        gameRef.world.destroyBody(object.body);
        object.removeFromParent();
        objectsMarkedForRemoval.remove(object);
      });
    }
  }

  void _maybeRemoveFruits() {
    if (probGen.generateWithProbability(50) && _commonFruits.isNotEmpty) {
      final oldestFruit = _commonFruits.removeAt(0);
      oldestFruit.removeFromParent();
    }
  }

  double _generateNextX() {
    return _rand.nextInt(Constants.WORLD_SIZE.x.toInt()).toDouble();
    //TODO:avoid player's position;
  }

  double _generateNextY() {
    return _rand.nextInt(Constants.WORLD_SIZE.y.toInt()).toDouble();
    //TODO:avoid player's position;
  }

  Fruit _semiRandomFruit(Vector2 position) {
    if (specialItems['special_fruit'] == true &&
        probGen.generateWithProbability(15)) {
      return SpecialFruit(position: position);
    }

    if (specialItems['special_fruit'] == true &&
        probGen.generateWithProbability(5)) {
      return PoisonFruit(position: position);
    }

    return CommonFruit(position: position);
  }

  void _maybeAddBombs() {
    if (specialItems['enemy'] != true) {
      return;
    }
    if (probGen.generateWithProbability(50)) {
      var bomb = PoisonBomb(
        position: Vector2(_generateNextX(), _generateNextY()),
      );
      add(bomb);
      _bombs.add(bomb);
      _maybeRemoveBombs();
    }
  }

  void _maybeRemoveBombs() {
    if (probGen.generateWithProbability(95) && _bombs.isNotEmpty) {
      final oldestBomb = _bombs.removeAt(0);
      oldestBomb.removeFromParent();
    }
  }

  void _maybeAddBoosters() {
    if (specialItems['noogler'] == true &&
        probGen.generateWithProbability(20)) {
      var nooglerHat = NooglerHat(
        position: Vector2(_generateNextX(), _generateNextY()),
      );
      add(nooglerHat);
      _boosters.add(nooglerHat);
    } else if (specialItems['rocket'] == true &&
        probGen.generateWithProbability(15)) {
      var rocket = Rocket(
        position: Vector2(_generateNextX(), _generateNextY()),
      );
      add(rocket);
      _boosters.add(rocket);
    }

    _cleanupPowerups();
  }

  void _cleanupPowerups() {
    // final screenBottom = gameRef.player.position.y +
    //     (gameRef.size.x / 2) +
    //     gameRef.screenBufferSpace;
    // while (_powerups.isNotEmpty && _powerups.first.position.y > screenBottom) {
    //   if (_powerups.first.parent != null) {
    //     remove(_powerups.first);
    //   }
    //   _powerups.removeAt(0);
    // }
  }
}
