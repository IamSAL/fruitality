import 'package:bloc/bloc.dart';
import 'package:flame/game.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'minimap_event.dart';
part 'minimap_state.dart';
part 'minimap_bloc.freezed.dart';

class MinimapBloc extends Bloc<MinimapEvent, MinimapState> {
  MinimapBloc() : super(_Initial()) {
    on<_Update>((event, emit) {
      print("position updated:");
      print(event.newState);
    });
  }
}
