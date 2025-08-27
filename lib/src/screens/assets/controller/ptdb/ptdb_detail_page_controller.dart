import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/assets/ptdb_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/utils/validator_util.dart';
import 'package:sba/src/services/providers/asset_api_provider.dart';

class PTDBPageController extends BaseAssetDetailPageController<PTDBModel> {
  PTDBPageController(super.state, super.ref);

  static final detailPageControllerProvider = StateNotifierProvider.autoDispose
      .family<PTDBPageController, AssetsDetailState<PTDBModel>,
          AssetDetailProviderElement>(
    (ref, element) {
      final controller = PTDBPageController(
        AssetsDetailState.element(element),
        ref,
      );
      return controller;
    },
  );

  @override
  bool get enableZoningImage => false;

  @override
  bool get enableUploadDinhVi => true;

  @override
  Box<AssetsDetailModel<PTDBModel>> get boxProvider =>
      ref.read(ptdbBoxProvider);

  @override
  void initDropdownList(List<AssetsDetailModel<PTDBModel>> assets) {
    final customerInfo = state.element.assetsModel?.customer;

    ExpandModel ttinTaiSan = thongTinTaiSan(state.surveyInfo!);

    ExpandModel ttinChiNhanh = thongTinChiNhanh(state.surveyInfo!);

    ExpandModel thongTinDeNghi = generateThongTinDeNghi(customerInfo);

    ExpandModel thongTinKhaoSatTaiSan = thongTinLienHeVaKhaoSatTaiSan(
        state.surveyInfo ??=
            AssetsModel(surveySchedules: [], assetType: AssetsTypeEnum.ptdb));

    ExpandModel thoiGianHenSBA = thoiGianKhaoSatSBA(
      state.surveyInfo ??=
          AssetsModel(surveySchedules: [], assetType: AssetsTypeEnum.ptdb),
    );

    Map<String, List<ExpandModel>> assetMap = {};

    for (var element in assets) {
      ExpandModel thongTinPhapLy = ExpandModel(
        key: phapLyKey,
        title: S.current.thong_tin_phap_ly,
        isExpand: false,
        child: generateLegals(element),
        lsInputField: [],
        topLsInputField: [
          InputFieldModel<String>(
            label: S.current.ghi_chu_phap_ly_sba,
            data: element.asset.noteLegalSBA,
            minLines: 4,
            maxLines: 4,
            onTextChanged: (newValue) {
              element.asset.noteLegalSBA = newValue;
            },
          )
        ],
      );

      ExpandModel dacDiemKyThuat = ExpandModel(
        key: '$phapLyThucTe-dacDiemKyThuat',
        title: S.current.dac_diem_thong_so_ky_thuat,
        isExpand: false,
        child: [
          listDacDiemKyThuatPhapLy(element),
          listDacDiemKyThuatThucTe(element)
        ],
        copyLegalToFactual: () {
          copyDacDiemPhapLySangThucTe(element);
        },
        lsInputField: [],
        topLsInputField: [],
      );

      ExpandModel thongTinKhac = generateOtherInfo(element.asset);

      ExpandModel canhBaoRuiRo = ExpandModel(
        key: cbrr,
        title: S.current.canh_bao_rui_ro,
        isExpand: false,
        child: generateListCBRR(element),
        lsInputField: [],
        topLsInputField: [],
      );

      assetMap[element.assetCode ?? ''] = [
        thongTinPhapLy,
        dacDiemKyThuat,
        thongTinKhac,
        canhBaoRuiRo,
      ];
    }

    state = state.copyWith(
      assets: assets,
      defaultInfoList: [
        ttinTaiSan,
        ttinChiNhanh,
        thongTinDeNghi,
        thongTinKhaoSatTaiSan,
        thoiGianHenSBA,
      ],
      assetInfo: assetMap,
    );
  }
// assetLevelThreeId = 27 => xe may

  @override
  String get chuSoHuuLabel => S.current.don_vi_nguoi_dung_ten;

  @override
  bool get requiredChuSoHuu => false;

