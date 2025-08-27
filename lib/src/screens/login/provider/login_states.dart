import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:local_auth/local_auth.dart';
part 'login_states.freezed.dart';

@freezed
class LoginState with _$LoginState {
  LoginState._();

  factory LoginState({
    @Default('') String emailAddress,
    @Default('') String passWord,
    @Default(false) bool validateData,
    BiometricType? bioMetricType,
    // List<KeyValueModel>? lsChiNhanh,
    // KeyValueModel? selectedChiNhanh,
  }) = _LoginState;
}
