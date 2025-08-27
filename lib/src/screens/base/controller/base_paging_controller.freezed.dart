// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_paging_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PagingValue<Key, Value> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Value> items, Key? nextPageKey, AppException? error)
        $default, {
    required TResult Function() loading,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Value> items, Key? nextPageKey, AppException? error)?
        $default, {
    TResult? Function()? loading,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Value> items, Key? nextPageKey, AppException? error)?
        $default, {
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Success<Key, Value> value) $default, {
    required TResult Function(Loading<Key, Value> value) loading,
    required TResult Function(Error<Key, Value> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(Success<Key, Value> value)? $default, {
    TResult? Function(Loading<Key, Value> value)? loading,
    TResult? Function(Error<Key, Value> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Success<Key, Value> value)? $default, {
    TResult Function(Loading<Key, Value> value)? loading,
    TResult Function(Error<Key, Value> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagingValueCopyWith<Key, Value, $Res> {
  factory $PagingValueCopyWith(PagingValue<Key, Value> value,
          $Res Function(PagingValue<Key, Value>) then) =
      _$PagingValueCopyWithImpl<Key, Value, $Res, PagingValue<Key, Value>>;
}

/// @nodoc
class _$PagingValueCopyWithImpl<Key, Value, $Res,
        $Val extends PagingValue<Key, Value>>
    implements $PagingValueCopyWith<Key, Value, $Res> {
  _$PagingValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<Key, Value, $Res> {
  factory _$$SuccessImplCopyWith(_$SuccessImpl<Key, Value> value,
          $Res Function(_$SuccessImpl<Key, Value>) then) =
      __$$SuccessImplCopyWithImpl<Key, Value, $Res>;
  @useResult
  $Res call({List<Value> items, Key? nextPageKey, AppException? error});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<Key, Value, $Res>
    extends _$PagingValueCopyWithImpl<Key, Value, $Res,
        _$SuccessImpl<Key, Value>>
    implements _$$SuccessImplCopyWith<Key, Value, $Res> {
  __$$SuccessImplCopyWithImpl(_$SuccessImpl<Key, Value> _value,
      $Res Function(_$SuccessImpl<Key, Value>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? nextPageKey = freezed,
    Object? error = freezed,
  }) {
    return _then(_$SuccessImpl<Key, Value>(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Value>,
      nextPageKey: freezed == nextPageKey
          ? _value.nextPageKey
          : nextPageKey // ignore: cast_nullable_to_non_nullable
              as Key?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AppException?,
    ));
  }
}

/// @nodoc

class _$SuccessImpl<Key, Value> extends Success<Key, Value> {
  const _$SuccessImpl(
      {required final List<Value> items, this.nextPageKey, this.error})
      : _items = items,
        super._();

  /// List with all items loaded so far.
  final List<Value> _items;

  /// List with all items loaded so far.
  @override
  List<Value> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// The key for the next page to be fetched.
  @override
  final Key? nextPageKey;

  /// The current error, if any.
  @override
  final AppException? error;

  @override
  String toString() {
    return 'PagingValue<$Key, $Value>(items: $items, nextPageKey: $nextPageKey, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl<Key, Value> &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality()
                .equals(other.nextPageKey, nextPageKey) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(nextPageKey),
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<Key, Value, _$SuccessImpl<Key, Value>> get copyWith =>
      __$$SuccessImplCopyWithImpl<Key, Value, _$SuccessImpl<Key, Value>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Value> items, Key? nextPageKey, AppException? error)
        $default, {
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return $default(items, nextPageKey, this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Value> items, Key? nextPageKey, AppException? error)?
        $default, {
    TResult? Function()? loading,
    TResult? Function()? error,
  }) {
    return $default?.call(items, nextPageKey, this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Value> items, Key? nextPageKey, AppException? error)?
        $default, {
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(items, nextPageKey, this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Success<Key, Value> value) $default, {
    required TResult Function(Loading<Key, Value> value) loading,
    required TResult Function(Error<Key, Value> value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(Success<Key, Value> value)? $default, {
    TResult? Function(Loading<Key, Value> value)? loading,
    TResult? Function(Error<Key, Value> value)? error,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Success<Key, Value> value)? $default, {
    TResult Function(Loading<Key, Value> value)? loading,
    TResult Function(Error<Key, Value> value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class Success<Key, Value> extends PagingValue<Key, Value> {
  const factory Success(
      {required final List<Value> items,
      final Key? nextPageKey,
      final AppException? error}) = _$SuccessImpl<Key, Value>;
  const Success._() : super._();

  /// List with all items loaded so far.
  List<Value> get items;

  /// The key for the next page to be fetched.
  Key? get nextPageKey;

  /// The current error, if any.
  AppException? get error;
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<Key, Value, _$SuccessImpl<Key, Value>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<Key, Value, $Res> {
  factory _$$LoadingImplCopyWith(_$LoadingImpl<Key, Value> value,
          $Res Function(_$LoadingImpl<Key, Value>) then) =
      __$$LoadingImplCopyWithImpl<Key, Value, $Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<Key, Value, $Res>
    extends _$PagingValueCopyWithImpl<Key, Value, $Res,
        _$LoadingImpl<Key, Value>>
    implements _$$LoadingImplCopyWith<Key, Value, $Res> {
  __$$LoadingImplCopyWithImpl(_$LoadingImpl<Key, Value> _value,
      $Res Function(_$LoadingImpl<Key, Value>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl<Key, Value> extends Loading<Key, Value> {
  const _$LoadingImpl() : super._();

  @override
  String toString() {
    return 'PagingValue<$Key, $Value>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl<Key, Value>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Value> items, Key? nextPageKey, AppException? error)
        $default, {
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Value> items, Key? nextPageKey, AppException? error)?
        $default, {
    TResult? Function()? loading,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Value> items, Key? nextPageKey, AppException? error)?
        $default, {
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Success<Key, Value> value) $default, {
    required TResult Function(Loading<Key, Value> value) loading,
    required TResult Function(Error<Key, Value> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(Success<Key, Value> value)? $default, {
    TResult? Function(Loading<Key, Value> value)? loading,
    TResult? Function(Error<Key, Value> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Success<Key, Value> value)? $default, {
    TResult Function(Loading<Key, Value> value)? loading,
    TResult Function(Error<Key, Value> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading<Key, Value> extends PagingValue<Key, Value> {
  const factory Loading() = _$LoadingImpl<Key, Value>;
  const Loading._() : super._();
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<Key, Value, $Res> {
  factory _$$ErrorImplCopyWith(_$ErrorImpl<Key, Value> value,
          $Res Function(_$ErrorImpl<Key, Value>) then) =
      __$$ErrorImplCopyWithImpl<Key, Value, $Res>;
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<Key, Value, $Res>
    extends _$PagingValueCopyWithImpl<Key, Value, $Res, _$ErrorImpl<Key, Value>>
    implements _$$ErrorImplCopyWith<Key, Value, $Res> {
  __$$ErrorImplCopyWithImpl(_$ErrorImpl<Key, Value> _value,
      $Res Function(_$ErrorImpl<Key, Value>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ErrorImpl<Key, Value> extends Error<Key, Value> {
  const _$ErrorImpl() : super._();

  @override
  String toString() {
    return 'PagingValue<$Key, $Value>.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ErrorImpl<Key, Value>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Value> items, Key? nextPageKey, AppException? error)
        $default, {
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Value> items, Key? nextPageKey, AppException? error)?
        $default, {
    TResult? Function()? loading,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Value> items, Key? nextPageKey, AppException? error)?
        $default, {
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Success<Key, Value> value) $default, {
    required TResult Function(Loading<Key, Value> value) loading,
    required TResult Function(Error<Key, Value> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(Success<Key, Value> value)? $default, {
    TResult? Function(Loading<Key, Value> value)? loading,
    TResult? Function(Error<Key, Value> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Success<Key, Value> value)? $default, {
    TResult Function(Loading<Key, Value> value)? loading,
    TResult Function(Error<Key, Value> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error<Key, Value> extends PagingValue<Key, Value> {
  const factory Error() = _$ErrorImpl<Key, Value>;
  const Error._() : super._();
}
