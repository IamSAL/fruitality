// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flame/components.dart';
import 'package:fruitality/helpers/constants.dart';

class Range {
  final double start;
  final double end;
  Range(this.start, this.end);

  bool overlaps(Range other) {
    if (other.start > start && other.start < end) return true;
    if (other.end > end && other.end < end) return true;
    return false;
  }

  static bool between(int number, int floor, int ciel) {
    return number > floor && number <= ciel;
  }
}

extension Between on num {
  bool between(num floor, num ceiling) {
    return this > floor && this <= ceiling;
  }
}

class ProbabilityGenerator {
  final Random _rand = Random();

  ProbabilityGenerator();

  bool generateWithProbability(double percent) {
    var randomInt = _rand.nextInt(100) + 1; // generate a number 1-100 inclusive

    if (randomInt <= percent) {
      return true;
    }

    return false;
  }
}

extension PercentOf on num {
  double percent(num other) => this * other / 100;
}

double angleBetweenVectors(Vector2 vec1, Vector2 vec2) {
  var vector1 = [vec1.x, vec1.y];
  var vector2 = [vec2.x, vec2.y];

  double angleRad =
      atan2(vector2[1], vector2[0]) - atan2(vector1[1], vector1[0]);

  double angleDeg = angleRad * (180 / pi);
  //print("$vec1 $vec2 angle ${angleRad} : $angleDeg");
  return angleDeg;
}

Vector2 getFurthestPoint(
  Vector2 touchPoint,
  Vector2 playerPoint,
) {
  double playerX = playerPoint.x;
  double playerY = playerPoint.y;
  double touchX = touchPoint.x;
  double touchY = touchPoint.y;
  double worldX = Constants.WORLD_SIZE.x;
  double worldY = Constants.WORLD_SIZE.y;
  double distance = 2;

  double angle = atan2(touchY - playerY, touchX - playerX);
  double x = playerX + distance * cos(angle);
  double y = playerY + distance * sin(angle);
  x = min(worldX, max(x, 0));
  y = min(worldY, max(y, 0));
  //print("Furthest point in the same direction: ($x, $y)");

  return Vector2(x, y);
}

class LowPassFilter {
  late double _alpha;
  double _previousValue = 0;

  LowPassFilter({required double cutoffFrequency}) {
    _alpha = 1 / (1 + cutoffFrequency);
  }

  double apply(double newValue) {
    _previousValue = _alpha * newValue + (1 - _alpha) * _previousValue;
    return _previousValue;
  }
}
