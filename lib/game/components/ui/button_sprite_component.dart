import 'dart:collection';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruitality/game/fruitality_game.dart';
import 'package:google_fonts/google_fonts.dart';

enum ButtonState {
  pressed,
  unpressed,
}

/// Outlines a text using shadows.
List<Shadow> outlinedText(
    {double strokeWidth = 2,
    Color strokeColor = Colors.black,
    int precision = 5}) {
  Set<Shadow> result = HashSet();
  for (int x = 1; x < strokeWidth + precision; x++) {
    for (int y = 1; y < strokeWidth + precision; y++) {
      double offsetX = x.toDouble();
      double offsetY = y.toDouble();
      result.add(Shadow(
          offset: Offset(-strokeWidth / offsetX, -strokeWidth / offsetY),
          color: strokeColor));
      result.add(Shadow(
          offset: Offset(-strokeWidth / offsetX, strokeWidth / offsetY),
          color: strokeColor));
      result.add(Shadow(
          offset: Offset(strokeWidth / offsetX, -strokeWidth / offsetY),
          color: strokeColor));
      result.add(Shadow(
          offset: Offset(strokeWidth / offsetX, strokeWidth / offsetY),
          color: strokeColor));
    }
  }
  return result.toList();
}

class ButtonSpriteComponent extends SpriteGroupComponent<ButtonState>
    with HasGameRef<FruitaLityGame>, Tappable {
  final VoidCallback onTap;
  final String? label;
  ButtonSpriteComponent({
    required this.onTap,
    this.label = "Press",
    super.position,
  }) : super(
          anchor: Anchor.center,
          priority: 1,
        );

  @override
  Future<void>? onLoad() async {
    positionType = PositionType.viewport;
    scale = Vector2.all(0.75);
    final pressedSprite = await gameRef.loadSprite("btn_bg_pressed.png");
    final unpressedSprite = await gameRef.loadSprite("btn_bg_normal.png");
    size = pressedSprite.originalSize;
    sprites = {
      ButtonState.pressed: pressedSprite,
      ButtonState.unpressed: unpressedSprite,
    };

    final textStyle = GoogleFonts.racingSansOne(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        shadows: outlinedText(strokeColor: Color(0xFF3D3D3D)));

    final pressedText = TextPaint(style: textStyle);

    add(TextComponent(
        text: this.label,
        position: size / 2,
        anchor: Anchor.center,
        textRenderer: pressedText));
    current = ButtonState.unpressed;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    current = ButtonState.pressed;
    onTap();
    return super.onTapDown(info);
  }

  @override
  bool onLongTapDown(TapDownInfo info) {
    current = ButtonState.pressed;
    onTap();
    return super.onLongTapDown(info);
  }

  @override
  bool onTapUp(TapUpInfo info) {
    current = ButtonState.unpressed;
    return super.onTapUp(info);
  }

  // tap methods handler omitted...
}
