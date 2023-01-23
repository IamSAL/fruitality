import 'dart:math';

import 'package:flame/components.dart';

import 'package:fruitality/game/components/bodies/fruits/fruit.dart';
import 'package:fruitality/helpers/constants.dart';

enum SpecialFruitState { only }

class SpecialFruit extends Fruit<SpecialFruitState> with Tappable {
  final Map<String, Vector2> spriteOptions = {
    'fruit_mango_special': Constants.INIT_OBJECT_SIZE,
    'fruit_pineapple_special': Constants.INIT_OBJECT_SIZE,
    'fruit_banana_special': Constants.INIT_OBJECT_SIZE,
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
    renderBody = false;
    currentState = SpecialFruitState.only;

    add(
      SpriteComponent(
          sprite: sprites[currentState],
          size: spriteOptions[randSprite]! * 2,
          anchor: Anchor.center,
          priority: 1),
    );

    await super.onLoad();
  }
}
