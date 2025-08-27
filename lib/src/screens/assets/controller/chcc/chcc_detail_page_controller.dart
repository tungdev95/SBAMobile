import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/chcc_info.dart';
import 'package:sba/src/models/assets/chcc_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/assets/detail/chcc/detail_chcc_info.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/services/api/assets_api.dart';
import 'package:sba/src/utils/utils.dart';
part 'chcc_detail_page_controller.g.dart';

@riverpod
Future<List<KeyValueModel>> getListProvince(GetListProvinceRef ref) async {
  final result = await ref.read(assetsApiProvider).getListProvince();
  if ((result.data ?? []).isNotEmpty) {
    ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListDistrict(
  GetListDistrictRef ref,
  CHCCInfo chccInfo,
) async {
  final provinceSelected = ref.watch(selectedProvinceProvider(chccInfo));
  final result = await ref.read(assetsApiProvider).getListDistrict(
        provinceCode: provinceSelected?.key ?? '',
      );
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
    ref.listen(
      selectedProvinceProvider(chccInfo),
      (previous, next) {
        if (previous?.key != next?.key) {
          keepAliveLink.close();
        }
      },
    );
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListAddress(
  GetListAddressRef ref,
  CHCCInfo chccInfo,
) async {
  final districtSelected = ref.watch(selectedDistrictProvider(chccInfo));
  final result = await ref
      .read(assetsApiProvider)
      .getListAddress(districtCode: districtSelected?.key ?? '');
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
    ref.listen(selectedDistrictProvider(chccInfo), (previous, next) {
      keepAliveLink.close();
    });
  }
  return result.data ?? [];
}

@riverpod
KeyValueModel? selectedProvinceItem(
    SelectedProvinceItemRef ref, CHCCInfo params) {
  // return ;
  ref.listenSelf((previous, next) {
    params.realAddressProvince = next?.key;
    if (previous == null && next != null) return;

    params.realAddressDistrict = null;
    ref.read(selectedDistrictProvider(params).notifier).state = null;
  });
  if (params.realAddressProvince == null) return null;

  return KeyValueModel(key: params.realAddressProvince, title: null);
}

//Selected Tỉnh
final selectedProvinceProvider = StateProvider.family<KeyValueModel?, CHCCInfo>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.realAddressProvince = next?.key;
      if (previous == null && next != null) return;

      params.realAddressDistrict = null;
      ref.read(selectedDistrictProvider(params).notifier).state = null;
    });
    if (params.realAddressProvince == null) return null;

    return KeyValueModel(key: params.realAddressProvince, title: null);
  },
);

//Selected Phường xã
final selectedDistrictProvider = StateProvider.family<KeyValueModel?, CHCCInfo>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.realAddressDistrict = next?.key;
      if (previous == null && next != null) return;
      params.realAddressWard = null;
      ref.read(selectedAddressProvider(params).notifier).state = null;
    });
    if (params.realAddressDistrict == null) return null;

    return KeyValueModel(key: params.realAddressDistrict, title: null);
  },
);

//Selected Quận huyện
final selectedAddressProvider = StateProvider.family<KeyValueModel?, CHCCInfo>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.realAddressWard = next?.key;
    });
    if (params.realAddressWard == null) return null;

    return KeyValueModel(key: params.realAddressWard, title: null);
  },
);

