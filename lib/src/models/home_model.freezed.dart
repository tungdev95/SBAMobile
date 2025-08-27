// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeData {
// @Default("") String userName,
// @Default("") String id,
  bool get isFavorite => throw _privateConstructorUsedError;
  List<HomeMenuModel> get tabListData => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeDataCopyWith<HomeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeDataCopyWith<$Res> {
  factory $HomeDataCopyWith(HomeData value, $Res Function(HomeData) then) =
      _$HomeDataCopyWithImpl<$Res, HomeData>;
  @useResult
  $Res call({bool isFavorite, List<HomeMenuModel> tabListData});
}

/// @nodoc
class _$HomeDataCopyWithImpl<$Res, $Val extends HomeData>
    implements $HomeDataCopyWith<$Res> {
  _$HomeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFavorite = null,
    Object? tabListData = null,
  }) {
    return _then(_value.copyWith(
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      tabListData: null == tabListData
          ? _value.tabListData
          : tabListData // ignore: cast_nullable_to_non_nullable
              as List<HomeMenuModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeDataImplCopyWith<$Res>
    implements $HomeDataCopyWith<$Res> {
  factory _$$HomeDataImplCopyWith(
          _$HomeDataImpl value, $Res Function(_$HomeDataImpl) then) =
      __$$HomeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isFavorite, List<HomeMenuModel> tabListData});
}

/// @nodoc
class __$$HomeDataImplCopyWithImpl<$Res>
    extends _$HomeDataCopyWithImpl<$Res, _$HomeDataImpl>
    implements _$$HomeDataImplCopyWith<$Res> {
  __$$HomeDataImplCopyWithImpl(
      _$HomeDataImpl _value, $Res Function(_$HomeDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFavorite = null,
    Object? tabListData = null,
  }) {
    return _then(_$HomeDataImpl(
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      tabListData: null == tabListData
          ? _value._tabListData
          : tabListData // ignore: cast_nullable_to_non_nullable
              as List<HomeMenuModel>,
    ));
  }
}

/// @nodoc

class _$HomeDataImpl implements _HomeData {
  _$HomeDataImpl(
      {this.isFavorite = false,
      final List<HomeMenuModel> tabListData = const []})
      : _tabListData = tabListData;

// @Default("") String userName,
// @Default("") String id,
  @override
  @JsonKey()
  final bool isFavorite;
  final List<HomeMenuModel> _tabListData;
  @override
  @JsonKey()
  List<HomeMenuModel> get tabListData {
    if (_tabListData is EqualUnmodifiableListView) return _tabListData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tabListData);
  }

  @override
  String toString() {
    return 'HomeData(isFavorite: $isFavorite, tabListData: $tabListData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeDataImpl &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            const DeepCollectionEquality()
                .equals(other._tabListData, _tabListData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isFavorite,
      const DeepCollectionEquality().hash(_tabListData));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeDataImplCopyWith<_$HomeDataImpl> get copyWith =>
      __$$HomeDataImplCopyWithImpl<_$HomeDataImpl>(this, _$identity);
}

abstract class _HomeData implements HomeData {
  factory _HomeData(
      {final bool isFavorite,
      final List<HomeMenuModel> tabListData}) = _$HomeDataImpl;

  @override // @Default("") String userName,
// @Default("") String id,
  bool get isFavorite;
  @override
  List<HomeMenuModel> get tabListData;
  @override
  @JsonKey(ignore: true)
  _$$HomeDataImplCopyWith<_$HomeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
