// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flame/components.dart';
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
  ObjectManager({
    this.minVerticalDistanceToNextObject = 150,
    this.maxVerticalDistanceToNextObject = 1000,
  });

  double minVerticalDistanceToNextObject;
  double maxVerticalDistanceToNextObject;
  final probGen = ProbabilityGenerator();
  final List<Fruit> _commonFruits = [];

  @override
  void onMount() {
    super.onMount();

    var currentX = (Constants.WORLD_SIZE.x.floor() / 2).toDouble() - 50;

    var currentY = Constants.WORLD_SIZE.y -
        (_rand.nextInt(Constants.WORLD_SIZE.y.floor()) / 3) -
        50;

    for (var i = 0; i < 9; i++) {
      if (i != 0) {
        currentX = _generateNextX(100);
        currentY = _generateNextY();
      }
      _commonFruits.add(
        _semiRandomFruit(
          Vector2(
            currentX,
            currentY,
          ),
        ),
      );

      add(_commonFruits[i]);
    }
  }

  @override
  void update(double dt) {
    //max 5 items per second & max 500 items alive at once;
    if (probGen.generateWithProbability(15) && _commonFruits.length < 500) {
      var newPlatY = _generateNextY();
      var newPlatX = _generateNextX(50);
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

  final Map<String, bool> specialItems = {
    'special_fruit': true, // level 1
    'rocket': false, // level 4
    'enemy': false, // level 5
  };

  void _maybeRemoveFruits() {
    if (probGen.generateWithProbability(75) && _commonFruits.isNotEmpty) {
      final oldestFruit = _commonFruits.removeAt(0);
      oldestFruit.removeFromParent();
    }
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

  double _generateNextX(int FruitWidth) {
    return _rand.nextInt(Constants.WORLD_SIZE.x.toInt()).toDouble();
  }

  double _generateNextY() {
    return _rand.nextInt(Constants.WORLD_SIZE.y.toInt()).toDouble();
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

  final List<Fruit> _bombs = [];
  void _maybeAddBombs() {
    if (specialItems['enemy'] != true) {
      return;
    }
    if (probGen.generateWithProbability(20)) {
      var enemy = GreenBomb(
        position: Vector2(_generateNextX(100), _generateNextY()),
      );
      add(enemy);
      _bombs.add(enemy);
      _maybeRemoveBombs();
    }
  }

  void _maybeRemoveBombs() {
    if (probGen.generateWithProbability(95) && _bombs.isNotEmpty) {
      final oldestFruit = _bombs.removeAt(0);
      oldestFruit.removeFromParent();
    }
  }

  final List<PowerUp> _boosters = [];

  void _maybeAddBoosters() {
    if (specialItems['noogler'] == true &&
        probGen.generateWithProbability(20)) {
      var nooglerHat = NooglerHat(
        position: Vector2(_generateNextX(75), _generateNextY()),
      );
      add(nooglerHat);
      _boosters.add(nooglerHat);
    } else if (specialItems['rocket'] == true &&
        probGen.generateWithProbability(15)) {
      var rocket = Rocket(
        position: Vector2(_generateNextX(50), _generateNextY()),
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
