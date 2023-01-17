import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridImageBackground extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    position = Vector2(0, 0);
    sprite = await gameRef.loadSprite("bg_grid.png");
    size = sprite!.originalSize;

    return super.onLoad();
  }
}
