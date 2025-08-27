import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/login/user_model.dart';
part 'auth_events.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.initial() = AppInitial;
  const factory AppState.unAuthenticate() = UnAuthenticate;
  const factory AppState.authenticated(UserModel? userModel) = Authenticated;
}
