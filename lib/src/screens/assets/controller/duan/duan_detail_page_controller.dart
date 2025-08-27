import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:sba/src/services/providers/asset_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/duan_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/assets/detail/duan/duan_chitiet_thuadat_page.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/services/api/assets_api.dart';
import 'package:sba/src/utils/utils.dart';
part 'duan_detail_page_controller.g.dart';

@riverpod
Future<List<KeyValueModel>> getListAddress(
  GetListAddressRef ref,
  AssetProjectInfo landInfo,
) async {
  final districtSelected = ref.watch(selectedDistrictProvider(landInfo));
  final result = await ref
      .read(assetsApiProvider)
      .getListAddress(districtCode: districtSelected?.key ?? '');
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
    ref.listen(
      selectedDistrictProvider(landInfo),
      (previous, next) {
        keepAliveLink.close();
      },
    );
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListDistrict(
  GetListDistrictRef ref,
  AssetProjectInfo landInfo,
) async {
  final provinceSelected = ref.watch(selectedProvinceProvider(landInfo));
  final result = await ref
      .read(assetsApiProvider)
      .getListDistrict(provinceCode: provinceSelected?.key ?? '');
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
    ref.listen(selectedProvinceProvider(landInfo), (previous, next) {
      if (previous?.key != next?.key) {
        keepAliveLink.close();
      }
    });
  }
  return result.data ?? [];
}

//Selected Tỉnh
final selectedProvinceProvider =
    StateProvider.family<KeyValueModel?, AssetProjectInfo>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.provinceCode = next?.key;
      // params.provinceName = next?.title;
      if (previous == null && next != null) return;

      params.districtCode = null;
      params.districtName = null;
      ref.read(selectedDistrictProvider(params).notifier).state = null;
    });
    if (params.provinceCode == null) return null;

    return KeyValueModel(
      key: params.provinceCode,
      // title: params.provinceName,
    );
  },
);

//Selected Phường xã
final selectedDistrictProvider =
    StateProvider.family<KeyValueModel?, AssetProjectInfo>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.districtCode = next?.key;
      // params.districtName = next?.title;
      if (previous == null && next != null) return;
      params.wardCode = null;
      // params.wardName = null;
      ref.read(selectedAddressProvider(params).notifier).state = null;
    });
    if (params.districtCode == null) return null;

    return KeyValueModel(
      key: params.districtCode,
      // title: params.districtName,
    );
  },
);

//Selected Quận huyện
final selectedAddressProvider =
    StateProvider.family<KeyValueModel?, AssetProjectInfo>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.wardCode = next?.key;
      // params.wardName = next?.title;
    });
    if (params.wardCode == null) return null;

    return KeyValueModel(
      key: params.wardCode,
      // title: params.wardName,
    );
  },
);

