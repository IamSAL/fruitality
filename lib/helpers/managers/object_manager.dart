// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flame/components.dart';
import 'package:fruitality/game/components/bodies/fruit.dart';
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
  final double _tallestFruitHeight = 50;
  final List<Fruit> _fruits = [];

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
      _fruits.add(
        _semiRandomFruit(
          Vector2(
            currentX,
            currentY,
          ),
        ),
      );

      add(_fruits[i]);
    }
  }

  @override
  void update(double dt) {
    //max 5 items per second & max 500 items alive at once;
    if (probGen.generateWithProbability(10) && _fruits.length < 500) {
      print("Total fruits");
      print(_fruits.length);
      var newPlatY = _generateNextY();
      var newPlatX = _generateNextX(50);
      final nextPlat = _semiRandomFruit(Vector2(newPlatX, newPlatY));
      print("Will add");
      print(nextPlat);
      print(Vector2(newPlatX, newPlatY));
      add(nextPlat);
      _fruits.add(nextPlat);
      gameRef.gameManager.increaseScore();

      _maybeRemoveFruits();
      _maybeAddEnemy();
      _maybeAddPowerup();
    }
    if (_fruits.length > 300) {
      _maybeRemoveFruits();
      _maybeAddEnemy();
    }

    super.update(dt);
  }

  final Map<String, bool> specialFruits = {
    'spring': true, // level 1
    'broken': false, // level 2
    'noogler': false, // level 3
    'rocket': false, // level 4
    'enemy': false, // level 5
  };

  void _maybeRemoveFruits() {
    if (probGen.generateWithProbability(75) && _fruits.isNotEmpty) {
      final oldestFruit = _fruits.removeAt(0);
      oldestFruit.removeFromParent();
    }
  }

  void enableSpecialty(String specialty) {
    specialFruits[specialty] = true;
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
    for (var key in specialFruits.keys) {
      specialFruits[key] = false;
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
    if (specialFruits['spring'] == true &&
        probGen.generateWithProbability(15)) {
      return SpringBoard(position: position);
    }

    if (specialFruits['broken'] == true &&
        probGen.generateWithProbability(10)) {
      return BrokenFruit(position: position);
    }

    return NormalFruit(position: position);
  }

  final List<EnemyFruit> _enemies = [];
  void _maybeAddEnemy() {
    if (specialFruits['enemy'] != true) {
      return;
    }
    if (probGen.generateWithProbability(20)) {
      var enemy = EnemyFruit(
        position: Vector2(_generateNextX(100), _generateNextY()),
      );
      add(enemy);
      _enemies.add(enemy);
      _cleanupEnemies();
    }
  }

  void _cleanupEnemies() {
    // final screenBottom = gameRef.player.position.y +
    //     (gameRef.size.x / 2) +
    //     gameRef.screenBufferSpace;

    // while (_enemies.isNotEmpty && _enemies.first.position.y > screenBottom) {
    //   remove(_enemies.first);
    //   _enemies.removeAt(0);
    // }
  }

  final List<PowerUp> _powerups = [];

  void _maybeAddPowerup() {
    if (specialFruits['noogler'] == true &&
        probGen.generateWithProbability(20)) {
      var nooglerHat = NooglerHat(
        position: Vector2(_generateNextX(75), _generateNextY()),
      );
      add(nooglerHat);
      _powerups.add(nooglerHat);
    } else if (specialFruits['rocket'] == true &&
        probGen.generateWithProbability(15)) {
      var rocket = Rocket(
        position: Vector2(_generateNextX(50), _generateNextY()),
      );
      add(rocket);
      _powerups.add(rocket);
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
