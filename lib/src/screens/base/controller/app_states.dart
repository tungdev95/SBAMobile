import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/models/login/user_model.dart';
import 'package:equatable/equatable.dart';
part 'app_states.freezed.dart';

@freezed
class AppState extends Equatable with _$AppState {
  factory AppState({
    @Default(LanguageModel()) LanguageModel language,
    UserModel? userLogin,
  }) = _AppState;

  const AppState._();

  @override
  List<Object?> get props => [language, userLogin];
}
