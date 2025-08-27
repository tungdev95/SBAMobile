import 'package:json_annotation/json_annotation.dart';
import 'package:sba/generated/l10n.dart';

enum ImageType {
  @JsonValue(2)
  info,
  @JsonValue(5)
  diagram,
  @JsonValue(1)
  appendix,
  @JsonValue(3)
  location,
  @JsonValue(4)
  zoning,
  @JsonValue(8)
  dinhVi
}

enum FileStatus {
  unKnown,
  @JsonValue(0)
  taoHoSoThuCong,
  @JsonValue(3)
  daBoSungHSPL,
  @JsonValue(7)
  chuaCoLichKhaoSat,
  @JsonValue(8)
  daCoLichKhaoSat,
  @JsonValue(11)
  dangKhaoSat,
  @JsonValue(12)
  hoanThanhBBKS,
  @JsonValue(14)
  choDuyet,
  @JsonValue(15)
  dangDuyet,
  @JsonValue(16)
  daDuyet,
  @JsonValue(17)
  daTuChoiDuyetVaChoDieuChinh,
  @JsonValue(19)
  daKySo,
  @JsonValue(20)
  daGuiThongBao,
  @JsonValue(-2)
  choBaoLaiLichKS,

  ///Fake item
  @JsonValue(99)
  daGuiKQThamDinh;

  String get title => switch (this) {
        taoHoSoThuCong => S.current.tao_ho_so_thu_cong,
        daBoSungHSPL => S.current.da_bo_sung_hspl,
        chuaCoLichKhaoSat => S.current.chua_co_lich_khao_sat,
        daCoLichKhaoSat => S.current.da_co_lich_ks,
        dangKhaoSat => S.current.dang_khao_sat,
        hoanThanhBBKS => S.current.hoan_thanh_bbks,
        choDuyet => S.current.cho_duyet,
        dangDuyet => S.current.dang_duyet,
        daDuyet => S.current.da_duyet,
        daTuChoiDuyetVaChoDieuChinh => S.current.da_tu_choi_va_cho_dieu_chinh,
        daKySo => S.current.da_ky_so,
        daGuiThongBao => S.current.da_gui_thong_bao,
        daGuiKQThamDinh => S.current.da_gui_kq_td,
        choBaoLaiLichKS => S.current.cho_bao_lai_lich_ks,
        _ => '',
      };

  int get id => switch (this) {
        taoHoSoThuCong => 0,
        daBoSungHSPL => 3,
        chuaCoLichKhaoSat => 7,
        daCoLichKhaoSat => 8,
        dangKhaoSat => 11,
        hoanThanhBBKS => 12,
        choDuyet => 14,
        dangDuyet => 15,
        daDuyet => 16,
        daTuChoiDuyetVaChoDieuChinh => 17,
        daKySo => 19,
        daGuiThongBao => 20,
        daGuiKQThamDinh => 20,
        choBaoLaiLichKS => -2,
        _ => 7,
      };
}

const fileStatusEnumMap = {
  FileStatus.unKnown: 'unKnown',
  FileStatus.taoHoSoThuCong: 0,
  FileStatus.daBoSungHSPL: 3,
  FileStatus.chuaCoLichKhaoSat: 7,
  FileStatus.daCoLichKhaoSat: 8,
  FileStatus.dangKhaoSat: 11,
  FileStatus.hoanThanhBBKS: 12,
  FileStatus.choDuyet: 14,
  FileStatus.dangDuyet: 15,
  FileStatus.daDuyet: 16,
  FileStatus.daTuChoiDuyetVaChoDieuChinh: 17,
  FileStatus.choBaoLaiLichKS: -2,
};

enum UtilitiesApartment {
  @JsonValue('garage')
  garage,
  @JsonValue('pool')
  pool,
  @JsonValue('innerPark')
  innerPark,
  @JsonValue('commercialServiceArea')
  commercialServiceArea,
  @JsonValue('hospitalSchoolPreschool')
  hospitalSchoolPreschool,
  @JsonValue('receptionHall')
  receptionHall,
  @JsonValue('elevator')
  elevator,
}

enum VehicleTypeEnum {
  @JsonValue(1)
  ptdb,
  @JsonValue(2)
  ptdt;

  int get id => switch (this) {
        ptdb => 1,
        ptdt => 2,
      };
}

enum AssetLevelThreeEnum {
  @JsonValue(21)
  otoCon,
  @JsonValue(22)
  otoKhach,
  @JsonValue(23)
  otoTai,
  @JsonValue(24)
  otoDauKeo,
  @JsonValue(25)
  roMooc,
  @JsonValue(26)
  xeChuyenDung,
  @JsonValue(27)
  xe2Banh,
  @JsonValue(41)
  mmtb,
  @JsonValue(42)
  dayChuyenSanXuat;

  int get id => switch (this) {
        otoCon => 21,
        otoKhach => 22,
        otoTai => 23,
        otoDauKeo => 24,
        roMooc => 25,
        xeChuyenDung => 26,
        xe2Banh => 27,
        mmtb => 41,
        dayChuyenSanXuat => 42,
      };
}
