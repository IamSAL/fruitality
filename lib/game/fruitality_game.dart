import 'dart:ui';

import 'package:flame/game.dart';
import 'package:fruitality/game/components/world.dart';
import 'package:fruitality/helpers/direction.dart';
import 'package:fruitality/screens/game_end_loose.dart';
import 'package:fruitality/screens/game_end_win.dart';
import 'package:fruitality/screens/game_pause.dart';
import 'package:fruitality/game/main_fruitality_page.dart';
import 'package:fruitality/screens/game_start.dart';

import 'components/player.dart';

class FruitaLityGame extends FlameGame {
  late final RouterComponent router;
  World _world = World();
  Player _player = Player();
  FruitaLityGame() : super();

  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }

  @override
  Future<void> onLoad() async {
    add(
      router = RouterComponent(
        routes: {
          'start': OverlayRoute((context, game) => GameStart(game: this)),
          'pause': OverlayRoute((context, game) => GamePause()),
          'end_win': OverlayRoute((context, game) => GameEndWin()),
          'end_loose': OverlayRoute((context, game) => GameEndLoose()),
        },
        initialRoute: 'start',
      ),
    );

    add(_world);
    add(_player);
    _player.position = _world.size / 2;
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
  }

  @override
  Color backgroundColor() => const Color(0x00000000);
}
