import 'dart:math';

import 'package:flame/components.dart';

import 'package:fruitality/game/components/bodies/fruits/fruit.dart';

enum SpecialFruitState { only }

class SpecialFruit extends Fruit<SpecialFruitState> with Tappable {
  final Map<String, Vector2> spriteOptions = {
    'fruit_mango_special': Vector2(50, 50) / 10,
    'fruit_pineapple_special': Vector2(50, 50) / 10,
    'fruit_banana_special': Vector2(50, 50) / 10,
  };
  SpecialFruit({required super.position})
      : super(currentState: SpecialFruitState.only);

  @override
  Future<void> onLoad() async {
    renderBody = false;
    var randSpriteIndex = Random().nextInt(spriteOptions.length);

    String randSprite = spriteOptions.keys.elementAt(randSpriteIndex);

    final sprites = {
      SpecialFruitState.only: await gameRef.loadSprite('game/$randSprite.png')
    };

    currentState = SpecialFruitState.only;

    add(
      SpriteComponent(
          sprite: sprites[currentState],
          size: spriteOptions[randSprite],
          anchor: Anchor.center,
          priority: 1),
    );

    await super.onLoad();
  }
}