  ///Thông tin đặc điểm kỹ thuật pháp lý
  ExpandModel listDacDiemKyThuatPhapLy(AssetsDetailModel<PTDBModel> element) {
    var asset = element.asset;
    var nhanHieu = InputFieldModel<String>(
      label: S.current.nhan_hieu,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: asset.legalVehicleBrand != null
          ? KeyValueModel(key: asset.legalVehicleBrand)
          : null,
      listDataProvider: (p0) =>
          p0.call(getVehicleBrandsProvider(VehicleTypeEnum.ptdb)),
      onChange: (newValue) {
        asset.legalVehicleBrand = newValue?.key;
      },
    );

    var soLoai = InputFieldModel<String>(
      label: S.current.soloai_model,
      data: asset.legalVehicleModel,
      onTextChanged: (newValue) {
        asset.legalVehicleModel = newValue;
      },
    );

    var mauSon = InputFieldModel<String>(
      label: S.current.mau_son,
      data: asset.legalColor,
      onTextChanged: (newValue) {
        asset.legalColor = newValue;
      },
    );

    var namSanXuat = InputFieldModel<int>(
      label: S.current.nam_san_xuat,
      data: asset.legalYearMfg,
      value: asset.legalYearMfg?.toString() ?? '',
      inputFormatter: [FilteringTextInputFormatter.digitsOnly],
      onTextChanged: (newValue) {
        asset.legalYearMfg = newValue;
      },
      required: false,
      validator: (p0) {
        return Validator.validateYear(p0, required: false);
      },
    );

    var nuocSanXuat = InputFieldModel<String>(
      label: S.current.nuoc_san_xuat,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: asset.legalCountryMfgId != null
          ? KeyValueModel(
              id: asset.legalCountryMfgId,
              key: asset.legalCountryMfgId.toString())
          : null,
      listDataProvider: (p0) => p0.call(getListCountryProvider),
      onChange: (newValue) {
        asset.legalCountryMfgId = newValue?.id;
      },
    );

    var hopSo = InputFieldModel<String>(
      label: S.current.hop_so,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: asset.legalGearBoxId != null
          ? KeyValueModel(id: asset.legalGearBoxId)
          : null,
      listDataProvider: (p0) => p0.call(getListGearBoxProvider),
      onChange: (newValue) {
        asset.legalGearBoxId = newValue?.id;
      },
    );

    var congThucBanhXe = InputFieldModel<String>(
      label: S.current.cong_thuc_banh,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: asset.legalWheelFormulaId != null
          ? KeyValueModel(id: asset.legalWheelFormulaId)
          : null,
      listDataProvider: (p0) => p0.call(getListWheelFomulaProvider),
      onChange: (newValue) {
        asset.legalWheelFormulaId = newValue?.id;
      },
    );

    var loaiNhienLieu = InputFieldModel<String>(
      label: S.current.loai_nhien_lieu,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: asset.legalFuelId != null
          ? KeyValueModel(id: asset.legalFuelId)
          : null,
      listDataProvider: (p0) => p0.call(getListFuelsProvider),
      onChange: (newValue) {
        asset.legalFuelId = newValue?.id;
      },
    );

    var soKhung = InputFieldModel<String>(
      label: S.current.so_khung,
      data: asset.legalVehicleIdNumber,
      onTextChanged: (newValue) {
        asset.legalVehicleIdNumber = newValue;
      },
    );

    var soMay = InputFieldModel<String>(
      label: S.current.so_may,
      data: asset.legalEngineNumber,
      onTextChanged: (newValue) {
        asset.legalEngineNumber = newValue;
      },
    );

    var bks = InputFieldModel<String>(
      label: S.current.bien_kiem_soat,
      data: asset.legalPlateNumber,
      onTextChanged: (newValue) {
        asset.legalPlateNumber = newValue;
      },
    );

    var kichThuocBao = InputFieldModel<String>(
      label: S.current.kich_thuoc_bao,
      data: asset.legalOverallDims,
      onTextChanged: (newValue) {
        asset.legalOverallDims = newValue;
      },
    );

    var khoiLuongBanThan = InputFieldModel<double>(
      label: S.current.khoi_luong_ban_than,
      data: asset.legalWeightBase,
      onTextChanged: (newValue) {
        asset.legalWeightBase = newValue;
      },
    );

    var khoiLuongToanBo = InputFieldModel<String>(
      label: S.current.khoi_luong_toan_bo,
      data: asset.legalWeightAll,
      onTextChanged: (newValue) {
        asset.legalWeightAll = newValue;
      },
    );

    var chieuDaiCoSo = InputFieldModel<String>(
      label: S.current.chieu_dai_co_so,
      data: asset.legalWheelBase,
      onTextChanged: (newValue) {
        asset.legalWheelBase = newValue;
      },
    );

    var soNguoiChoPhepCho = InputFieldModel<String>(
      label: S.current.so_nguoi_cho_phep_cho,
      data: asset.legalPersonCarry,
      onTextChanged: (newValue) {
        asset.legalPersonCarry = newValue;
      },
    );

    var theTichLamViec = InputFieldModel<double>(
      label: S.current.the_tich_lam_viec_cua_dong_co,
      data: asset.legalEngineDisp,
      onTextChanged: (newValue) {
        asset.legalEngineDisp = newValue;
      },
    );

    var congSuatLonNhat = InputFieldModel<String>(
      label: S.current.cong_suat_lon_nhat,
      data: asset.legalMaxOutputRpm,
      onTextChanged: (newValue) {
        asset.legalMaxOutputRpm = newValue;
      },
    );

    var soLuongLop = InputFieldModel<String>(
      label: S.current.so_luong_lop,
      data: asset.legalNumberOfTires,
      onTextChanged: (newValue) {
        asset.legalNumberOfTires = newValue;
      },
    );

    var kichThuocLongThungXe = InputFieldModel<String>(
      label: S.current.kich_thuoc_long_thung_xe,
      data: asset.legalVehicleTrunkSize,
      onTextChanged: (newValue) {
        asset.legalVehicleTrunkSize = newValue;
      },
    );

    var khoiLuongHang = InputFieldModel<String>(
      label: S.current.khoi_luong_hang_chuyen_cho,
      data: asset.legalVolumeOfGoodsTransported,
      onTextChanged: (newValue) {
        asset.legalVolumeOfGoodsTransported = newValue;
      },
    );

    var khoiLuongHangChuyenKeo = InputFieldModel<String>(
      label: S.current.khoi_luong_hang_chuyen_keo_theo,
      data: asset.legalVolumeOfTowedGoods,
      onTextChanged: (newValue) {
        asset.legalVolumeOfTowedGoods = newValue;
      },
    );

    var dungTichBon = InputFieldModel<String>(
      label: S.current.dung_tich_bon,
      data: asset.legalTankCapacity,
      onTextChanged: (newValue) {
        asset.legalTankCapacity = newValue;
      },
    );

    var congSuatW = InputFieldModel<String>(
      label: S.current.cong_suat_w,
      data: asset.legalMaxOutputRpm,
      onTextChanged: (newValue) {
        asset.legalMaxOutputRpm = newValue;
      },
    );

    var dungTichCC = InputFieldModel<double>(
      label: S.current.dung_tich_cc,
      data: asset.legalEngineDisp,
      onTextChanged: (newValue) {
        asset.legalEngineDisp = newValue;
      },
    );

    var noiDungKhac = InputFieldModel<String>(
      label: S.current.noi_dung_khac,
      data: asset.legalAdditionalContent,
      minLines: 4,
      maxLines: 4,
      onTextChanged: (newValue) => asset.legalAdditionalContent = newValue,
    );

    var lsInputXe2Banh = [
      nhanHieu,
      soLoai,
      mauSon,
      namSanXuat,
      nuocSanXuat,
      loaiNhienLieu,
      soKhung,
      soMay,
      bks,
      soNguoiChoPhepCho,
      congSuatW,
      dungTichCC
    ];

    var lsInputXeOto = [
      nhanHieu,
      soLoai,
      mauSon,
      namSanXuat,
      nuocSanXuat,
      hopSo,
      congThucBanhXe,
      loaiNhienLieu,
      soKhung,
      soMay,
      bks,
      kichThuocBao,
      khoiLuongBanThan,
      khoiLuongToanBo,
      chieuDaiCoSo,
      soNguoiChoPhepCho,
      theTichLamViec,
      congSuatLonNhat,
      soLuongLop,
    ];

    var lsInputXeTai = [
      nhanHieu,
      soLoai,
      mauSon,
      namSanXuat,
      nuocSanXuat,
      hopSo,
      congThucBanhXe,
      loaiNhienLieu,
      soKhung,
      soMay,
      bks,
      kichThuocBao,
      khoiLuongBanThan,
      khoiLuongToanBo,
      chieuDaiCoSo,
      soNguoiChoPhepCho,
      theTichLamViec,
      congSuatLonNhat,
      soLuongLop,
      kichThuocLongThungXe,
      khoiLuongHang,
      khoiLuongHangChuyenKeo,
      dungTichBon
    ];

    var lsInput = <InputFieldModel>[];

    var assetLevelThreeId = element.assetLevelThreeId ??
        state.surveyInfo?.assetCommons
            ?.firstWhereOrNull((child) => child.assetCode == element.assetCode)
            ?.assetLevelThreeId ??
        asset.type;
    if (assetLevelThreeId == AssetLevelThreeEnum.xe2Banh.id) {
      lsInput = lsInputXe2Banh;
    } else if (assetLevelThreeId == AssetLevelThreeEnum.otoCon.id ||
        assetLevelThreeId == AssetLevelThreeEnum.otoKhach.id) {
      lsInput = lsInputXeOto;
    } else {
      lsInput = lsInputXeTai;
    }

    return ExpandModel(
      title: 'title',
      isExpand: false,
      child: [],
      lsInputField: lsInput..add(noiDungKhac),
      topLsInputField: [],
    );
  }

