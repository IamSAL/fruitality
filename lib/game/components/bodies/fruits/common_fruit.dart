import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import 'package:fruitality/game/components/bodies/fruits/fruit.dart';
import 'package:fruitality/game/components/bodies/player.dart';
import 'package:fruitality/helpers/constants.dart';

enum CommonFruitState { only }

class CommonFruit extends Fruit<CommonFruitState> {
  final Map<String, Vector2> spriteOptions = {
    'fruit_apple': Constants.INIT_OBJECT_SIZE,
    'fruit_orange': Constants.INIT_OBJECT_SIZE,
    'fruit_strawberry': Constants.INIT_OBJECT_SIZE,
    'fruit_grape': Constants.INIT_OBJECT_SIZE,
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
    renderBody = false;
    currentState = CommonFruitState.only;

    add(
      SpriteComponent(
        sprite: sprites[currentState],
        size: spriteOptions[randSprite]! * 2,
        anchor: Anchor.center,
      ),
    );

    await super.onLoad();
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is PlayerBody) {
      gameRef.gameManager.increaseScore();
      gameRef.objectManager.objectsMarkedForRemoval.add(this);
    }

    if (other is Fruit) {
      body.applyLinearImpulse(Vector2(0.05, 0.05));
      other.body.applyLinearImpulse(Vector2(-0.05, -0.05));
    }
  }
}
