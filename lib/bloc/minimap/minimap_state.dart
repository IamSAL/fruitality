part of 'minimap_bloc.dart';

@freezed
class MiniMapStateEntity with _$MiniMapStateEntity {
  const factory MiniMapStateEntity(
      {@Default(false) bool isFullScreen,
      required Vector2 playerPosition}) = _MiniMapStateEntity;
}

@freezed
class MinimapState with _$MinimapState {
  const factory MinimapState.initial() = _Initial;
  const factory MinimapState.updated(MiniMapStateEntity miniMapState) =
      _Updated;
}