class CHCCDetailPageController
    extends BaseAssetDetailPageController<CHCCModel> {
  CHCCDetailPageController(super.state, super.ref);

  @override
  String? get tag => 'CHCCDetailPageController';

  static final detailPageControllerProvider = StateNotifierProvider.autoDispose
      .family<CHCCDetailPageController, AssetsDetailState<CHCCModel>,
          AssetDetailProviderElement>(
    (ref, element) {
      final controller = CHCCDetailPageController(
        AssetsDetailState.element(
          element,
        ),
        ref,
      );
      return controller;
    },
  );

  @override
  bool get enableUploadDinhVi => true;

  @override
  void initDropdownList(List<AssetsDetailModel<CHCCModel>> assets) {
    final customerInfo = state.element.assetsModel?.customer;
    ExpandModel ttinTaiSan =
        thongTinTaiSan(state.surveyInfo!, enableMotaChiTiet: false);
    ExpandModel ttinChiNhanh = thongTinChiNhanh(state.surveyInfo!);
    ExpandModel thongTinDeNghi = generateThongTinDeNghi(customerInfo);
    ExpandModel thongTinKhaoSatTaiSan = thongTinLienHeVaKhaoSatTaiSan(
        state.surveyInfo ??=
            AssetsModel(surveySchedules: [], assetType: AssetsTypeEnum.bds));
    ExpandModel thoiGianHenSBA = thoiGianKhaoSatSBA(state.surveyInfo ??=
        AssetsModel(surveySchedules: [], assetType: AssetsTypeEnum.bds));

    Map<String, List<ExpandModel>> assetMap = {};

    for (var element in assets) {
      ExpandModel thongTinPhapLy = ExpandModel(
        key: phapLyKey,
        title: S.current.thong_tin_phap_ly,
        isExpand: true,
        child: generateLegals(element),
        lsInputField: const [],
        topLsInputField: [],
      );

      ExpandModel thongTinCanHo = getThongTinCanHoExpandModel(element);

      ExpandModel thongTinKhac = generateOtherInfo(element.asset);

      ExpandModel canhBaoRuiRo = ExpandModel(
        key: cbrr,
        title: S.current.canh_bao_rui_ro,
        isExpand: true,
        child: generateListCBRR(element),
        lsInputField: const [],
        topLsInputField: [],
      );

      assetMap[element.assetCode ?? ''] = [
        thongTinPhapLy,
        thongTinCanHo,
        // tienIch,
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

  ExpandModel getThongTinCanHoExpandModel(
      AssetsDetailModel<CHCCModel> element) {
    return ExpandModel(
      key: canHoKey,
      title: S.current.dac_diem_can_ho,
      isExpand: true,
      child: generateCHCCInfo(element),
      lsInputField: const [],
      topLsInputField: [
        if (element.asset.isShowDiaChi)
          InputFieldModel<String>(
            label: S.current.dia_chi_tai_san,
            data: element.asset.combineAppraisalLocation,
            minLines: 4,
            maxLines: 4,
            onTextChanged: (newValue) =>
                element.asset.combineAppraisalLocation = newValue,
          ),
      ],
    );
  }

  ///Thông tin căn hộ
  List<ExpandModel> generateCHCCInfo(AssetsDetailModel<CHCCModel> asset) {
    final result = <ExpandModel>[];
    var chccInfos = asset.asset.assetApartmentInfors;
    if (chccInfos.isEmpty) {
      chccInfos.add(CHCCInfo(assetCode: asset.assetCode));
    }
    for (var i = 0; i < chccInfos.length; i++) {
      final chcc = chccInfos[i];
      final lsInput = <InputFieldModel>[];
      final chccExpand = generateCHCCExpandInfo(chcc, asset);
      result.add(chccExpand);
    }

    return result;
  }

  ///Generate 1 đặc điểm căn hộ
  ExpandModel generateCHCCExpandInfo(
      CHCCInfo chccInfo, AssetsDetailModel<CHCCModel> asset) {
    final tinhTP = InputFieldModel<String>(
      label: S.current.tinh_tp,
      inputFieldType: InputFieldType.dropDown,
      required: true,
      selectedItemProvider: selectedProvinceProvider(chccInfo),
      listDataProvider: (p0) => p0.call(
        getListProvinceProvider,
      ),
      onChange: (newValue) {
        chccInfo.realAddressProvince = newValue?.key;
      },
    );

    final quanHuyen = InputFieldModel<String>(
      label: S.current.tp_quan_huyen,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: selectedDistrictProvider(chccInfo),
      listDataProvider: (p0) => p0.call(
        getListDistrictProvider(chccInfo),
      ),
      onChange: (newValue) {
        chccInfo.realAddressDistrict = newValue?.key;
      },
    );

    final phuongXa = InputFieldModel<String>(
      label: S.current.xa_phuong_thi_tran,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: selectedAddressProvider(chccInfo),
      listDataProvider: (p0) => p0.call(
        getListAddressProvider(chccInfo),
      ),
      onChange: (newValue) {
        chccInfo.realAddressWard = newValue?.key;
      },
    );

    final duongPho = InputFieldModel<String>(
        label: S.current.duong_pho,
        value: chccInfo.realAddressStreet,
        onTextChanged: (newValue) => chccInfo.realAddressStreet = newValue);

    final chiTiet = InputFieldModel<String>(
        label: S.current.chi_tiet,
        value: chccInfo.realAddressDetail,
        onTextChanged: (newValue) => chccInfo.realAddressDetail = newValue);

    final detailButton = InputFieldModel<String>(
      inputFieldType: InputFieldType.custom,
      widgetBuilder: (context, ref, tap, data) {
        return Align(
          alignment: Alignment.topRight,
          child: TextButton.icon(
            onPressed: () async {
              await goToEditCHCCPage(context, ref, chccInfo, asset);
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
      title: S.current.dac_diem_can_ho,
      generateTitleIndex: true,
      allowAdd: true,
      allowDelete: true,
      isExpand: true,
      child: const [],
      addNewExpandClicked: (context, ref, expandId) {
        addNewDacDiemCanHo(asset);
      },
      removeExpandClicked: (context, ref, expandId) {
        xoaDacDiemCanHo(asset.assetCode ?? '', expandId, chccInfo.id ?? '');
      },
      lsInputField: [
        tinhTP,
        quanHuyen,
        phuongXa,
        duongPho,
        chiTiet,
        detailButton
      ],
      topLsInputField: [],
    );
  }

  void addNewDacDiemCanHo(AssetsDetailModel<CHCCModel> asset) {
    String assetCode = asset.assetCode ?? '';
    final currentAssetIndex = (state.assets ?? [])
        .indexWhere((element) => element.assetCode == assetCode);
    final currentAsset = (state.assets ?? [])[currentAssetIndex];
    CHCCInfo chccInfo = CHCCInfo(assetCode: asset.assetCode);
    final chccExpandItem = generateCHCCExpandInfo(chccInfo, asset);

    final assetObject = currentAsset.asset;
    assetObject.assetApartmentInfors.add(chccInfo);
    var lsExpand = state.assetInfo[assetCode] ?? [];
    lsExpand
        .firstWhere((element) => element.key == canHoKey)
        .child
        .add(chccExpandItem);
    state = state.copyWith();
  }

  void xoaDacDiemCanHo(String assetCode, String expandId, String chccId) {
    final currentAssetIndex = (state.assets ?? [])
        .indexWhere((element) => element.assetCode == assetCode);
    final currentAsset = (state.assets ?? [])[currentAssetIndex];
    final assetObject = currentAsset.asset;
    assetObject.assetApartmentInfors
        .removeWhere((element) => element.id == chccId);
    var lsExpand = state.assetInfo[assetCode] ?? [];
    lsExpand
        .firstWhere((element) => element.key == canHoKey)
        .child
        .removeWhere((element) => element.id == expandId);
    state = state.copyWith();
  }

  ///Chi tiết căn hộ
  Future<void> goToEditCHCCPage(BuildContext context, WidgetRef ref,
      CHCCInfo chccInfo, AssetsDetailModel<CHCCModel> asset) async {
    CHCCInfo? result = await AppRoutes.push(
      context,
      ProviderScope(
        overrides: [
          chccInfoProvider.overrideWithValue(
            DetailCHCCData(
              chccInfo: asset.asset.assetApartmentInfors
                  .firstWhere((element) => element.id == chccInfo.id),
              detailModel: asset.asset,
            ),
          )
        ],
        child: const DetailCHCCInfoPage(),
      ),
    );
    var lsExpand = state.assetInfo[asset.assetCode] ?? [];
    final thuaDatItem =
        lsExpand.firstWhere((element) => element.key == canHoKey);
    thuaDatItem.topLsInputField =
        getThongTinCanHoExpandModel(asset).topLsInputField;
    state = state.copyWith();
  }

  @override
  Box<AssetsDetailModel<CHCCModel>> get boxProvider =>
      ref.read(chccBoxProvider);

  @override
  List<KeyValueModel> get getListQuyHoach => lsQuyHoachBDS;

  @override
  InputFieldModel<String> getThongTinTranhChap(CHCCModel item) {
    return InputFieldModel<String>(
      label: S.current.thong_tin_tranh_chap,
      data: item.disputeInfor,
      onTextChanged: (p0) => item.disputeInfor = p0,
    );
  }

  @override
  void complete() {
    for (AssetsDetailModel<CHCCModel> element in (state.assets ?? [])) {
      String errorMess = '';

      for (var index = 0;
          index < element.asset.assetApartmentInfors.length;
          index++) {
        final landInfo = element.asset.assetApartmentInfors[index];
        if (!landInfo.isValid) {
          errorMess =
              '${S.current.dac_diem_can_ho} ${index + 1}: ${S.current.vui_long_nhap_day_du_thong_tin}';

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
}
