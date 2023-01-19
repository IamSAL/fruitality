import 'dart:math';

import 'package:flame/components.dart';

import 'package:fruitality/game/components/bodies/fruits/fruit.dart';

enum PoisonFruitState { only }

class PoisonFruit extends Fruit<PoisonFruitState> with Tappable {
  final Map<String, Vector2> spriteOptions = {
    'halloween_poison_fruit': Vector2(50, 50),
    'sin_poison_fruit': Vector2(50, 50),
  };

  PoisonFruit({required super.position})
      : super(currentState: PoisonFruitState.only);

  @override
  Future<void> onLoad() async {
    renderBody = false;
    var randSpriteIndex = Random().nextInt(spriteOptions.length);

    String randSprite = spriteOptions.keys.elementAt(randSpriteIndex);

    final sprites = {
      PoisonFruitState.only: await gameRef.loadSprite('game/$randSprite.png')
    };

    currentState = PoisonFruitState.only;

    add(
      SpriteComponent(
        sprite: sprites[currentState],
        size: spriteOptions[randSprite],
        anchor: Anchor.center,
      ),
    );

    await super.onLoad();
  }
}