  ///Thông tin đặc điểm kỹ thuật thực tế
  ExpandModel listDacDiemKyThuatThucTe(AssetsDetailModel<PTDBModel> element) {
    var asset = element.asset;
    var nhanHieu = InputFieldModel<String>(
      label: S.current.nhan_hieu,
      inputFieldType: InputFieldType.dropDown,
      required: true,
      selectedValue: asset.realVehicleBrand != null
          ? KeyValueModel(key: asset.realVehicleBrand)
          : null,
      listDataProvider: (p0) =>
          p0.call(getVehicleBrandsProvider(VehicleTypeEnum.ptdb)),
      onChange: (newValue) {
        asset.realVehicleBrand = newValue?.key;
      },
    );

    var soLoai = InputFieldModel<String>(
      label: S.current.soloai_model,
      data: asset.realVehicleModel,
      required: true,
      onTextChanged: (newValue) {
        asset.realVehicleModel = newValue;
      },
    );

    var mauSon = InputFieldModel<String>(
      label: S.current.mau_son,
      data: asset.realColor,
      required: true,
      onTextChanged: (newValue) {
        asset.realColor = newValue;
      },
    );

    var namSanXuat = InputFieldModel<int>(
      label: S.current.nam_san_xuat,
      value: asset.realYearMfg?.toString() ?? '',
      data: asset.realYearMfg,
      required: true,
      inputFormatter: [FilteringTextInputFormatter.digitsOnly],
      onTextChanged: (newValue) {
        asset.realYearMfg = newValue;
      },
      validator: Validator.validateYear,
    );

    var nuocSanXuat = InputFieldModel<String>(
      label: S.current.nuoc_san_xuat,
      inputFieldType: InputFieldType.dropDown,
      required: true,
      selectedValue: asset.realCountryMfgId != null
          ? KeyValueModel(
              id: asset.realCountryMfgId,
              key: asset.realCountryMfgId.toString())
          : null,
      listDataProvider: (p0) => p0.call(getListCountryProvider),
      onChange: (newValue) {
        asset.realCountryMfgId = newValue?.id;
      },
    );

    var hopSo = InputFieldModel<String>(
      label: S.current.hop_so,
      inputFieldType: InputFieldType.dropDown,
      required: true,
      selectedValue: asset.realGearBoxId != null
          ? KeyValueModel(id: asset.realGearBoxId)
          : null,
      listDataProvider: (p0) => p0.call(getListGearBoxProvider),
      onChange: (newValue) {
        asset.realGearBoxId = newValue?.id;
      },
    );

    var congThucBanhXe = InputFieldModel<String>(
      label: S.current.cong_thuc_banh,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: asset.realWheelFormulaId != null
          ? KeyValueModel(id: asset.realWheelFormulaId)
          : null,
      listDataProvider: (p0) => p0.call(getListWheelFomulaProvider),
      onChange: (newValue) {
        asset.realWheelFormulaId = newValue?.id;
      },
    );

    var loaiNhienLieu = InputFieldModel<String>(
      label: S.current.loai_nhien_lieu,
      inputFieldType: InputFieldType.dropDown,
      required: true,
      selectedValue:
          asset.realFuelId != null ? KeyValueModel(id: asset.realFuelId) : null,
      listDataProvider: (p0) => p0.call(getListFuelsProvider),
      onChange: (newValue) {
        asset.realFuelId = newValue?.id;
      },
    );

    var soKhung = InputFieldModel<String>(
      label: S.current.so_khung,
      data: asset.realVehicleIdNumber,
      required: true,
      onTextChanged: (newValue) {
        asset.realVehicleIdNumber = newValue;
      },
    );

    var soMay = InputFieldModel<String>(
      label: S.current.so_may,
      data: asset.realEngineNumber,
      required: true,
      onTextChanged: (newValue) {
        asset.realEngineNumber = newValue;
      },
    );

    var bks = InputFieldModel<String>(
      label: S.current.bien_kiem_soat,
      data: asset.realPlateNumber,
      onTextChanged: (newValue) {
        asset.realPlateNumber = newValue;
      },
    );

    var kichThuocBao = InputFieldModel<String>(
      label: S.current.kich_thuoc_bao,
      data: asset.realOverallDims,
      onTextChanged: (newValue) {
        asset.realOverallDims = newValue;
      },
    );

    var khoiLuongBanThan = InputFieldModel<double>(
      label: S.current.khoi_luong_ban_than,
      data: asset.realWeightBase,
      onTextChanged: (newValue) {
        asset.realWeightBase = newValue;
      },
    );

    var khoiLuongToanBo = InputFieldModel<String>(
      label: S.current.khoi_luong_toan_bo,
      data: asset.realWeightAll,
      onTextChanged: (newValue) {
        asset.realWeightAll = newValue;
      },
    );

    var chieuDaiCoSo = InputFieldModel<String>(
      label: S.current.chieu_dai_co_so,
      data: asset.realWheelBase,
      onTextChanged: (newValue) {
        asset.realWheelBase = newValue;
      },
    );

    var soNguoiChoPhepCho = InputFieldModel<String>(
      label: S.current.so_nguoi_cho_phep_cho,
      data: asset.realPersonCarry,
      onTextChanged: (newValue) {
        asset.realPersonCarry = newValue;
      },
    );

    var theTichLamViec = InputFieldModel<double>(
      label: S.current.the_tich_lam_viec_cua_dong_co,
      data: asset.realEngineDisp,
      onTextChanged: (newValue) {
        asset.realEngineDisp = newValue;
      },
    );

    var congSuatLonNhat = InputFieldModel<String>(
      label: S.current.cong_suat_lon_nhat,
      data: asset.realMaxOutputRpm,
      onTextChanged: (newValue) {
        asset.realMaxOutputRpm = newValue;
      },
    );

    var soLuongLop = InputFieldModel<String>(
      label: S.current.so_luong_lop,
      data: asset.realNumberOfTires,
      onTextChanged: (newValue) {
        asset.realNumberOfTires = newValue;
      },
    );

    var kichThuocLongThungXe = InputFieldModel<String>(
      label: S.current.kich_thuoc_long_thung_xe,
      data: asset.realVehicleTrunkSize,
      onTextChanged: (newValue) {
        asset.realVehicleTrunkSize = newValue;
      },
    );

    var khoiLuongHang = InputFieldModel<String>(
      label: S.current.khoi_luong_hang_chuyen_cho,
      data: asset.realVolumeOfGoodsTransported,
      onTextChanged: (newValue) {
        asset.realVolumeOfGoodsTransported = newValue;
      },
    );

    var khoiLuongHangChuyenKeo = InputFieldModel<String>(
      label: S.current.khoi_luong_hang_chuyen_keo_theo,
      data: asset.realVolumeOfTowedGoods,
      onTextChanged: (newValue) {
        asset.realVolumeOfTowedGoods = newValue;
      },
    );

    var dungTichBon = InputFieldModel<String>(
      label: S.current.dung_tich_bon,
      data: asset.realTankCapacity,
      onTextChanged: (newValue) {
        asset.realTankCapacity = newValue;
      },
    );

    var congSuatW = InputFieldModel<String>(
      label: S.current.cong_suat_w,
      data: asset.realMaxOutputRpm,
      onTextChanged: (newValue) {
        asset.realMaxOutputRpm = newValue;
      },
    );

    var dungTichCC = InputFieldModel<double>(
      label: S.current.dung_tich_cc,
      data: asset.realEngineDisp,
      onTextChanged: (newValue) {
        asset.realEngineDisp = newValue;
      },
    );

    var noiDungKhac = InputFieldModel<String>(
      label: S.current.noi_dung_khac,
      data: asset.realAdditionalContent,
      minLines: 4,
      maxLines: 4,
      onTextChanged: (newValue) => asset.realAdditionalContent = newValue,
    );

    var lsInputXe2Banh = [
      nhanHieu,
      soLoai,
      mauSon,
      namSanXuat,
      nuocSanXuat,
      loaiNhienLieu,
      soKhung,
      soMay,
      bks,
      soNguoiChoPhepCho,
      congSuatW,
      dungTichCC
    ];

    var lsInputXeOto = [
      nhanHieu,
      soLoai,
      mauSon,
      namSanXuat,
      nuocSanXuat,
      hopSo,
      congThucBanhXe,
      loaiNhienLieu,
      soKhung,
      soMay,
      bks,
      kichThuocBao,
      khoiLuongBanThan,
      khoiLuongToanBo,
      chieuDaiCoSo,
      soNguoiChoPhepCho,
      theTichLamViec,
      congSuatLonNhat,
      soLuongLop,
    ];

    var lsInputXeTai = [
      nhanHieu,
      soLoai,
      mauSon,
      namSanXuat,
      nuocSanXuat,
      hopSo,
      congThucBanhXe,
      loaiNhienLieu,
      soKhung,
      soMay,
      bks,
      kichThuocBao,
      khoiLuongBanThan,
      khoiLuongToanBo,
      chieuDaiCoSo,
      soNguoiChoPhepCho,
      theTichLamViec,
      congSuatLonNhat,
      soLuongLop,
      kichThuocLongThungXe,
      khoiLuongHang,
      khoiLuongHangChuyenKeo,
      dungTichBon,
    ];

    var lsInput = <InputFieldModel>[];

    var assetLevelThreeId = element.assetLevelThreeId ??
        state.surveyInfo?.assetCommons
            ?.firstWhereOrNull((child) => child.assetCode == element.assetCode)
            ?.assetLevelThreeId ??
        asset.type;

    if (assetLevelThreeId == AssetLevelThreeEnum.xe2Banh.id) {
      lsInput = lsInputXe2Banh;
    } else if (assetLevelThreeId == AssetLevelThreeEnum.otoCon.id ||
        assetLevelThreeId == AssetLevelThreeEnum.otoKhach.id) {
      lsInput = lsInputXeOto;
    } else {
      lsInput = lsInputXeTai;
    }

    return ExpandModel(
        title: 'title',
        isExpand: false,
        child: [],
        lsInputField: lsInput..add(noiDungKhac),
        topLsInputField: []);
  }

