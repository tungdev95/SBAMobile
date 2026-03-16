import 'package:json_annotation/json_annotation.dart';
import 'package:sba/gen/assets.gen.dart';

class MainMenuModel<T> {
  MenuEnum id;
  String title;
  String imageName;
  T? image;
  int notiCount;
  bool isSelect;
  MainMenuModel({
    required this.id,
    required this.title,
    required this.imageName,
    required this.notiCount,
    this.image,
    this.isSelect = false,
  });
}

class AssetMenuModel<T> {
  AssetsTypeEnum id;
  String title;
  String imageName;
  T? image;
  int notiCount;
  bool isSelect;
  AssetMenuModel({
    required this.id,
    required this.title,
    required this.imageName,
    required this.notiCount,
    this.image,
    this.isSelect = false,
  });
}

enum MenuEnum {
//   PTVT_DuongThuy
// PTVT_DuongBo
// MMTB
// CHCC
// PT_Khac
// BĐS
  TAI_SAN,
  DOAN_DUONG,
  T_TO_TRINH,
  TO_TRINH,
  CHCC,
  MMTB,
  PTVT_DuongBo,
  PTVT_DuongThuy,
  PT_Khac,
  BDS,

  taiSan,
  taoToTrinh,
  toTrinh,
  doanDuong,

  bds,
  chcc,
  duAn,
  duToan,
  ptdb,
  ptdt,
  mmtb,
  tsk,
}

enum AssetsTypeEnum {
  taiSan,
  taoToTrinh,
  toTrinh,
  doanDuong,

  @JsonValue(1)
  bds,
  @JsonValue(2)
  chcc,
  @JsonValue(8)
  duAn,
  @JsonValue(9)
  duToan,
  @JsonValue(3)
  ptdb,
  @JsonValue(4)
  ptdt,
  @JsonValue(5)
  mmtb,
  @JsonValue(7)
  hh,
  @JsonValue(6)
  tsk,

  dinhGiaNhanhBDS,

  dinhGiaNhanhCHCC,

  dinhGiaNhanhPTVT;

  int get assetsLevel2Id {
    switch (this) {
      case dinhGiaNhanhBDS:
        return 0;
      case bds:
      case dinhGiaNhanhCHCC:
        return 1;
      case chcc:
      case dinhGiaNhanhPTVT:
        return 2;
      case ptdb:
        return 3;
      case ptdt:
        return 4;
      case mmtb:
        return 5;
      case tsk:
        return 6;
      case hh:
        return 7;
      case duAn:
        return 8;
      case duToan:
        return 9;
      default:
        return 1;
    }
  }

  int get assetsLevel1Id {
    switch (this) {
      case bds:
      case chcc:
      case duAn:
      case duToan:
        return 1;
      default:
        return 2;
    }
  }

  SvgGenImage get image => switch (this) {
        bds || dinhGiaNhanhBDS => Assets.images.home.icBds,
        chcc || dinhGiaNhanhCHCC => Assets.images.home.icChcc,
        ptdb || dinhGiaNhanhPTVT => Assets.images.home.icPtdb,
        ptdt => Assets.images.home.icPtdt,
        tsk => Assets.images.home.icTskhac,
        mmtb => Assets.images.home.icMmtb,
        duAn => Assets.images.home.icDuan,
        duToan => Assets.images.home.icDutoan,
        _ => Assets.images.home.icBds,
      };
}
