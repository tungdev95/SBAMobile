import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/models/login/user_model.dart';
part 'app_states.freezed.dart';

@freezed
class AppState with _$AppState {
  factory AppState({
    @Default(LanguageModel()) LanguageModel language,
    UserModel? userLogin,
  }) = _AppState;
}
