import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/services/providers/asset_api_provider.dart';
import 'package:sba/src/services/providers/bds_api_provider.dart';
import 'package:sba/src/utils/utils.dart';

class BDSDetailPageController
    extends BaseAssetDetailPageController<RealEstateModel> {
  BDSDetailPageController(super.state, super.ref);

  static final detailPageControllerProvider = StateNotifierProvider.autoDispose
      .family<BDSDetailPageController, AssetsDetailState<RealEstateModel>,
          AssetDetailProviderElement>(
    (ref, element) {
      final controller = BDSDetailPageController(
        AssetsDetailState.element(element),
        ref,
      );
      return controller;
    },
  );

  @override
  void initDropdownList(List<AssetsDetailModel<RealEstateModel>> assets) {
    final customerInfo = state.element.assetsModel?.customer;
    ExpandModel ttinTaiSan = thongTinTaiSan(
      state.surveyInfo!,
      enableMotaChiTiet: false,
    );

    ExpandModel ttinChiNhanh = thongTinChiNhanh(
      state.surveyInfo!,
    );

    ExpandModel thongTinDeNghi = generateThongTinDeNghi(customerInfo);

    ExpandModel thongTinKhaoSatTaiSan = thongTinLienHeVaKhaoSatTaiSan(
        state.surveyInfo ??=
            AssetsModel(surveySchedules: [], assetType: AssetsTypeEnum.bds));

    ExpandModel thoiGianHenSBA = thoiGianKhaoSatSBA(
      state.surveyInfo ??=
          AssetsModel(surveySchedules: [], assetType: AssetsTypeEnum.bds),
    );

    Map<String, List<ExpandModel>> assetMap = {};

    for (var element in assets) {
      ExpandModel thongTinPhapLy = ExpandModel(
        key: phapLyKey,
        title: S.current.thong_tin_phap_ly,
        isExpand: false,
        child: generateLegals(element),
        lsInputField: [],
        topLsInputField: [],
      );

      ExpandModel thongTinThuaDat = getThongTinThuaDatExpandModel(element);

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
        thongTinThuaDat,
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

  ExpandModel getThongTinThuaDatExpandModel(
      AssetsDetailModel<RealEstateModel> element) {
    final isHopThua = element.asset.isHopThua;
    final showDiaChi = !isHopThua && element.asset.assetLandInfors.length > 1;
    return ExpandModel(
      key: thuaDatKey,
      title: S.current.dac_diem_thua_dat,
      isExpand: false,
      child: generateLandInfo(element),
      topLsInputField: [
        if (showDiaChi)
          InputFieldModel<String>(
            label: S.current.dia_chi_tai_san,
            data: element.asset.combineLandAddressDetail,
            minLines: 4,
            maxLines: 4,
            onTextChanged: (newValue) =>
                element.asset.combineLandAddressDetail = newValue,
          ),
      ],
      lsInputField: [
        InputFieldModel<bool>(
          data: element.asset.xuatThongTinTomTat,
          inputFieldType: InputFieldType.custom,
          widgetBuilder: (BuildContext context, WidgetRef ref, VoidCallback tap,
              dynamic data) {
            final item = (state.assets ?? [])
                .firstWhere((item) => element.assetCode == item.assetCode);
            return CheckboxListTile(
              value: item.asset.xuatThongTinTomTat,
              checkColor: Colors.white,
              onChanged: (newValue) {
                bool isChecked = newValue == true;
                item.asset.xuatThongTinTomTat = isChecked;

                ///Bỏ hợp thửa nếu check tóm tắt
                if (isChecked) {
                  state.assets?.forEach((element) {
                    for (var child in element.asset.assetLandInfors) {
                      child.isConsolidation = false;
                    }
                  });
                }
                state = state.copyWith();
              },
              title: Text(S.current.xuat_thong_tin_tom_tat),
            );
          },
        )
      ],
    );
  }

  @override
  bool get enableUploadDinhVi => true;

  /// Thông tin thửa đất
  List<ExpandModel> generateLandInfo(
    AssetsDetailModel<RealEstateModel> asset,
  ) {
    final result = <ExpandModel>[];
    // final lsInput = <>[];
    var landInfors = asset.asset.assetLandInfors;
    if (landInfors.isEmpty) {
      landInfors.add(AssetLandInfo.fromJson({}));
    }
    for (var i = 0; i < landInfors.length; i++) {
      final land = landInfors[i];
      final lsInput = <InputFieldModel>[];
      final landExpand = generateLandExpandInfo(land, asset);
      result.add(landExpand);
    }

    return result;
  }

  /// Generate 1 đặc điểm thửa đất
  ExpandModel generateLandExpandInfo(
    AssetLandInfo landInfo,
    AssetsDetailModel<RealEstateModel> asset,
  ) {
    final tinhTP = InputFieldModel<String>(
      label: S.current.tinh_tp,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: selectedProvinceProvider(landInfo),
      required: true,
      listDataProvider: (p0) => p0.call(
        getListProvinceProvider,
      ),
      onChange: (newValue) {
        landInfo.realAddressProvince = newValue?.key;
      },
    );

    final quanHuyen = InputFieldModel<String>(
      label: S.current.tp_quan_huyen,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: selectedDistrictProvider(landInfo),
      listDataProvider: (p0) => p0.call(
        getListDistrictProvider(landInfo),
      ),
      onChange: (newValue) {
        landInfo.realAddressDistrict = newValue?.key;
      },
    );

    final phuongXa = InputFieldModel<String>(
      label: S.current.xa_phuong_thi_tran,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: selectedAddressProvider(landInfo),
      listDataProvider: (p0) => p0.call(
        getListAddressProvider(landInfo),
      ),
      onChange: (newValue) {
        landInfo.realAddressWard = newValue?.key;
      },
    );

    final duongPho = InputFieldModel<String>(
        label: S.current.duong_pho,
        data: landInfo.realAddressStreet,
        onTextChanged: (newValue) => landInfo.realAddressStreet = newValue);

    final chiTiet = InputFieldModel<String>(
        label: S.current.chi_tiet,
        data: landInfo.realAddressDetail,
        onTextChanged: (newValue) => landInfo.realAddressDetail = newValue);

    final dienTichKhuonVien = InputFieldModel<double>(
      label: S.current.dien_tich_khuon_vien,
      data: landInfo.realAreaWidth,
      required: true,
      onTextChanged: (newValue) => landInfo.realAreaWidth = newValue,
    );

    final moTaChiTietViTri = InputFieldModel<String>(
      label: S.current.mo_ta_vi_tri,
      data: landInfo.note,
      required: true,
      onTextChanged: (newValue) => landInfo.note = newValue,
    );

    final detailButton = InputFieldModel<String>(
      inputFieldType: InputFieldType.custom,
      widgetBuilder: (context, ref, tap, data) {
        return Align(
          alignment: Alignment.topRight,
          child: TextButton.icon(
            onPressed: () async {
              final assetInfo = (state.assets ?? []).firstWhereOrNull(
                  (element) => element.assetCode == asset.assetCode);
              if (assetInfo != null) {
                final info = assetInfo.asset.assetLandInfors
                    .firstWhereOrNull((e) => e.id == landInfo.id);
                await goToEditLandPage(
                  context,
                  ref,
                  landInfo,
                  asset,
                );
              }
              tap();
            },
            style: ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: MaterialStateProperty.resolveWith(
                (states) => EdgeInsets.zero,
              ),
            ),
            icon: const Icon(Icons.edit),
            label: Text(S.current.chi_tiet),
          ),
        );
      },
    );

    return ExpandModel(
      title: S.current.dac_diem_thua_dat,
      generateTitleIndex: true,
      allowAdd: true,
      allowDelete: true,
      isExpand: true,
      child: [],
      topLsInputField: [],
      addNewExpandClicked: (context, ref, expandId) {
        addNewCTXD(asset);
      },
      removeExpandClicked: (context, ref, expandId) {
        removeCTXD(asset.assetCode ?? '', expandId, landInfo.id ?? '');
      },
      lsInputField: [
        tinhTP,
        quanHuyen,
        phuongXa,
        duongPho,
        chiTiet,
        dienTichKhuonVien,
        moTaChiTietViTri,
        detailButton,
      ],
    );
  }

  void addNewCTXD(
    AssetsDetailModel<RealEstateModel> asset,
  ) {
    String assetCode = asset.assetCode ?? '';
    final currentAssetIndex = (state.assets ?? [])
        .indexWhere((element) => element.assetCode == assetCode);
    final currentAsset = (state.assets ?? [])[currentAssetIndex];
    AssetLandInfo assetLandInfo = AssetLandInfo.fromJson({});
    final landExpandItem = generateLandExpandInfo(assetLandInfo, asset);

    final assetObject = currentAsset.asset;
    assetObject.assetLandInfors.add(assetLandInfo);
    var lsExpand = state.assetInfo[assetCode] ?? [];
    lsExpand
        .firstWhere((element) => element.key == thuaDatKey)
        .child
        .add(landExpandItem);
    state = state.copyWith();
  }

  void removeCTXD(
    String assetCode,
    String expandId,
    String ctxdID,
  ) {
    final currentAssetIndex = (state.assets ?? [])
        .indexWhere((element) => element.assetCode == assetCode);
    final currentAsset = (state.assets ?? [])[currentAssetIndex];
    final assetObject = currentAsset.asset;
    assetObject.assetLandInfors.removeWhere((element) => element.id == ctxdID);
    var lsExpand = state.assetInfo[assetCode] ?? [];
    lsExpand
        .firstWhere((element) => element.key == thuaDatKey)
        .child
        .removeWhere((element) => element.id == expandId);
    state = state.copyWith();
  }

  /// Chi tiết thửa
  Future<void> goToEditLandPage(
    BuildContext context,
    WidgetRef ref,
    AssetLandInfo landInfo,
    AssetsDetailModel<RealEstateModel> asset,
  ) async {
    AssetLandInfo? result = await AppRoutes.push(
      context,
      ProviderScope(
        overrides: [
          detailLandProvider.overrideWithValue(
            DetailData(
              landInfo: asset.asset.assetLandInfors
                  .firstWhere((element) => element.id == landInfo.id),
              detailModel: asset.asset,
            ),
          )
        ],
        child: const DetailLandInfoPage(),
      ),
    );
    if (result != null) {
      final index = asset.asset.assetLandInfors
          .indexWhere((element) => element.id == landInfo.id);

      asset.asset.assetLandInfors[index] = landInfo
        ..assetLandUsingPurposes = result.assetLandUsingPurposes
        ..constructionChecklists = result.constructionChecklists
        ..assetTrees = result.assetTrees
        ..constructionFutureInfors = result.constructionFutureInfors
        ..constructions = result.constructions
        ..isConsolidation = result.isConsolidation
        ..isConsolidationPurpose = result.isConsolidationPurpose;

      state.assets?.forEach(
        (element) {
          for (var land in element.asset.assetLandInfors) {
            land.isConsolidation = result.isConsolidation;
          }
        },
      );

      if (result.isConsolidation) {
        state.assets?.forEach(
          (element) {
            element.asset.xuatThongTinTomTat = false;
          },
        );
      }

      var lsExpand = state.assetInfo[asset.assetCode] ?? [];
      final thuaDatItem =
          lsExpand.firstWhere((element) => element.key == thuaDatKey);
      thuaDatItem.topLsInputField =
          getThongTinThuaDatExpandModel(asset).topLsInputField;
      state = state.copyWith();
    }
  }

  @override
  void complete() {
    for (AssetsDetailModel<RealEstateModel> element in (state.assets ?? [])) {
      String errorMess = '';

      for (var index = 0;
          index < element.asset.assetLandInfors.length;
          index++) {
        final landInfo = element.asset.assetLandInfors[index];
        if (landInfo.assetLandUsingPurposes.isEmpty ||
            landInfo.assetLandUsingPurposes.any(
              (child) => child.usingPurposeId == null,
            )) {
          errorMess =
              '${S.current.dac_diem_thua_dat} ${index + 1}: Vui lòng chọn ${S.current.muc_dich_theo_sba}';
          break;
        }
        if (!landInfo.isValid()) {
          errorMess =
              '${S.current.dac_diem_thua_dat} ${index + 1}: ${S.current.vui_long_nhap_day_du_thong_tin}';

          break;
        }
      }

      if (errorMess.isNotEmpty) {
        showMessageDialog(errorMess);
        return;
      }
    }
    super.complete();
  }

  @override
  Box<AssetsDetailModel<RealEstateModel>> get boxProvider =>
      ref.read(bdsBoxProvider);

  @override
  List<KeyValueModel> get getListQuyHoach => lsQuyHoachBDS;

  @override
  InputFieldModel<String> getThongTinTranhChap(RealEstateModel item) {
    return InputFieldModel<String>(
      label: S.current.thong_tin_tranh_chap,
      data: item.disputeInfor,
      onTextChanged: (p0) => item.disputeInfor = p0,
    );
  }
}
