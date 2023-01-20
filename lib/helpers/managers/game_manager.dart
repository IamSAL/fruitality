// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:fruitality/game/fruitality_game.dart';

enum Character { rabbit, dino }

enum GameResult { win, loose, unknown }

class GameManager extends Component with HasGameRef<FruitaLityGame> {
  GameManager() {
    interval = Timer(
      1,
      onTick: () => elapsedSecs.value += 1,
      repeat: true,
    );
  }

  Character character = Character.rabbit;
  ValueNotifier<int> fruits = ValueNotifier(0);
  ValueNotifier<int> elapsedSecs = ValueNotifier(0);
  late Timer interval;
  GameResult result = GameResult.unknown;
  GameState state = GameState.intro;

  bool get isPlaying => state == GameState.playing;

  bool get isGameOver => state == GameState.gameOver;

  bool get isIntro => state == GameState.intro;

  void reset() {
    elapsedSecs.value = 0;

    fruits.value = 0;
    state = GameState.intro;
  }

  void increaseScore() {
    fruits.value++;
  }

  void selectCharacter(Character selectedCharacter) {
    character = selectedCharacter;
  }

  @override
  void update(double dt) {
    interval.update(dt);
    super.update(dt);
  }
}

enum GameState { intro, playing, gameOver }