  void copyDacDiemPhapLySangThucTe(AssetsDetailModel<PTDBModel> element) {
    final asset = element.asset;
    asset
      ..realVehicleBrand = asset.legalVehicleBrand
      ..realVehicleModel = asset.legalVehicleModel
      ..realColor = asset.legalColor
      ..realYearMfg = asset.legalYearMfg
      ..realCountryMfgId = asset.legalCountryMfgId
      ..realGearBoxId = asset.legalGearBoxId
      ..realWheelFormulaId = asset.legalWheelFormulaId
      ..realFuelId = asset.legalFuelId
      ..realVehicleIdNumber = asset.legalVehicleIdNumber
      ..realEngineNumber = asset.legalEngineNumber
      ..realPlateNumber = asset.legalPlateNumber
      ..realOverallDims = asset.legalOverallDims
      ..realWeightBase = asset.legalWeightBase
      ..realWeightAll = asset.legalWeightAll
      ..realWheelBase = asset.legalWheelBase
      ..realPersonCarry = asset.legalPersonCarry
      ..realEngineDisp = asset.legalEngineDisp
      ..realMaxOutputRpm = asset.legalMaxOutputRpm
      ..realNumberOfTires = asset.legalNumberOfTires
      ..realVehicleTrunkSize = asset.legalVehicleTrunkSize
      ..realVolumeOfGoodsTransported = asset.legalVolumeOfGoodsTransported
      ..realVolumeOfTowedGoods = asset.legalVolumeOfTowedGoods
      ..realTankCapacity = asset.legalTankCapacity;

    final lsExpand = state.assetInfo[element.assetCode] ?? [];
    final dacDiemIndex = lsExpand.indexWhere(
      (element) => element.key?.contains('-dacDiemKyThuat') == true,
    );
    final dacDiemKyThuat = lsExpand[dacDiemIndex];
    dacDiemKyThuat.child[1] = listDacDiemKyThuatThucTe(element);
    state = state.copyWith();
  }

