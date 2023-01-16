import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:fruitality/game/components/grid_parallax.dart';
import 'package:fruitality/helpers/direction.dart';
import 'package:fruitality/screens/game_end_loose.dart';
import 'package:fruitality/screens/game_end_win.dart';
import 'package:fruitality/screens/game_pause.dart';
import 'package:fruitality/game/main_fruitality_page.dart';
import 'package:fruitality/screens/game_start.dart';

import 'components/player.dart';

class FruitaLityGame extends FlameGame {
  late final RouterComponent router;

  GridParallaxComponent _bgGrid = GridParallaxComponent();
  Player _player = Player();

  FruitaLityGame() : super();

  @override
  bool get debugMode => true;
  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }

  @override
  Future<void> onLoad() async {
    final paint = BasicPalette.red.paint()..style = PaintingStyle.stroke;
    final circle =
        CircleComponent(radius: 200.0, position: size / 2, paint: paint);
    add(circle);
    // add(
    //   router = RouterComponent(
    //     routes: {
    //       'start': OverlayRoute((context, game) => GameStart(game: this)),
    //       'pause': OverlayRoute((context, game) => GamePause()),
    //       'end_win': OverlayRoute((context, game) => GameEndWin()),
    //       'end_loose': OverlayRoute((context, game) => GameEndLoose()),
    //     },
    //     initialRoute: 'start',
    //   ),
    // );
    // double maxSide = min(size.x, size.y);
    // camera.viewport = FixedResolutionViewport(Vector2.all(maxSide));
    add(_bgGrid);
    _player.priority = 1;
    _player.position = size / 2;
    add(_player);
    print(size);
    print(_bgGrid.size);
    // camera.zoom = 4;
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _bgGrid.size.x, _bgGrid.size.y));
  }

  @override
  Color backgroundColor() => const Color(0x00000000);
}
