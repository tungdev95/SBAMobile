// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'taisan_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TaiSanPageState {
  List<AssetMenuModel<SvgGenImage>> get lsMenuModel =>
      throw _privateConstructorUsedError;
  AssetsTypeEnum? get currentType => throw _privateConstructorUsedError;
  FileStatus get currentStatus => throw _privateConstructorUsedError;
  AssetsTypeEnum? get currentTypeDi => throw _privateConstructorUsedError;
  FileStatus get currentStatusDi => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaiSanPageStateCopyWith<TaiSanPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaiSanPageStateCopyWith<$Res> {
  factory $TaiSanPageStateCopyWith(
          TaiSanPageState value, $Res Function(TaiSanPageState) then) =
      _$TaiSanPageStateCopyWithImpl<$Res, TaiSanPageState>;
  @useResult
  $Res call(
      {List<AssetMenuModel<SvgGenImage>> lsMenuModel,
      AssetsTypeEnum? currentType,
      FileStatus currentStatus,
      AssetsTypeEnum? currentTypeDi,
      FileStatus currentStatusDi});
}

/// @nodoc
class _$TaiSanPageStateCopyWithImpl<$Res, $Val extends TaiSanPageState>
    implements $TaiSanPageStateCopyWith<$Res> {
  _$TaiSanPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lsMenuModel = null,
    Object? currentType = freezed,
    Object? currentStatus = null,
    Object? currentTypeDi = freezed,
    Object? currentStatusDi = null,
  }) {
    return _then(_value.copyWith(
      lsMenuModel: null == lsMenuModel
          ? _value.lsMenuModel
          : lsMenuModel // ignore: cast_nullable_to_non_nullable
              as List<AssetMenuModel<SvgGenImage>>,
      currentType: freezed == currentType
          ? _value.currentType
          : currentType // ignore: cast_nullable_to_non_nullable
              as AssetsTypeEnum?,
      currentStatus: null == currentStatus
          ? _value.currentStatus
          : currentStatus // ignore: cast_nullable_to_non_nullable
              as FileStatus,
      currentTypeDi: freezed == currentTypeDi
          ? _value.currentTypeDi
          : currentTypeDi // ignore: cast_nullable_to_non_nullable
              as AssetsTypeEnum?,
      currentStatusDi: null == currentStatusDi
          ? _value.currentStatusDi
          : currentStatusDi // ignore: cast_nullable_to_non_nullable
              as FileStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaiSanPageStateImplCopyWith<$Res>
    implements $TaiSanPageStateCopyWith<$Res> {
  factory _$$TaiSanPageStateImplCopyWith(_$TaiSanPageStateImpl value,
          $Res Function(_$TaiSanPageStateImpl) then) =
      __$$TaiSanPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<AssetMenuModel<SvgGenImage>> lsMenuModel,
      AssetsTypeEnum? currentType,
      FileStatus currentStatus,
      AssetsTypeEnum? currentTypeDi,
      FileStatus currentStatusDi});
}

/// @nodoc
class __$$TaiSanPageStateImplCopyWithImpl<$Res>
    extends _$TaiSanPageStateCopyWithImpl<$Res, _$TaiSanPageStateImpl>
    implements _$$TaiSanPageStateImplCopyWith<$Res> {
  __$$TaiSanPageStateImplCopyWithImpl(
      _$TaiSanPageStateImpl _value, $Res Function(_$TaiSanPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lsMenuModel = null,
    Object? currentType = freezed,
    Object? currentStatus = null,
    Object? currentTypeDi = freezed,
    Object? currentStatusDi = null,
  }) {
    return _then(_$TaiSanPageStateImpl(
      lsMenuModel: null == lsMenuModel
          ? _value._lsMenuModel
          : lsMenuModel // ignore: cast_nullable_to_non_nullable
              as List<AssetMenuModel<SvgGenImage>>,
      currentType: freezed == currentType
          ? _value.currentType
          : currentType // ignore: cast_nullable_to_non_nullable
              as AssetsTypeEnum?,
      currentStatus: null == currentStatus
          ? _value.currentStatus
          : currentStatus // ignore: cast_nullable_to_non_nullable
              as FileStatus,
      currentTypeDi: freezed == currentTypeDi
          ? _value.currentTypeDi
          : currentTypeDi // ignore: cast_nullable_to_non_nullable
              as AssetsTypeEnum?,
      currentStatusDi: null == currentStatusDi
          ? _value.currentStatusDi
          : currentStatusDi // ignore: cast_nullable_to_non_nullable
              as FileStatus,
    ));
  }
}

/// @nodoc

class _$TaiSanPageStateImpl implements _TaiSanPageState {
  const _$TaiSanPageStateImpl(
      {final List<AssetMenuModel<SvgGenImage>> lsMenuModel = const [],
      this.currentType,
      this.currentStatus = FileStatus.chuaCoLichKhaoSat,
      this.currentTypeDi,
      this.currentStatusDi = FileStatus.choDuyet})
      : _lsMenuModel = lsMenuModel;

  final List<AssetMenuModel<SvgGenImage>> _lsMenuModel;
  @override
  @JsonKey()
  List<AssetMenuModel<SvgGenImage>> get lsMenuModel {
    if (_lsMenuModel is EqualUnmodifiableListView) return _lsMenuModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lsMenuModel);
  }

  @override
  final AssetsTypeEnum? currentType;
  @override
  @JsonKey()
  final FileStatus currentStatus;
  @override
  final AssetsTypeEnum? currentTypeDi;
  @override
  @JsonKey()
  final FileStatus currentStatusDi;

  @override
  String toString() {
    return 'TaiSanPageState(lsMenuModel: $lsMenuModel, currentType: $currentType, currentStatus: $currentStatus, currentTypeDi: $currentTypeDi, currentStatusDi: $currentStatusDi)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaiSanPageStateImpl &&
            const DeepCollectionEquality()
                .equals(other._lsMenuModel, _lsMenuModel) &&
            (identical(other.currentType, currentType) ||
                other.currentType == currentType) &&
            (identical(other.currentStatus, currentStatus) ||
                other.currentStatus == currentStatus) &&
            (identical(other.currentTypeDi, currentTypeDi) ||
                other.currentTypeDi == currentTypeDi) &&
            (identical(other.currentStatusDi, currentStatusDi) ||
                other.currentStatusDi == currentStatusDi));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_lsMenuModel),
      currentType,
      currentStatus,
      currentTypeDi,
      currentStatusDi);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaiSanPageStateImplCopyWith<_$TaiSanPageStateImpl> get copyWith =>
      __$$TaiSanPageStateImplCopyWithImpl<_$TaiSanPageStateImpl>(
          this, _$identity);
}

abstract class _TaiSanPageState implements TaiSanPageState {
  const factory _TaiSanPageState(
      {final List<AssetMenuModel<SvgGenImage>> lsMenuModel,
      final AssetsTypeEnum? currentType,
      final FileStatus currentStatus,
      final AssetsTypeEnum? currentTypeDi,
      final FileStatus currentStatusDi}) = _$TaiSanPageStateImpl;

  @override
  List<AssetMenuModel<SvgGenImage>> get lsMenuModel;
  @override
  AssetsTypeEnum? get currentType;
  @override
  FileStatus get currentStatus;
  @override
  AssetsTypeEnum? get currentTypeDi;
  @override
  FileStatus get currentStatusDi;
  @override
  @JsonKey(ignore: true)
  _$$TaiSanPageStateImplCopyWith<_$TaiSanPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
