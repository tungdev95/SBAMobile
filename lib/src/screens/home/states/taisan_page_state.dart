import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/base/base.dart';
part 'taisan_page_state.freezed.dart';

@freezed
class TaiSanPageState with _$TaiSanPageState {
  const factory TaiSanPageState({
    @Default([]) List<AssetMenuModel<SvgGenImage>> lsMenuModel,
    AssetsTypeEnum? currentType,
    @Default(FileStatus.chuaCoLichKhaoSat) FileStatus currentStatus,
    AssetsTypeEnum? currentTypeDi,
    @Default(FileStatus.choDuyet) FileStatus currentStatusDi,
  }) = _TaiSanPageState;
}
