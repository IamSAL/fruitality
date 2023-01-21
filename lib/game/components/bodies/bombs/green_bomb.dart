import 'dart:math';

import 'package:flame/components.dart';
import 'package:fruitality/game/components/bodies/bombs/bomb.dart';

import 'package:fruitality/game/components/bodies/fruits/fruit.dart';
import 'package:fruitality/game/components/bodies/player.dart';

enum PoisonBombState { only }

class PoisonBomb extends Bomb<PoisonBombState> with Tappable {
  final Map<String, Vector2> spriteOptions = {
    'bomb_green': Vector2(50, 50),
    'bomb_red': Vector2(50, 50),
  };

  PoisonBomb({required super.position}) : super(currentState: PoisonBombState.only);

  @override
  Future<void> onLoad() async {
    renderBody = false;
    var randSpriteIndex = Random().nextInt(spriteOptions.length);

    String randSprite = spriteOptions.keys.elementAt(randSpriteIndex);

    final sprites = {PoisonBombState.only: await gameRef.loadSprite('game/$randSprite.png')};

    currentState = PoisonBombState.only;

    add(
      SpriteComponent(
          sprite: sprites[currentState], size: spriteOptions[randSprite]!, anchor: Anchor.center, priority: 1),
    );

    await super.onLoad();
  }

  @override
  onPlayerContactBegin(PlayerBody playerBody) {
    gameRef.onLose();
  }
}