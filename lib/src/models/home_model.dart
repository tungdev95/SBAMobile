import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sba/src/models/base/home_menu_model.dart';

part 'home_model.freezed.dart';

@Freezed(toJson: false, fromJson: false)
@freezed
class HomeData with _$HomeData {
  factory HomeData({
    // @Default("") String userName,
    // @Default("") String id,
    @Default(false) bool isFavorite,
    @Default([]) List<HomeMenuModel> tabListData,
  }) = _HomeData;

  // factory HomeData.fromJson(Map<String, Object?> json) =>
  //     _$HomeDataFromJson(json);
}
