import 'dart:math';

import 'package:flame/components.dart';

import 'package:fruitality/game/components/bodies/fruits/fruit.dart';

enum CommonFruitState { only }

class CommonFruit extends Fruit<CommonFruitState> with Tappable {
  final Map<String, Vector2> spriteOptions = {
    'fruit_apple': Vector2(50, 50),
    'fruit_orange': Vector2(50, 50),
    'fruit_strawberry': Vector2(50, 50),
    'fruit_grape': Vector2(50, 50),
  };

  CommonFruit({required super.position})
      : super(currentState: CommonFruitState.only);

  @override
  Future<void> onLoad() async {
    renderBody = false;
    var randSpriteIndex = Random().nextInt(spriteOptions.length);

    String randSprite = spriteOptions.keys.elementAt(randSpriteIndex);

    final sprites = {
      CommonFruitState.only: await gameRef.loadSprite('game/$randSprite.png')
    };

    currentState = CommonFruitState.only;

    add(
      SpriteComponent(
        sprite: sprites[currentState],
        size: spriteOptions[randSprite]!,
        anchor: Anchor.center,
      ),
    );

    await super.onLoad();
  }
}
