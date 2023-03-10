import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import 'package:fruitality/game/components/bodies/fruits/fruit.dart';
import 'package:fruitality/helpers/constants.dart';

import '../player.dart';

enum PoisonFruitState { only }

class PoisonFruit extends Fruit<PoisonFruitState> {
  final Map<String, Vector2> spriteOptions = {
    'halloween_poison_fruit': Constants.INIT_OBJECT_SIZE,
    'sin_poison_fruit': Constants.INIT_OBJECT_SIZE,
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
    renderBody = false;
    currentState = PoisonFruitState.only;

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
      gameRef.gameManager.decreaseScore();
      gameRef.player.setPlayerSpriteState(PlayerSpriteState.drunk);

      gameRef.objectManager.objectsMarkedForRemoval.add(this);
    }

    if (other is Fruit) {
      body.applyLinearImpulse(Vector2(0.05, 0.05));
      other.body.applyLinearImpulse(Vector2(-0.05, -0.05));
    }
  }
}
