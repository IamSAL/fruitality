// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'minimap_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MinimapEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(MiniMapStateEntity newState) update,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(MiniMapStateEntity newState)? update,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(MiniMapStateEntity newState)? update,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Update value) update,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Update value)? update,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Update value)? update,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MinimapEventCopyWith<$Res> {
  factory $MinimapEventCopyWith(
          MinimapEvent value, $Res Function(MinimapEvent) then) =
      _$MinimapEventCopyWithImpl<$Res, MinimapEvent>;
}

/// @nodoc
class _$MinimapEventCopyWithImpl<$Res, $Val extends MinimapEvent>
    implements $MinimapEventCopyWith<$Res> {
  _$MinimapEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_StartedCopyWith<$Res> {
  factory _$$_StartedCopyWith(
          _$_Started value, $Res Function(_$_Started) then) =
      __$$_StartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_StartedCopyWithImpl<$Res>
    extends _$MinimapEventCopyWithImpl<$Res, _$_Started>
    implements _$$_StartedCopyWith<$Res> {
  __$$_StartedCopyWithImpl(_$_Started _value, $Res Function(_$_Started) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Started implements _Started {
  const _$_Started();

  @override
  String toString() {
    return 'MinimapEvent.started()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Started);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(MiniMapStateEntity newState) update,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(MiniMapStateEntity newState)? update,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(MiniMapStateEntity newState)? update,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Update value) update,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Update value)? update,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Update value)? update,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements MinimapEvent {
  const factory _Started() = _$_Started;
}

/// @nodoc
abstract class _$$_UpdateCopyWith<$Res> {
  factory _$$_UpdateCopyWith(_$_Update value, $Res Function(_$_Update) then) =
      __$$_UpdateCopyWithImpl<$Res>;
  @useResult
  $Res call({MiniMapStateEntity newState});

  $MiniMapStateEntityCopyWith<$Res> get newState;
}

/// @nodoc
class __$$_UpdateCopyWithImpl<$Res>
    extends _$MinimapEventCopyWithImpl<$Res, _$_Update>
    implements _$$_UpdateCopyWith<$Res> {
  __$$_UpdateCopyWithImpl(_$_Update _value, $Res Function(_$_Update) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newState = null,
  }) {
    return _then(_$_Update(
      null == newState
          ? _value.newState
          : newState // ignore: cast_nullable_to_non_nullable
              as MiniMapStateEntity,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $MiniMapStateEntityCopyWith<$Res> get newState {
    return $MiniMapStateEntityCopyWith<$Res>(_value.newState, (value) {
      return _then(_value.copyWith(newState: value));
    });
  }
}

/// @nodoc

class _$_Update implements _Update {
  const _$_Update(this.newState);

  @override
  final MiniMapStateEntity newState;

  @override
  String toString() {
    return 'MinimapEvent.update(newState: $newState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Update &&
            (identical(other.newState, newState) ||
                other.newState == newState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdateCopyWith<_$_Update> get copyWith =>
      __$$_UpdateCopyWithImpl<_$_Update>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(MiniMapStateEntity newState) update,
  }) {
    return update(newState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(MiniMapStateEntity newState)? update,
  }) {
    return update?.call(newState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(MiniMapStateEntity newState)? update,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(newState);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Update value) update,
  }) {
    return update(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Update value)? update,
  }) {
    return update?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Update value)? update,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(this);
    }
    return orElse();
  }
}

abstract class _Update implements MinimapEvent {
  const factory _Update(final MiniMapStateEntity newState) = _$_Update;

  MiniMapStateEntity get newState;
  @JsonKey(ignore: true)
  _$$_UpdateCopyWith<_$_Update> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MiniMapStateEntity {
  bool get isFullScreen => throw _privateConstructorUsedError;
  Vector2 get playerPosition => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MiniMapStateEntityCopyWith<MiniMapStateEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MiniMapStateEntityCopyWith<$Res> {
  factory $MiniMapStateEntityCopyWith(
          MiniMapStateEntity value, $Res Function(MiniMapStateEntity) then) =
      _$MiniMapStateEntityCopyWithImpl<$Res, MiniMapStateEntity>;
  @useResult
  $Res call({bool isFullScreen, Vector2 playerPosition});
}

/// @nodoc
class _$MiniMapStateEntityCopyWithImpl<$Res, $Val extends MiniMapStateEntity>
    implements $MiniMapStateEntityCopyWith<$Res> {
  _$MiniMapStateEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFullScreen = null,
    Object? playerPosition = null,
  }) {
    return _then(_value.copyWith(
      isFullScreen: null == isFullScreen
          ? _value.isFullScreen
          : isFullScreen // ignore: cast_nullable_to_non_nullable
              as bool,
      playerPosition: null == playerPosition
          ? _value.playerPosition
          : playerPosition // ignore: cast_nullable_to_non_nullable
              as Vector2,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MiniMapStateEntityCopyWith<$Res>
    implements $MiniMapStateEntityCopyWith<$Res> {
  factory _$$_MiniMapStateEntityCopyWith(_$_MiniMapStateEntity value,
          $Res Function(_$_MiniMapStateEntity) then) =
      __$$_MiniMapStateEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isFullScreen, Vector2 playerPosition});
}

/// @nodoc
class __$$_MiniMapStateEntityCopyWithImpl<$Res>
    extends _$MiniMapStateEntityCopyWithImpl<$Res, _$_MiniMapStateEntity>
    implements _$$_MiniMapStateEntityCopyWith<$Res> {
  __$$_MiniMapStateEntityCopyWithImpl(
      _$_MiniMapStateEntity _value, $Res Function(_$_MiniMapStateEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFullScreen = null,
    Object? playerPosition = null,
  }) {
    return _then(_$_MiniMapStateEntity(
      isFullScreen: null == isFullScreen
          ? _value.isFullScreen
          : isFullScreen // ignore: cast_nullable_to_non_nullable
              as bool,
      playerPosition: null == playerPosition
          ? _value.playerPosition
          : playerPosition // ignore: cast_nullable_to_non_nullable
              as Vector2,
    ));
  }
}

/// @nodoc

class _$_MiniMapStateEntity implements _MiniMapStateEntity {
  const _$_MiniMapStateEntity(
      {this.isFullScreen = false, required this.playerPosition});

  @override
  @JsonKey()
  final bool isFullScreen;
  @override
  final Vector2 playerPosition;

  @override
  String toString() {
    return 'MiniMapStateEntity(isFullScreen: $isFullScreen, playerPosition: $playerPosition)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MiniMapStateEntity &&
            (identical(other.isFullScreen, isFullScreen) ||
                other.isFullScreen == isFullScreen) &&
            (identical(other.playerPosition, playerPosition) ||
                other.playerPosition == playerPosition));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isFullScreen, playerPosition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MiniMapStateEntityCopyWith<_$_MiniMapStateEntity> get copyWith =>
      __$$_MiniMapStateEntityCopyWithImpl<_$_MiniMapStateEntity>(
          this, _$identity);
}

abstract class _MiniMapStateEntity implements MiniMapStateEntity {
  const factory _MiniMapStateEntity(
      {final bool isFullScreen,
      required final Vector2 playerPosition}) = _$_MiniMapStateEntity;

  @override
  bool get isFullScreen;
  @override
  Vector2 get playerPosition;
  @override
  @JsonKey(ignore: true)
  _$$_MiniMapStateEntityCopyWith<_$_MiniMapStateEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MinimapState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(MiniMapStateEntity miniMapState) updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(MiniMapStateEntity miniMapState)? updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(MiniMapStateEntity miniMapState)? updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Updated value) updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Updated value)? updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Updated value)? updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MinimapStateCopyWith<$Res> {
  factory $MinimapStateCopyWith(
          MinimapState value, $Res Function(MinimapState) then) =
      _$MinimapStateCopyWithImpl<$Res, MinimapState>;
}

/// @nodoc
class _$MinimapStateCopyWithImpl<$Res, $Val extends MinimapState>
    implements $MinimapStateCopyWith<$Res> {
  _$MinimapStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$MinimapStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'MinimapState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(MiniMapStateEntity miniMapState) updated,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(MiniMapStateEntity miniMapState)? updated,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(MiniMapStateEntity miniMapState)? updated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Updated value) updated,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Updated value)? updated,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Updated value)? updated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements MinimapState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$_UpdatedCopyWith<$Res> {
  factory _$$_UpdatedCopyWith(
          _$_Updated value, $Res Function(_$_Updated) then) =
      __$$_UpdatedCopyWithImpl<$Res>;
  @useResult
  $Res call({MiniMapStateEntity miniMapState});

  $MiniMapStateEntityCopyWith<$Res> get miniMapState;
}

/// @nodoc
class __$$_UpdatedCopyWithImpl<$Res>
    extends _$MinimapStateCopyWithImpl<$Res, _$_Updated>
    implements _$$_UpdatedCopyWith<$Res> {
  __$$_UpdatedCopyWithImpl(_$_Updated _value, $Res Function(_$_Updated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? miniMapState = null,
  }) {
    return _then(_$_Updated(
      null == miniMapState
          ? _value.miniMapState
          : miniMapState // ignore: cast_nullable_to_non_nullable
              as MiniMapStateEntity,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $MiniMapStateEntityCopyWith<$Res> get miniMapState {
    return $MiniMapStateEntityCopyWith<$Res>(_value.miniMapState, (value) {
      return _then(_value.copyWith(miniMapState: value));
    });
  }
}

/// @nodoc

class _$_Updated implements _Updated {
  const _$_Updated(this.miniMapState);

  @override
  final MiniMapStateEntity miniMapState;

  @override
  String toString() {
    return 'MinimapState.updated(miniMapState: $miniMapState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Updated &&
            (identical(other.miniMapState, miniMapState) ||
                other.miniMapState == miniMapState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, miniMapState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdatedCopyWith<_$_Updated> get copyWith =>
      __$$_UpdatedCopyWithImpl<_$_Updated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(MiniMapStateEntity miniMapState) updated,
  }) {
    return updated(miniMapState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(MiniMapStateEntity miniMapState)? updated,
  }) {
    return updated?.call(miniMapState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(MiniMapStateEntity miniMapState)? updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(miniMapState);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Updated value) updated,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Updated value)? updated,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Updated value)? updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class _Updated implements MinimapState {
  const factory _Updated(final MiniMapStateEntity miniMapState) = _$_Updated;

  MiniMapStateEntity get miniMapState;
  @JsonKey(ignore: true)
  _$$_UpdatedCopyWith<_$_Updated> get copyWith =>
      throw _privateConstructorUsedError;
}