  @override
  ExpandModel generateOtherInfo(PTDBModel item) {
    final nguonGoc = InputFieldModel<String>(
      label: S.current.nguon_goc,
      data: item.usingOrigin,
      onTextChanged: (newValue) => item.usingOrigin = newValue,
    );

    final hienTrangSuDung = InputFieldModel<String>(
      label: S.current.hien_trang_su_dung,
      value: item.currentUseSituation,
      onTextChanged: (newValue) => item.currentUseSituation = newValue,
    );

    final khaMaiTinhThanhKhoan = InputFieldModel<String>(
      label: S.current.kha_mai_tinh_thanh_khoan,
      inputFieldType: InputFieldType.dropDown,
      lsDropDown: tinhThanhKhoan,
      selectedValue: item.liquidity == null
          ? null
          : tinhThanhKhoan
              .firstWhereOrNull((element) => item.liquidity == element.key),
      onChange: (newValue) => item.liquidity = newValue?.key,
    );

    final chatLuongConLai = InputFieldModel<double>(
      label: S.current.chat_luong_con_lai,
      data: item.remainQuality,
      onTextChanged: (newText) => item.remainQuality = newText,
      validator: Validator.validatePercent,
      required: false,
    );

    final thongTinTranhChap = InputFieldModel<String>(
      label: S.current.thong_tin_tranh_chap,
      inputFieldType: InputFieldType.dropDown,
      lsDropDown: tTinTranhChap,
      selectedValue: item.disputeInfor == null
          ? null
          : tTinTranhChap
              .firstWhereOrNull((element) => item.disputeInfor == element.key),
      onChange: (newValue) => item.disputeInfor = newValue?.key,
    );

    final soKMDaSuDung = InputFieldModel<double>(
      label: S.current.so_km_da_qua_su_dung,
      data: item.numberOfKilometersUsed,
      onTextChanged: (newValue) => item.numberOfKilometersUsed = newValue,
    );

    final ghiChu = InputFieldModel<String>(
      label: S.current.ghi_chu,
      value: item.note,
      maxLength: 4000,
      onTextChanged: (newValue) => item.note = newValue,
    );

    return ExpandModel(
      title: S.current.thong_tin_khac,
      isExpand: false,
      child: [],
      topLsInputField: [],
      lsInputField: [
        nguonGoc,
        hienTrangSuDung,
        khaMaiTinhThanhKhoan,
        chatLuongConLai,
        thongTinTranhChap,
        soKMDaSuDung,
        ghiChu,
      ],
    );
  }

  @override
  bool visibleDiaChiTaiSanInGroupThongTin = true;
}
