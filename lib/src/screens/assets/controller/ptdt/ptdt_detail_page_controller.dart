import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/assets/ptdt_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/utils/validator_util.dart';
import '../../../../services/providers/asset_api_provider.dart';

class PTDTPageController extends BaseAssetDetailPageController<PTDTModel> {
  PTDTPageController(super.state, super.ref);

  static final detailPageControllerProvider = StateNotifierProvider.autoDispose
      .family<PTDTPageController, AssetsDetailState<PTDTModel>,
          AssetDetailProviderElement>(
    (ref, element) {
      final controller = PTDTPageController(
        AssetsDetailState.element(element),
        ref,
      );
      return controller;
    },
  );

  int vietNamCountryId = 232;

  @override
  bool get enableZoningImage => false;

  @override
  bool get enableUploadDinhVi => true;

  @override
  Box<AssetsDetailModel<PTDTModel>> get boxProvider =>
      ref.read(ptdtBoxProvider);

  @override
  void initDropdownList(List<AssetsDetailModel<PTDTModel>> assets) {
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

    for (AssetsDetailModel<PTDTModel> element in assets) {
      var assetLevelThreeId = element.assetLevelThreeId ??
          state.surveyInfo?.assetCommons?.firstOrNull?.assetLevelThreeId;
      if (assetLevelThreeId != null) {
        element.asset.realShipType ??= '$assetLevelThreeId';
        element.asset.legalShipType ??= '$assetLevelThreeId';
      }

      ExpandModel thongTinPhapLy = ExpandModel(
        key: phapLyKey,
        title: S.current.thong_tin_phap_ly,
        isExpand: false,
        child: generateLegals(element),
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
        lsInputField: [],
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

  @override
  String get chuSoHuuLabel => S.current.don_vi_nguoi_dung_ten;

  @override
  bool get requiredChuSoHuu => false;

  ///Thông tin đặc điểm kỹ thuật pháp lý
  ExpandModel listDacDiemKyThuatPhapLy(AssetsDetailModel<PTDTModel> element) {
    var asset = element.asset;
    var tenPhuongTien = InputFieldModel<String>(
      label: S.current.ten_phuong_tien,
      data: asset.legalName,
      onTextChanged: (newValue) {
        asset.legalName = newValue;
      },
    );

    var soDangKy = InputFieldModel<String>(
      label: S.current.so_dang_ky,
      data: asset.legalRegisterNumber,
      onTextChanged: (newValue) {
        asset.legalRegisterNumber = newValue;
      },
    );

    var soLoai = InputFieldModel<String>(
      label: S.current.soloai_model,
      data: asset.legalModel,
      onTextChanged: (newValue) {
        asset.legalModel = newValue;
      },
    );

    var soNhanDangTau = InputFieldModel<String>(
      label: S.current.so_nhan_dang_tau,
      data: asset.legalImoNumber,
      onTextChanged: (newValue) {
        asset.legalImoNumber = newValue;
      },
    );

    var nhanHieu = InputFieldModel<String>(
      label: S.current.nhan_hieu,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: asset.legalBrand != null
          ? KeyValueModel(key: asset.legalBrand)
          : null,
      listDataProvider: (p0) =>
          p0.call(getVehicleBrandsProvider(VehicleTypeEnum.ptdt)),
      onChange: (newValue) {
        asset.legalBrand = newValue?.key;
      },
    );

    var namSanXuat = InputFieldModel<int>(
      label: S.current.nam_san_xuat,
      data: asset.legalYearMfg,
      inputFormatter: [FilteringTextInputFormatter.digitsOnly],
      value: asset.legalYearMfg?.toString() ?? '',
      onTextChanged: (newValue) {
        asset.legalYearMfg = newValue;
      },
      validator: (p0) {
        return Validator.validateYear(p0, required: false);
      },
    );

    var namHoanCai = InputFieldModel<int>(
      label: S.current.nam_hoan_cai,
      data: asset.legalYearReconstructed,
      inputFormatter: [FilteringTextInputFormatter.digitsOnly],
      value: asset.legalYearReconstructed?.toString() ?? '',
      onTextChanged: (newValue) {
        asset.legalYearReconstructed = newValue;
      },
      validator: (p0) {
        return Validator.validateYear(p0, required: false);
      },
    );

    var noiDongTau = InputFieldModel<String>(
      label: S.current.noi_dong_tau,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: asset.legalManufacturingLocation != null
          ? KeyValueModel(
              key: asset.legalManufacturingLocation.toString(),
            )
          : null,
      listDataProvider: (p0) => p0.call(getListProvinceProvider),
      onChange: (newValue) {
        asset.legalManufacturingLocation = newValue?.key;
      },
      enable: asset.legalCountryMfg == vietNamCountryId,
    );

    var nuocSanXuat = InputFieldModel<String>(
      label: S.current.nuoc_san_xuat,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: asset.legalCountryMfg != null
          ? KeyValueModel(
              id: asset.legalCountryMfg,
            )
          : null,
      listDataProvider: (p0) => p0.call(getListCountryProvider),
      onChange: (newValue) {
        asset.legalCountryMfg = newValue?.id;
        if (newValue?.id != vietNamCountryId) {
          asset.legalManufacturingLocation = null;
          noiDongTau
            ..enable = false
            ..setRequire(false)
            ..selectedValue = null
            ..updateText?.call('');
          state = state.copyWith();
        } else {
          noiDongTau.enable = true;
          state = state.copyWith();
        }
      },
    );

    var hangDongTau = InputFieldModel<String>(
      label: S.current.hang_dong_tau,
      data: asset.legalShipbuildingBrand,
      onTextChanged: (newValue) {
        asset.legalShipbuildingBrand = newValue;
      },
    );

    var quocGiaDangKy = InputFieldModel<String>(
      label: S.current.quoc_gia_dang_ky,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: asset.legalRegisterCountry != null
          ? KeyValueModel(
              id: asset.legalRegisterCountry,
              key: asset.legalRegisterCountry.toString())
          : null,
      listDataProvider: (p0) => p0.call(getListCountryProvider),
      onChange: (newValue) {
        asset.legalRegisterCountry = newValue?.id;
      },
    );

    var congNangSuDung = InputFieldModel<String>(
      label: S.current.cong_nang_su_dung,
      data: asset.legalShipUtilities,
      onTextChanged: (newValue) {
        asset.legalShipUtilities = newValue;
      },
    );

    var soLuongNguoiDuocPhepCho = InputFieldModel<String>(
      label: S.current.so_luong_nguoi_duoc_phep_cho,
      data: asset.legalPersonCarry,
      onTextChanged: (newValue) {
        asset.legalPersonCarry = newValue;
      },
    );

    var chieuDaiThietKe = InputFieldModel<double>(
      label: S.current.chieu_dai_thiet_ke,
      data: asset.legalDesignLength,
      onTextChanged: (newValue) {
        asset.legalDesignLength = newValue;
      },
    );

    var chieuRongThietKe = InputFieldModel<double>(
      label: S.current.chieu_rong_thiet_ke,
      data: asset.legalDesignWidth,
      onTextChanged: (newValue) {
        asset.legalDesignWidth = newValue;
      },
    );

    var chieuDaiLonNhat = InputFieldModel<double>(
      label: S.current.chieu_dai_lon_nhat,
      data: asset.legalMaxLength,
      onTextChanged: (newValue) {
        asset.legalMaxLength = newValue;
      },
    );

    var chieuCaoMan = InputFieldModel<double>(
      label: S.current.chieu_cao_man,
      data: asset.legalBoardHeight,
      onTextChanged: (newValue) {
        asset.legalBoardHeight = newValue;
      },
    );

    var chieuChim = InputFieldModel<double>(
      label: S.current.chieu_chim,
      data: asset.legalSink,
      onTextChanged: (newValue) {
        asset.legalSink = newValue;
      },
    );

    var manKho = InputFieldModel<double>(
      label: S.current.man_kho,
      data: asset.legalFreeBoard,
      onTextChanged: (newValue) {
        asset.legalFreeBoard = newValue;
      },
    );

    var soLuongMayChinh = InputFieldModel<int>(
      label: S.current.so_luong_may_chinh,
      data: asset.legalMachineNum,
      onTextChanged: (newValue) {
        asset.legalMachineNum = newValue;
      },
    );

    var congSuatMayChinh = InputFieldModel<double>(
      label: S.current.cong_suat_may_chinh,
      data: asset.legalMachinePower,
      onTextChanged: (newValue) {
        asset.legalMachinePower = newValue;
      },
    );

    var trongTaiToanPhan = InputFieldModel<double>(
      label: S.current.trong_tai_toan_phan,
      data: asset.legalDeadWeight,
      onTextChanged: (newValue) {
        asset.legalDeadWeight = newValue;
      },
    );

    var tongDungTich = InputFieldModel<double>(
      label: S.current.tong_dung_tich,
      data: asset.legalGrossTonnage,
      onTextChanged: (newValue) {
        asset.legalGrossTonnage = newValue;
      },
    );

    var dungTichThucDung = InputFieldModel<double>(
      label: S.current.dung_tich_thuc_dung,
      data: asset.legalUseTonnage,
      onTextChanged: (newValue) {
        asset.legalUseTonnage = newValue;
      },
    );

    var tocDoTau = InputFieldModel<double>(
      label: S.current.toc_do_tau,
      data: asset.legalSpeed,
      onTextChanged: (newValue) {
        asset.legalSpeed = newValue;
      },
    );

    var noiDungKhac = InputFieldModel<String>(
      label: S.current.noi_dung_khac,
      data: asset.legalAdditionalContent,
      minLines: 4,
      maxLines: 4,
      onTextChanged: (newValue) {
        asset.legalAdditionalContent = newValue;
      },
    );

    return ExpandModel(
        title: 'title',
        isExpand: false,
        child: [],
        lsInputField: [
          tenPhuongTien,
          soDangKy,
          soLoai,
          soNhanDangTau,
          nhanHieu,
          namSanXuat,
          namHoanCai,
          nuocSanXuat,
          noiDongTau,
          hangDongTau,
          quocGiaDangKy,
          congNangSuDung,
          soLuongNguoiDuocPhepCho,
          chieuDaiThietKe,
          chieuRongThietKe,
          chieuDaiLonNhat,
          chieuCaoMan,
          chieuChim,
          manKho,
          soLuongMayChinh,
          congSuatMayChinh,
          trongTaiToanPhan,
          tongDungTich,
          dungTichThucDung,
          tocDoTau,
          noiDungKhac,
        ],
        topLsInputField: []);
  }

  ///Thông tin đặc điểm kỹ thuật thực tế
  ExpandModel listDacDiemKyThuatThucTe(AssetsDetailModel<PTDTModel> element) {
    var asset = element.asset;
    var tenPhuongTien = InputFieldModel<String>(
      label: S.current.ten_phuong_tien,
      required: true,
      data: asset.realName,
      onTextChanged: (newValue) {
        asset.realName = newValue;
      },
    );

    var soDangKy = InputFieldModel<String>(
      label: S.current.so_dang_ky,
      required: true,
      data: asset.realRegisterNumber,
      onTextChanged: (newValue) {
        asset.realRegisterNumber = newValue;
      },
    );

    var soLoai = InputFieldModel<String>(
      label: S.current.soloai_model,
      required: true,
      data: asset.realModel,
      onTextChanged: (newValue) {
        asset.realModel = newValue;
      },
    );

    var soNhanDangTau = InputFieldModel<String>(
      label: S.current.so_nhan_dang_tau,
      required: true,
      data: asset.realImoNumber,
      onTextChanged: (newValue) {
        asset.realImoNumber = newValue;
      },
    );

    var nhanHieu = InputFieldModel<String>(
      label: S.current.nhan_hieu,
      inputFieldType: InputFieldType.dropDown,
      selectedValue:
          asset.realBrand != null ? KeyValueModel(key: asset.realBrand) : null,
      listDataProvider: (p0) =>
          p0.call(getVehicleBrandsProvider(VehicleTypeEnum.ptdt)),
      onChange: (newValue) {
        asset.realBrand = newValue?.key;
      },
    );

    var namSanXuat = InputFieldModel<int>(
      label: S.current.nam_san_xuat,
      required: true,
      inputFormatter: [FilteringTextInputFormatter.digitsOnly],
      value: asset.realYearMfg?.toString() ?? '',
      data: asset.realYearMfg,
      onTextChanged: (newValue) {
        asset.realYearMfg = newValue;
      },
      validator: Validator.validateYear,
    );

    var namHoanCai = InputFieldModel<int>(
      label: S.current.nam_hoan_cai,
      data: asset.realYearReconstructed,
      inputFormatter: [FilteringTextInputFormatter.digitsOnly],
      value: asset.realYearReconstructed?.toString() ?? '',
      onTextChanged: (newValue) {
        asset.realYearReconstructed = newValue;
      },
      validator: (p0) {
        return Validator.validateYear(p0, required: false);
      },
    );

    var noiDongTau = InputFieldModel<String>(
      label: S.current.noi_dong_tau,
      required: asset.realCountryMfg == vietNamCountryId,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: asset.realManufacturingLocation != null
          ? KeyValueModel(key: asset.realManufacturingLocation.toString())
          : null,
      listDataProvider: (p0) => p0.call(getListProvinceProvider),
      onChange: (newValue) {
        asset.realManufacturingLocation = newValue?.key;
      },
      enable: asset.realCountryMfg == vietNamCountryId,
    );

    var nuocSanXuat = InputFieldModel<String>(
      label: S.current.nuoc_san_xuat,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: asset.realCountryMfg != null
          ? KeyValueModel(id: asset.realCountryMfg)
          : null,
      required: true,
      listDataProvider: (p0) => p0.call(getListCountryProvider),
      onChange: (newValue) {
        asset.realCountryMfg = newValue?.id;
        if (newValue?.id != vietNamCountryId) {
          asset.realManufacturingLocation = null;
          noiDongTau
            ..enable = false
            ..selectedValue = null
            ..setRequire(false)
            ..updateText?.call('');
          state = state.copyWith();
        } else {
          noiDongTau
            ..enable = true
            ..setRequire(true);
          state = state.copyWith();
        }
      },
    );

    var hangDongTau = InputFieldModel<String>(
      label: S.current.hang_dong_tau,
      data: asset.realShipbuildingBrand,
      required: true,
      onTextChanged: (newValue) {
        asset.realShipbuildingBrand = newValue;
      },
    );

    var quocGiaDangKy = InputFieldModel<String>(
      label: S.current.quoc_gia_dang_ky,
      required: true,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: asset.realRegisterCountry != null
          ? KeyValueModel(
              id: asset.realRegisterCountry,
              key: asset.realRegisterCountry.toString())
          : null,
      listDataProvider: (p0) => p0.call(getListCountryProvider),
      onChange: (newValue) {
        asset.realRegisterCountry = newValue?.id;
      },
    );

    var congNangSuDung = InputFieldModel<String>(
      label: S.current.cong_nang_su_dung,
      required: true,
      data: asset.realShipUtilities,
      onTextChanged: (newValue) {
        asset.realShipUtilities = newValue;
      },
    );

    var soLuongNguoiDuocPhepCho = InputFieldModel<String>(
      label: S.current.so_luong_nguoi_duoc_phep_cho,
      data: asset.realPersonCarry,
      onTextChanged: (newValue) {
        asset.realPersonCarry = newValue;
      },
    );

    var chieuDaiThietKe = InputFieldModel<double>(
      label: S.current.chieu_dai_thiet_ke,
      data: asset.realDesignLength,
      onTextChanged: (newValue) {
        asset.realDesignLength = newValue;
      },
    );

    var chieuRongThietKe = InputFieldModel<double>(
      label: S.current.chieu_rong_thiet_ke,
      data: asset.realDesignWidth,
      onTextChanged: (newValue) {
        asset.realDesignWidth = newValue;
      },
    );

    var chieuDaiLonNhat = InputFieldModel<double>(
      label: S.current.chieu_dai_lon_nhat,
      data: asset.realMaxLength,
      onTextChanged: (newValue) {
        asset.realMaxLength = newValue;
      },
    );

    var chieuCaoMan = InputFieldModel<double>(
      label: S.current.chieu_cao_man,
      data: asset.realBoardHeight,
      onTextChanged: (newValue) {
        asset.realBoardHeight = newValue;
      },
    );

    var chieuChim = InputFieldModel<double>(
      label: S.current.chieu_chim,
      data: asset.realSink,
      onTextChanged: (newValue) {
        asset.realSink = newValue;
      },
    );

    var manKho = InputFieldModel<double>(
      label: S.current.man_kho,
      data: asset.realFreeBoard,
      onTextChanged: (newValue) {
        asset.realFreeBoard = newValue;
      },
    );

    var soLuongMayChinh = InputFieldModel<int>(
      label: S.current.so_luong_may_chinh,
      data: asset.realMachineNum,
      onTextChanged: (newValue) {
        asset.realMachineNum = newValue;
      },
    );

    var congSuatMayChinh = InputFieldModel<double>(
      label: S.current.cong_suat_may_chinh,
      data: asset.realMachinePower,
      onTextChanged: (newValue) {
        asset.realMachinePower = newValue;
      },
    );

    var trongTaiToanPhan = InputFieldModel<double>(
      label: S.current.trong_tai_toan_phan,
      data: asset.realDeadWeight,
      onTextChanged: (newValue) {
        asset.realDeadWeight = newValue;
      },
    );

    var tongDungTich = InputFieldModel<double>(
      label: S.current.tong_dung_tich,
      data: asset.realGrossTonnage,
      onTextChanged: (newValue) {
        asset.realGrossTonnage = newValue;
      },
    );

    var dungTichThucDung = InputFieldModel<double>(
      label: S.current.dung_tich_thuc_dung,
      data: asset.realUseTonnage,
      onTextChanged: (newValue) {
        asset.realUseTonnage = newValue;
      },
    );

    var tocDoTau = InputFieldModel<double>(
      label: S.current.toc_do_tau,
      data: asset.realSpeed,
      onTextChanged: (newValue) {
        asset.realSpeed = newValue;
      },
    );

    var noiDungKhac = InputFieldModel<String>(
      label: S.current.noi_dung_khac,
      data: asset.realAdditionalContent,
      minLines: 4,
      maxLines: 4,
      onTextChanged: (newValue) {
        asset.realAdditionalContent = newValue;
      },
    );

    return ExpandModel(
        title: 'title',
        isExpand: false,
        child: [],
        lsInputField: [
          tenPhuongTien,
          soDangKy,
          soLoai,
          soNhanDangTau,
          nhanHieu,
          namSanXuat,
          namHoanCai,
          nuocSanXuat,
          noiDongTau,
          hangDongTau,
          quocGiaDangKy,
          congNangSuDung,
          soLuongNguoiDuocPhepCho,
          chieuDaiThietKe,
          chieuRongThietKe,
          chieuDaiLonNhat,
          chieuCaoMan,
          chieuChim,
          manKho,
          soLuongMayChinh,
          congSuatMayChinh,
          trongTaiToanPhan,
          tongDungTich,
          dungTichThucDung,
          tocDoTau,
          noiDungKhac,
        ],
        topLsInputField: []);
  }

  void copyDacDiemPhapLySangThucTe(AssetsDetailModel<PTDTModel> element) {
    final asset = element.asset;
    asset
      ..realName = asset.legalName
      ..realRegisterNumber = asset.legalRegisterNumber
      ..realModel = asset.legalModel
      ..realImoNumber = asset.legalImoNumber
      ..realBrand = asset.legalBrand
      ..realYearMfg = asset.legalYearMfg
      ..realCountryMfg = asset.legalCountryMfg
      ..realShipbuildingBrand = asset.legalShipbuildingBrand
      ..realRegisterCountry = asset.legalRegisterCountry
      ..realShipType = asset.legalShipType
      ..realPersonCarry = asset.legalPersonCarry
      ..realDesignLength = asset.legalDesignLength
      ..realDesignWidth = asset.legalDesignWidth
      ..realMaxLength = asset.legalMaxLength
      ..realBoardHeight = asset.legalBoardHeight
      ..realSink = asset.legalSink
      ..realFreeBoard = asset.legalFreeBoard
      ..realSkinMaterial = asset.legalSkinMaterial
      ..realMachineNum = asset.legalMachineNum
      ..realMachinePower = asset.legalMachinePower
      ..realDeadWeight = asset.legalDeadWeight
      ..realGrossTonnage = asset.legalGrossTonnage
      ..realUseTonnage = asset.legalUseTonnage
      ..realYearReconstructed = asset.legalYearReconstructed
      ..realManufacturingLocation = asset.legalManufacturingLocation
      ..realSpeed = asset.legalSpeed
      ..realShipUtilities = asset.legalShipUtilities
      ..realAdditionalContent = asset.legalAdditionalContent;

    final lsExpand = state.assetInfo[element.assetCode] ?? [];
    final dacDiemIndex = lsExpand.indexWhere(
      (element) => element.key?.contains('-dacDiemKyThuat') == true,
    );
    final dacDiemKyThuat = lsExpand[dacDiemIndex];
    dacDiemKyThuat.child[1] = listDacDiemKyThuatThucTe(element);
    state = state.copyWith();
  }

  @override
  ExpandModel generateOtherInfo(PTDTModel item) {
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
      required: false,
      validator: Validator.validatePercent,
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

    final soThoiGianSuDung = InputFieldModel<int>(
      label: S.current.so_thoi_gian_da_qua_su_dung,
      data: item.numberOfDaysUsed,
      onTextChanged: (newValue) => item.numberOfDaysUsed = newValue,
    );

    final ghiChu = InputFieldModel<String>(
      label: S.current.ghi_chu,
      value: item.note,
      minLines: 4,
      maxLines: 4,
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
        soThoiGianSuDung,
        ghiChu,
      ],
    );
  }

  @override
  bool visibleDiaChiTaiSanInGroupThongTin = true;
}