class DuAnDetailPageController
    extends BaseAssetDetailPageController<DuAnModel> {
  DuAnDetailPageController(super.state, super.ref);

  static final detailPageControllerProvider = StateNotifierProvider.autoDispose
      .family<DuAnDetailPageController, AssetsDetailState<DuAnModel>,
          AssetDetailProviderElement>(
    (ref, element) {
      final controller = DuAnDetailPageController(
        AssetsDetailState.element(element),
        ref,
      );
      return controller;
    },
  );

  @override
  bool get enableUploadDinhVi => true;

  @override
  void initDropdownList(List<AssetsDetailModel<DuAnModel>> assets) {
    final customerInfo = state.element.assetsModel?.customer;
    ExpandModel ttinTaiSan =
        thongTinTaiSan(state.surveyInfo!, enableMotaChiTiet: false);
    ExpandModel ttinChiNhanh = thongTinChiNhanh(state.surveyInfo!);
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

      ExpandModel thongTinThuaDat = ExpandModel(
        key: thuaDatKey,
        title: S.current.dac_diem_thua_dat,
        isExpand: false,
        topLsInputField: [],
        lsInputField: [
          ...generateLandExpandInfo(element),
          InputFieldModel<bool>(
            data: element.asset.xuatThongTinTomTat,
            inputFieldType: InputFieldType.custom,
            widgetBuilder: (context, ref, tap, data) {
              final item = (state.assets ?? [])
                  .firstWhere((item) => element.assetCode == item.assetCode);
              return CheckboxListTile(
                value: item.asset.xuatThongTinTomTat,
                checkColor: Colors.white,
                onChanged: (newValue) {
                  bool isChecked = newValue == true;
                  item.asset.xuatThongTinTomTat = isChecked;

                  ///Bỏ hợp thửa nếu check tóm tắt
                  // if (isChecked) {
                  //   state.assets?.forEach((element) {
                  //     for (var child in element.asset.assetLandInfors) {
                  //       child.isConsolidation = false;
                  //     }
                  //   });
                  // }
                  state = state.copyWith();
                },
                title: Text(S.current.xuat_thong_tin_tom_tat),
              );
            },
          )
        ],
        child: [],
      );

      ExpandModel canHoChungCu = generateCanHoChungCu(element);

      ExpandModel datNen = generateDatNen(element);

      ExpandModel thuongMaiDV = generateThuongMaiDV(element);

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
        canHoChungCu,
        datNen,
        thuongMaiDV,
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

  /// Generate 1 đặc điểm thửa đất
  List<InputFieldModel> generateLandExpandInfo(
    AssetsDetailModel<DuAnModel> asset,
  ) {
    asset.asset.assetProjectInfor ??= AssetProjectInfo(
      assetLandUsingPurposes: [],
      assetTrees: [],
      constructions: [],
      detailDescribes: [],
    );
    AssetProjectInfo landInfo = asset.asset.assetProjectInfor!;

    final tinhTP = InputFieldModel<String>(
      label: S.current.tinh_tp,
      inputFieldType: InputFieldType.dropDown,
      required: true,
      selectedItemProvider: selectedProvinceProvider(landInfo),
      listDataProvider: (p0) => p0.call(
        getListProvinceProvider,
      ),
      onChange: (newValue) {
        landInfo.provinceCode = newValue?.key;
        landInfo.provinceName = newValue?.title;
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
        // landInfo.realAddressDistrict = newValue?.key;
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
        // landInfo.realAddressWard = newValue?.key;
      },
    );

    final diaDiemThamDinhGia = InputFieldModel<String>(
      label: S.current.dia_diem_tham_dinh_gia,
      data: landInfo.appraisalLocation,
      required: true,
      minLines: 4,
      maxLines: 4,
      onTextChanged: (newValue) => landInfo.appraisalLocation = newValue,
    );

    final hienTrang = InputFieldModel<String>(
        label: S.current.hien_trang,
        data: landInfo.currentAsset,
        minLines: 4,
        maxLines: 4,
        onTextChanged: (newValue) => landInfo.currentAsset = newValue,
        required: true);

    final dienTichKhuonVien = InputFieldModel<double>(
      label: S.current.dien_tich_khuon_vien,
      data: landInfo.areaWidth,
      required: true,
      onTextChanged: (newValue) => landInfo.areaWidth = newValue,
    );

    final moTaChiTietViTri = InputFieldModel<String>(
      label: S.current.mo_ta_vi_tri_dia_ly,
      data: landInfo.description,
      minLines: 4,
      maxLines: 4,
      required: true,
      onTextChanged: (newValue) => landInfo.description = newValue,
    );

    final detailButton = InputFieldModel<String>(
      inputFieldType: InputFieldType.custom,
      widgetBuilder: (context, ref, tap, data) {
        return Align(
          alignment: Alignment.topRight,
          child: TextButton.icon(
            onPressed: () async {
              await goToEditLandPage(
                context,
                ref,
                asset,
              );
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

    return [
      tinhTP,
      quanHuyen,
      phuongXa,
      diaDiemThamDinhGia,
      hienTrang,
      dienTichKhuonVien,
      moTaChiTietViTri,
      detailButton,
    ];
  }

  /// Chi tiết thửa
  Future<void> goToEditLandPage(
    BuildContext context,
    WidgetRef ref,
    AssetsDetailModel<DuAnModel> asset,
  ) async {
    if (asset.asset.assetProjectInfor == null) return;
    AssetProjectInfo? result = await AppRoutes.push(
      context,
      ProviderScope(
        overrides: [
          chiTietThuaDatData
              .overrideWithValue(asset.asset.assetProjectInfor!.copyWith())
        ],
        child: const ChiTietThuaDatDuAnPage(),
      ),
    );
    if (result != null) {
      asset.asset.assetProjectInfor = result;
      state = state.copyWith();
    }
  }

  @override
  void complete() {
    for (AssetsDetailModel<DuAnModel> element in (state.assets ?? [])) {
      String errorMess = '';
      var assetLandUsingPurposes =
          element.asset.assetProjectInfor?.assetLandUsingPurposes ?? [];

      for (var i = 0; i < assetLandUsingPurposes.length; i++) {
        final item = assetLandUsingPurposes[i];
        if (!item.isValid()) {
          errorMess =
              '${S.current.dac_diem_thua_dat} ${i + 1}: ${S.current.vui_long_nhap_day_du_thong_tin}';

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
  Box<AssetsDetailModel<DuAnModel>> get boxProvider =>
      ref.read(duAnBoxProvider);

  ExpandModel generateCanHoChungCu(AssetsDetailModel<DuAnModel> asset) {
    return ExpandModel(
      key: 'chcc',
      title: S.current.can_ho_chung_cu,
      isExpand: false,
      child: const [],
      lsInputField: [
        if (asset.asset.haveApartment == true) chccInputField(asset.asset)
      ],
      trailingExpandWidgetBuilder: (context, ref) {
        return CupertinoSwitch(
          activeColor: Theme.of(context).primaryColor,
          value: asset.asset.haveApartment ?? false,
          onChanged: (newValue) {
            asset.asset.haveApartment = newValue;
            toggleCHCC(
              asset,
              newValue,
            );
          },
        );
      },
      topLsInputField: [],
    );
  }

  ExpandModel generateDatNen(AssetsDetailModel<DuAnModel> asset) {
    return ExpandModel(
      key: 'datNen',
      title: S.current.dat_nen,
      isExpand: false,
      child: const [],
      lsInputField: [
        if (asset.asset.haveGround == true) datNenInputField(asset.asset)
      ],
      trailingExpandWidgetBuilder: (context, ref) {
        return CupertinoSwitch(
          activeColor: Theme.of(context).primaryColor,
          value: asset.asset.haveGround ?? false,
          onChanged: (newValue) {
            asset.asset.haveGround = newValue;
            toggleDatNen(
              asset,
              newValue,
            );
          },
        );
      },
      topLsInputField: [],
    );
  }

  ExpandModel generateThuongMaiDV(AssetsDetailModel<DuAnModel> asset) {
    return ExpandModel(
      key: 'thuongMaiDichVu',
      title: S.current.thuong_mai_dich_vu,
      isExpand: false,
      child: const [],
      lsInputField: [
        if (asset.asset.haveLandForRent == true)
          ...thuongMaiDichVuInputField(asset.asset),
      ],
      trailingExpandWidgetBuilder: (context, ref) {
        return CupertinoSwitch(
          activeColor: Theme.of(context).primaryColor,
          value: asset.asset.haveLandForRent ?? false,
          onChanged: (newValue) {
            asset.asset.haveLandForRent = newValue;
            toggleThuongMaiDichVu(
              asset,
              newValue,
            );
          },
        );
      },
      topLsInputField: [],
    );
  }

  void toggleCHCC(AssetsDetailModel<DuAnModel> asset, bool newValue) {
    List<ExpandModel> lsExpandItem =
        state.assetInfo[asset.assetCode ?? ''] ?? [];
    final chccItem = lsExpandItem.firstWhereOrNull(
      (element) => element.key == 'chcc',
    );

    if (chccItem == null) return;
    if (newValue) {
      chccItem.lsInputField.clear();
      chccItem.lsInputField.add(chccInputField(asset.asset));
    } else {
      chccItem.lsInputField.clear();
    }
    state = state.copyWith();
  }

  InputFieldModel chccInputField(DuAnModel info) {
    return InputFieldModel<String>(
      label: S.current.ghi_chu,
      data: info.apartmentNote,
      minLines: 4,
      maxLines: 4,
      onTextChanged: (newValue) => info.apartmentNote = newValue,
    );
  }

  void toggleDatNen(AssetsDetailModel<DuAnModel> asset, bool newValue) {
    List<ExpandModel> lsExpandItem =
        state.assetInfo[asset.assetCode ?? ''] ?? [];
    final item = lsExpandItem.firstWhereOrNull(
      (element) => element.key == 'datNen',
    );

    if (item == null) return;
    if (newValue) {
      item.lsInputField.clear();
      item.lsInputField.add(datNenInputField(asset.asset));
    } else {
      item.lsInputField.clear();
    }
    state = state.copyWith();
  }

  InputFieldModel datNenInputField(DuAnModel info) {
    return InputFieldModel<String>(
      label: S.current.ghi_chu,
      data: info.groundNote,
      minLines: 4,
      maxLines: 4,
      onTextChanged: (newValue) => info.groundNote = newValue,
    );
  }

  void toggleThuongMaiDichVu(
      AssetsDetailModel<DuAnModel> asset, bool newValue) {
    List<ExpandModel> lsExpandItem =
        state.assetInfo[asset.assetCode ?? ''] ?? [];
    final item = lsExpandItem.firstWhereOrNull(
      (element) => element.key == 'thuongMaiDichVu',
    );

    if (item == null) return;
    if (newValue) {
      item.lsInputField.clear();
      item.lsInputField.addAll(thuongMaiDichVuInputField(asset.asset));
    } else {
      item.lsInputField.clear();
    }
    state = state.copyWith();
  }

  List<InputFieldModel> thuongMaiDichVuInputField(DuAnModel info) {
    return [
      InputFieldModel<String>(
        label: S.current.loai_hinh,
        data: info.typeService,
        selectedValue: info.typeService != null
            ? KeyValueModel(key: info.typeService, title: info.typeService)
            : null,
        inputFieldType: InputFieldType.dropDown,
        lsDropDown: [
          KeyValueModel(key: 'Bán', title: 'Bán'),
          KeyValueModel(key: 'Cho thuê', title: 'Cho thuê'),
        ],
        onChange: (newValue) => info.typeService = newValue?.key,
      ),
      InputFieldModel<String>(
        label: S.current.ghi_chu,
        data: info.landForRentNote,
        minLines: 4,
        maxLines: 4,
        onTextChanged: (newValue) => info.landForRentNote = newValue,
      ),
    ];
  }

  ///Generate 1 thông tin pháp lý
  @override
  ExpandModel getLegalItem(LegalModel legal, String assetCode) {
    final legalInfo = legal.legalDocumentType ??= LegalInformationType();
    final tenHS = InputFieldModel<String>(
      hint: S.current.chon,
      label: S.current.ten_hs_phap_ly,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: legal.legalInformationTypeId != null
          ? KeyValueModel(
              key: legal.legalInformationTypeId.toString(),
            )
          : null,
      listDataProvider: (p0) => p0.call(
        getListLegalsProvider(state.element.assetsModel?.assetLevelTwoId),
      ),
      onChange: (newValue) {
        legal.legalInformationTypeId = int.tryParse(newValue?.key ?? '');
        legalInfo
          ..legalDocumentTypeId = int.tryParse(newValue?.key ?? '')
          ..name = newValue?.title;
      },
    );

    final soHieu = InputFieldModel<String>(
      label: S.current.so_hieu,
      value: legal.legalInformationNumber,
      onTextChanged: (newValue) {
        legal.legalInformationNumber = newValue;
      },
    );

    final donViCap = InputFieldModel<String>(
      label: S.current.don_vi_cap,
      value: legal.issueUnit,
      onTextChanged: (newValue) {
        legal.issueUnit = newValue;
      },
    );

    final ngayCap = InputFieldModel<DateTime>(
      label: S.current.ngay_cap,
      value: legal.issueDate?.toLocal().toStringFormat(),
      inputFieldType: InputFieldType.customSelect,
      trailingIcon: const Icon(Icons.calendar_month),
      onTap: (context, controller) async {
        final result = await showDatePickerSelect(
          context,
          (legal.issueDate?.toLocal() ?? DateTime.now()).toStringFormat(),
        );
        if (result != null) {
          controller.text = result.toStringFormat();
          legal.issueDate = result.toUtc();
        }
      },
    );

    final chuSoHuu = InputFieldModel<String>(
      label: chuSoHuuLabel,
      value: legal.owner,
      required: requiredChuSoHuu,
      onTextChanged: (newValue) => legal.owner = newValue,
    );

    final chuDauTu = InputFieldModel<String>(
      label: S.current.chu_dau_tu,
      data: legal.investor,
      onTextChanged: (newValue) => legal.investor = newValue,
    );

    final chiTiet = InputFieldModel<String>(
      label: S.current.chi_tiet,
      value: legal.details,
      onTextChanged: (newValue) => legal.details = newValue,
    );

    return ExpandModel(
      title: S.current.thong_tin_phap_ly,
      isExpand: false,
      generateTitleIndex: true,
      allowAdd: true,
      allowDelete: true,
      child: [],
      topLsInputField: [],
      removeExpandClicked: (context, ref, expandId) {
        removeLegal(assetCode, expandId, legal.id ?? '');
      },
      addNewExpandClicked: (context, ref, expandId) {
        addNewLegal(assetCode);
      },
      lsInputField: [
        tenHS,
        soHieu,
        donViCap,
        ngayCap,
        chuSoHuu,
        chuDauTu,
        chiTiet
      ],
    );
  }

  @override
  String get chuSoHuuLabel =>
      S.current.don_vi_nguoi_dung_ten_chu_quyen_hop_dong;

  @override
  bool get requiredChuSoHuu => false;
}
