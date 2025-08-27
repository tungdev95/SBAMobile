import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/src/models/base/base.dart';
part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    String? name,
    @Default([]) List<AssetMenuModel<AssetGenImage>> listMenuData,
  }) = _HomeState;
}
