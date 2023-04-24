part of 'minimap_bloc.dart';

@freezed
class MinimapEvent with _$MinimapEvent {
  const factory MinimapEvent.started() = _Started;
  const factory MinimapEvent.update(MiniMapStateEntity newState) = _Update;
}
