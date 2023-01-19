import 'dart:math';

import 'package:flame/components.dart';

import 'package:fruitality/game/components/bodies/fruits/fruit.dart';

enum GreenBombState { only }

class GreenBomb extends Fruit<GreenBombState> with Tappable {
  final Map<String, Vector2> spriteOptions = {
    'bomb_green': Vector2(50, 50),
    'bomb_red': Vector2(50, 50),
  };

  GreenBomb({required super.position})
      : super(currentState: GreenBombState.only);

  @override
  Future<void> onLoad() async {
    renderBody = false;
    var randSpriteIndex = Random().nextInt(spriteOptions.length);

    String randSprite = spriteOptions.keys.elementAt(randSpriteIndex);

    final sprites = {
      GreenBombState.only: await gameRef.loadSprite('game/$randSprite.png')
    };

    currentState = GreenBombState.only;

    add(
      SpriteComponent(
          sprite: sprites[currentState],
          size: spriteOptions[randSprite]!,
          anchor: Anchor.center,
          priority: 1),
    );

    await super.onLoad();
  }
}
