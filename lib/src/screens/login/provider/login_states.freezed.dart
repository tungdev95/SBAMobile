// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginState {
  String get emailAddress => throw _privateConstructorUsedError;
  String get passWord => throw _privateConstructorUsedError;
  bool get validateData => throw _privateConstructorUsedError;
  BiometricType? get bioMetricType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call(
      {String emailAddress,
      String passWord,
      bool validateData,
      BiometricType? bioMetricType});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailAddress = null,
    Object? passWord = null,
    Object? validateData = null,
    Object? bioMetricType = freezed,
  }) {
    return _then(_value.copyWith(
      emailAddress: null == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String,
      passWord: null == passWord
          ? _value.passWord
          : passWord // ignore: cast_nullable_to_non_nullable
              as String,
      validateData: null == validateData
          ? _value.validateData
          : validateData // ignore: cast_nullable_to_non_nullable
              as bool,
      bioMetricType: freezed == bioMetricType
          ? _value.bioMetricType
          : bioMetricType // ignore: cast_nullable_to_non_nullable
              as BiometricType?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginStateImplCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$LoginStateImplCopyWith(
          _$LoginStateImpl value, $Res Function(_$LoginStateImpl) then) =
      __$$LoginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String emailAddress,
      String passWord,
      bool validateData,
      BiometricType? bioMetricType});
}

/// @nodoc
class __$$LoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginStateImpl>
    implements _$$LoginStateImplCopyWith<$Res> {
  __$$LoginStateImplCopyWithImpl(
      _$LoginStateImpl _value, $Res Function(_$LoginStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailAddress = null,
    Object? passWord = null,
    Object? validateData = null,
    Object? bioMetricType = freezed,
  }) {
    return _then(_$LoginStateImpl(
      emailAddress: null == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String,
      passWord: null == passWord
          ? _value.passWord
          : passWord // ignore: cast_nullable_to_non_nullable
              as String,
      validateData: null == validateData
          ? _value.validateData
          : validateData // ignore: cast_nullable_to_non_nullable
              as bool,
      bioMetricType: freezed == bioMetricType
          ? _value.bioMetricType
          : bioMetricType // ignore: cast_nullable_to_non_nullable
              as BiometricType?,
    ));
  }
}

/// @nodoc

class _$LoginStateImpl extends _LoginState {
  _$LoginStateImpl(
      {this.emailAddress = '',
      this.passWord = '',
      this.validateData = false,
      this.bioMetricType})
      : super._();

  @override
  @JsonKey()
  final String emailAddress;
  @override
  @JsonKey()
  final String passWord;
  @override
  @JsonKey()
  final bool validateData;
  @override
  final BiometricType? bioMetricType;

  @override
  String toString() {
    return 'LoginState(emailAddress: $emailAddress, passWord: $passWord, validateData: $validateData, bioMetricType: $bioMetricType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginStateImpl &&
            (identical(other.emailAddress, emailAddress) ||
                other.emailAddress == emailAddress) &&
            (identical(other.passWord, passWord) ||
                other.passWord == passWord) &&
            (identical(other.validateData, validateData) ||
                other.validateData == validateData) &&
            (identical(other.bioMetricType, bioMetricType) ||
                other.bioMetricType == bioMetricType));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, emailAddress, passWord, validateData, bioMetricType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      __$$LoginStateImplCopyWithImpl<_$LoginStateImpl>(this, _$identity);
}

abstract class _LoginState extends LoginState {
  factory _LoginState(
      {final String emailAddress,
      final String passWord,
      final bool validateData,
      final BiometricType? bioMetricType}) = _$LoginStateImpl;
  _LoginState._() : super._();

  @override
  String get emailAddress;
  @override
  String get passWord;
  @override
  bool get validateData;
  @override
  BiometricType? get bioMetricType;
  @override
  @JsonKey(ignore: true)
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
