import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/chcc_info.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/services/api/assets_api.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/screens/assets/controller/chcc/chcc_detail_page_controller.dart'
    as parent;

part 'detail_chcc_page_controller.g.dart';

@riverpod
Future<List<KeyValueModel>> getListPosition(GetListPositionRef ref) async {
  final result = await ref.read(assetsApiProvider).getPosition();
  if (result.data?.isNotEmpty == true) {
    ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getMucDichSuDungSBA(
    GetMucDichSuDungSBARef ref) async {
  final result = await ref.read(assetsApiProvider).getUsingPurpose(
        taiSanCap2Id: AssetsTypeEnum.bds.assetsLevel2Id,
      );
  if (result.data?.isNotEmpty == true) {
    final keepAlive = ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListProvince(GetListProvinceRef ref) async {
  final result = await ref.read(assetsApiProvider).getListProvince();
  if (result.data?.isNotEmpty == true) {
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
  final result = await ref
      .read(assetsApiProvider)
      .getListDistrict(provinceCode: provinceSelected?.key ?? '');
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
    ref.listen(selectedProvinceProvider(chccInfo), (previous, next) {
      if (previous?.key != next?.key) {
        keepAliveLink.close();
      }
    });
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
      if (previous?.key != next?.key) {
        keepAliveLink.close();
      }
    });
  }
  return result.data ?? [];
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

class DetailCHCCPageController
    extends BaseDetailInfoPageController<DetailCHCCState> {
  DetailCHCCPageController(super.state, super.ref);

  static final chccInfoProvider = StateNotifierProvider.autoDispose
      .family<DetailCHCCPageController, DetailCHCCState, DetailCHCCData>(
    (ref, element) {
      final controller = DetailCHCCPageController(
        DetailCHCCState(
            chccInfo: element.chccInfo, detailModel: element.detailModel),
        ref,
      );
      return controller;
    },
  );

  @override
  Future<void> initialLoad() async {
    // return super.initialLoad();
    final lsExpand = <ExpandModel>[];
    final chccInfo = state.chccInfo;
    chccInfo.isHopKhoi = state.detailModel.combinePrivateArea != null;
    ExpandModel thongTinThuaDat = ExpandModel(
      key: '$phapLyThucTe-canHo',
      title: S.current.thong_tin_can_ho,
      isExpand: false,
      topLsInputField: [
        InputFieldModel<String>(
            label: S.current.so_thua,
            value: chccInfo.landPlotNumber,
            onTextChanged: (newValue) => chccInfo.landPlotNumber = newValue),
        InputFieldModel<String>(
            label: S.current.so_to_ban_do,
            value: chccInfo.mapSheetNumber,
            onTextChanged: (newValue) => chccInfo.mapSheetNumber = newValue),
      ],
      child: [
        generatelandInfo(chccInfo),
        generateRealLandInfo(chccInfo),
      ],
      lsInputField: [
        InputFieldModel<String>(
          label: S.current.toa_nha_thuc_te,
          data: chccInfo.realBuilding,
          onTextChanged: (p0) => chccInfo.realBuilding = p0,
        ),
        InputFieldModel<String>(
          label: S.current.ten_cc_du_an,
          data: chccInfo.nameBuilding,
          required: true,
          onTextChanged: (p0) => chccInfo.nameBuilding = p0,
        ),
        InputFieldModel<int>(
          label: S.current.so_tang,
          data: chccInfo.numberFloors,
          onTextChanged: (p0) => chccInfo.numberFloors = p0,
        ),
        InputFieldModel<int>(
          label: S.current.so_tang_ham,
          data: chccInfo.numberBasement,
          onTextChanged: (p0) => chccInfo.numberBasement = p0,
        ),
        InputFieldModel<String>(
          label: S.current.vi_tri,
          inputFieldType: InputFieldType.dropDown,
          required: true,
          listDataProvider: (p0) => p0.call(getListPositionProvider),
          selectedValue: chccInfo.positionId == null
              ? null
              : KeyValueModel(key: chccInfo.positionId.toString()),
          onChange: (newValue) {
            chccInfo.positionId = int.tryParse(newValue?.key ?? '');
          },
        ),
        InputFieldModel<double>(
          label: S.current.do_rong_duong_chinh,
          data: chccInfo.mainRoadWith,
          onTextChanged: (p0) => chccInfo.mainRoadWith = p0,
        ),
        InputFieldModel<String>(
          label: S.current.mo_ta_chi_tiet_vi_tri,
          data: chccInfo.description,
          required: true,
          minLines: 4,
          maxLines: 4,
          onTextChanged: (p0) => chccInfo.description = p0,
        ),
        InputFieldModel<double>(
          label: S.current.tong_dien_tich_chung_cu,
          data: chccInfo.totalApartmentArea,
          onTextChanged: (p0) => chccInfo.totalApartmentArea = p0,
        ),
        InputFieldModel<String>(
          label: S.current.hinh_thuc_su_dung,
          data: chccInfo.uses,
          onTextChanged: (p0) => chccInfo.uses = p0,
        ),
        InputFieldModel<String>(
          label: S.current.muc_dich_theo_sba,
          selectedValue: KeyValueModel(
            key: chccInfo.usingPurposeTypeId?.toString(),
          ),
          inputFieldType: InputFieldType.dropDown,
          listDataProvider: (p0) => p0.call(getMucDichSuDungSBAProvider),
          onChange: (newValue) =>
              chccInfo.usingPurposeTypeId = newValue?.key ?? '',
        ),
        InputFieldModel<String>(
          label: S.current.thoi_han_su_dung_dat,
          data: chccInfo.termOfLandUse,
          onTextChanged: (p0) => chccInfo.termOfLandUse = p0,
        ),
      ],
    );

    ExpandModel dacDiemCanHo = ExpandModel(
      key: '$phapLyThucTe-dacDiemCanHo',
      title: S.current.dac_diem_can_ho,
      isExpand: false,
      child: [
        listDacTiemThuaDatPhapLy(chccInfo),
        listDacTiemThuaDatThucTe(chccInfo)
      ],
      copyLegalToFactual: () {
        copyCanHoPhapLySangThucTe(chccInfo);
      },
      lsInputField: const [],
      topLsInputField: [],
    );

    ExpandModel hopKhoi = thongTinHopKhoi();

    ExpandModel tienIch = getTienIch();

    lsExpand.add(thongTinThuaDat);
    lsExpand.add(dacDiemCanHo);
    lsExpand.add(tienIch);
    lsExpand.add(hopKhoi);

    state = state.copyWith(expandList: lsExpand);

    if (chccInfo.isHopKhoi) {
      updateHopKhoi(true);
    }
  }

  ///Thông CHCC pháp lý
  ExpandModel generatelandInfo(CHCCInfo landInfo) {
    final tinhTP = InputFieldModel<String>(
      label: S.current.tinh_tp,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: selectedProvinceProvider(landInfo),
      listDataProvider: (p0) => p0.call(
        getListProvinceProvider,
      ),
      onChange: (newValue) {
        landInfo.legalAddressProvince = newValue?.key;
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
        landInfo.legalAddressDistrict = newValue?.key;
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
        landInfo.legalAddressWard = newValue?.key;
      },
    );

    final duongPho = InputFieldModel<String>(
        label: S.current.duong_pho,
        value: landInfo.legalAddressStreet,
        onTextChanged: (newValue) => landInfo.legalAddressStreet = newValue);

    final chiTiet = InputFieldModel<String>(
        label: S.current.chi_tiet,
        value: landInfo.legalAddressDetail,
        onTextChanged: (newValue) => landInfo.legalAddressDetail = newValue);

    return ExpandModel(
      title: '',
      isExpand: false,
      child: [],
      lsInputField: [
        tinhTP,
        quanHuyen,
        phuongXa,
        duongPho,
        chiTiet,
      ],
      topLsInputField: [],
    );
  }

  ///Thông tin CHCC thực tế
  ExpandModel generateRealLandInfo(CHCCInfo landInfo) {
    final tinhTP = InputFieldModel<String>(
      label: S.current.tinh_tp,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: parent.selectedProvinceProvider(landInfo),
      listDataProvider: (p0) => p0.call(
        parent.getListProvinceProvider,
      ),
      required: true,
      enable: false,
    );

    final quanHuyen = InputFieldModel<String>(
      label: S.current.tp_quan_huyen,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: parent.selectedDistrictProvider(landInfo),
      listDataProvider: (p0) => p0.call(
        parent.getListDistrictProvider(landInfo),
      ),
      enable: false,
    );

    final phuongXa = InputFieldModel<String>(
      label: S.current.xa_phuong_thi_tran,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: parent.selectedAddressProvider(landInfo),
      listDataProvider: (p0) => p0.call(
        parent.getListAddressProvider(landInfo),
      ),
      enable: false,
    );

    final duongPho = InputFieldModel<String>(
      label: S.current.duong_pho,
      value: landInfo.realAddressStreet,
      onTextChanged: (newValue) => landInfo.realAddressStreet = newValue,
      enable: false,
    );

    final chiTiet = InputFieldModel<String>(
      label: S.current.chi_tiet,
      value: landInfo.realAddressDetail,
      onTextChanged: (newValue) => landInfo.realAddressDetail = newValue,
      enable: false,
    );

    return ExpandModel(
      title: '',
      isExpand: false,
      child: const [],
      lsInputField: [
        tinhTP,
        quanHuyen,
        phuongXa,
        duongPho,
        chiTiet,
      ],
      topLsInputField: [],
    );
  }

  ExpandModel listDacTiemThuaDatPhapLy(CHCCInfo chccInfo) {
    return ExpandModel(
      title: '',
      isExpand: false,
      child: const [],
      lsInputField: [
        InputFieldModel<String>(
          label: S.current.ma_can_ho,
          data: chccInfo.legalApartmentCode,
          onTextChanged: (p0) => chccInfo.legalApartmentCode = p0,
        ),
        InputFieldModel<int>(
          label: S.current.tang_so,
          data: chccInfo.legalFloorNo,
          onTextChanged: (p0) => chccInfo.legalFloorNo = p0,
        ),
        InputFieldModel<int>(
          label: S.current.so_phong_ngu,
          data: chccInfo.legalNumberBedroom,
          onTextChanged: (p0) => chccInfo.legalNumberBedroom = p0,
        ),
        InputFieldModel<int>(
          label: S.current.so_phong_wc,
          data: chccInfo.legalNumberToilets,
          onTextChanged: (p0) => chccInfo.legalNumberToilets = p0,
        ),
        InputFieldModel<String>(
          label: S.current.noi_that,
          data: chccInfo.legalFurniture,
          onTextChanged: (p0) => chccInfo.legalFurniture = p0,
          maxLength: 1500,
          minLines: 4,
          maxLines: 4,
        ),
        InputFieldModel<int>(
          label: S.current.so_mat_thoang,
          data: chccInfo.legalFacades,
          onTextChanged: (p0) => chccInfo.legalFacades = p0,
        ),
        InputFieldModel<String>(
          label: S.current.huong_ban_cong_ching,
          data: chccInfo.legalMainBalconyDirection,
          onTextChanged: (p0) => chccInfo.legalMainBalconyDirection = p0,
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_sd_rieng,
          data: chccInfo.legalPrivateUseArea,
          onTextChanged: (p0) => chccInfo.legalPrivateUseArea = p0,
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_thong_thuy,
          data: chccInfo.legalClearanceArea,
          onTextChanged: (p0) => chccInfo.legalClearanceArea = p0,
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_tim_tuong,
          data: chccInfo.legalBuildupArea,
          onTextChanged: (p0) => chccInfo.legalBuildupArea = p0,
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_coi_noi,
          data: chccInfo.legalExtendArea,
          onTextChanged: (p0) => chccInfo.legalExtendArea = p0,
        ),
        InputFieldModel<String>(
          label: S.current.hien_trang_su_dung_rieng,
          data: chccInfo.legalCurrentPrivateUsing,
          onTextChanged: (p0) => chccInfo.legalCurrentPrivateUsing = p0,
        ),
      ],
      topLsInputField: [],
    );
  }

  ExpandModel listDacTiemThuaDatThucTe(CHCCInfo chccInfo) {
    return ExpandModel(
      title: '',
      isExpand: false,
      child: const [],
      lsInputField: [
        InputFieldModel<String>(
          label: S.current.ma_can_ho,
          data: chccInfo.realApartmentCode,
          required: true,
          onTextChanged: (p0) => chccInfo.realApartmentCode = p0,
        ),
        InputFieldModel<int>(
          label: S.current.tang_so,
          data: chccInfo.realFloorNo,
          required: true,
          onTextChanged: (p0) => chccInfo.realFloorNo = p0,
        ),
        InputFieldModel<int>(
          label: S.current.so_phong_ngu,
          data: chccInfo.realNumberBedroom,
          onTextChanged: (p0) => chccInfo.realNumberBedroom = p0,
        ),
        InputFieldModel<int>(
          label: S.current.so_phong_wc,
          data: chccInfo.realNumberToilets,
          onTextChanged: (p0) => chccInfo.realNumberToilets = p0,
        ),
        InputFieldModel<String>(
          label: S.current.noi_that,
          data: chccInfo.realFurniture,
          required: true,
          onTextChanged: (p0) => chccInfo.realFurniture = p0,
          maxLength: 1500,
          minLines: 4,
          maxLines: 4,
        ),
        InputFieldModel<int>(
          label: S.current.so_mat_thoang,
          data: chccInfo.realFacades,
          onTextChanged: (p0) => chccInfo.realFacades = p0,
        ),
        InputFieldModel<String>(
          label: S.current.huong_ban_cong_ching,
          data: chccInfo.realMainBalconyDirection,
          onTextChanged: (p0) => chccInfo.realMainBalconyDirection = p0,
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_sd_rieng,
          data: chccInfo.realPrivateUseArea,
          required: true,
          onTextChanged: (p0) => chccInfo.realPrivateUseArea = p0,
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_thong_thuy,
          data: chccInfo.realClearanceArea,
          onTextChanged: (p0) => chccInfo.realClearanceArea = p0,
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_tim_tuong,
          data: chccInfo.realBuildupArea,
          onTextChanged: (p0) => chccInfo.realBuildupArea = p0,
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_coi_noi,
          data: chccInfo.realExtendArea,
          onTextChanged: (p0) => chccInfo.realExtendArea = p0,
        ),
        InputFieldModel<String>(
          label: S.current.hien_trang_su_dung_rieng,
          data: chccInfo.realCurrentPrivateUsing,
          onTextChanged: (p0) => chccInfo.realCurrentPrivateUsing = p0,
        ),
      ],
      topLsInputField: [],
    );
  }

  void copyCanHoPhapLySangThucTe(CHCCInfo item) {
    item
      ..realApartmentCode = item.legalApartmentCode
      ..realNumberBedroom = item.legalNumberBedroom
      ..realFloorNo = item.legalFloorNo
      ..realNumberToilets = item.legalNumberToilets
      ..realFurniture = item.legalFurniture
      ..realFacades = item.legalFacades
      ..realMainBalconyDirection = item.legalMainBalconyDirection
      ..realPrivateUseArea = item.legalPrivateUseArea
      ..realClearanceArea = item.legalClearanceArea
      ..realBuildupArea = item.legalBuildupArea
      ..realExtendArea = item.legalExtendArea
      ..realCurrentPrivateUsing = item.legalCurrentPrivateUsing;

    //dacDiemCanHo
    final dacDiemCanHoExpand = state.expandList.firstWhereOrNull(
        (element) => element.key?.contains('dacDiemCanHo') == true);

    dacDiemCanHoExpand?.child[1] = listDacTiemThuaDatThucTe(item);
    state = state.copyWith();
  }

  @override
  Future<bool> saveData() async {
    final isValid = await super.saveData();
    // if (isValid == true) {
    Navigator.of(context).pop(state.chccInfo);
    // }
    return true;
  }

  void updateHopKhoi(bool? isChecked) {
    state.chccInfo.isHopKhoi = isChecked ?? false;
    state = state.copyWith();
    initThongTinHopKhoi();
  }

  void initThongTinHopKhoi() {
    bool isChecked = state.chccInfo.isHopKhoi;
    final hopKhoiIndex =
        state.expandList.indexWhere((element) => element.key == hopKhoi);
    //
    state.detailModel.combinePrivateArea =
        state.detailModel.combinePrivateArea ??
            state.detailModel.dienTichSuDungRiengHopKhoi;

    if (isChecked == true) {
      state.expandList[hopKhoiIndex]
        ..isExpand = true
        ..lsInputField = [
          InputFieldModel<double>(
            label: S.current.dien_tich_sd_rieng,
            data: state.detailModel.combinePrivateArea,
            onTextChanged: (newValue) =>
                state.detailModel.combinePrivateArea = newValue,
          ),
          InputFieldModel<String>(
            label: S.current.ghi_chu,
            data: state.detailModel.combineNote,
            onTextChanged: (newValue) =>
                state.detailModel.combineNote = newValue,
            minLines: 4,
            maxLines: 4,
          ),
        ];
    } else {
      state.expandList[hopKhoiIndex].lsInputField = [];
    }
    state = state.copyWith();
  }

  ExpandModel thongTinHopKhoi() {
    return ExpandModel(
      key: hopKhoi,
      title: S.current.hop_khoi,
      isExpand: false,
      child: const [],
      lsInputField: const [],
      trailingExpandWidgetBuilder: (context, ref) {
        return CupertinoSwitch(
          activeColor: Theme.of(context).primaryColor,
          value: state.chccInfo.isHopKhoi,
          onChanged: (newValue) {
            updateHopKhoi(
              newValue,
            );
          },
        );
      },
      topLsInputField: [],
    );
  }

  ExpandModel getTienIch() {
    return ExpandModel(
      title: S.current.tien_ich,
      isExpand: true,
      child: [],
      lsInputField: [
        InputFieldModel<String>(
          inputFieldType: InputFieldType.custom,
          widgetBuilder: (context, ref, tap, data) {
            // final detail = element.asset;
            final element = state.chccInfo;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                checkBoxTienIch(
                  context,
                  S.current.ham_de_xe,
                  element.garage,
                  (newValue) {
                    element.updateUtils(
                      newValue,
                      UtilitiesApartment.garage.name,
                    );
                  },
                ),
                checkBoxTienIch(
                  context,
                  S.current.ho_boi,
                  element.pool,
                  (newValue) {
                    element.updateUtils(
                      newValue,
                      UtilitiesApartment.pool.name,
                    );
                  },
                ),
                checkBoxTienIch(
                  context,
                  S.current.cong_vien_noi_khu,
                  element.innerPark,
                  (newValue) {
                    element.updateUtils(
                      newValue,
                      UtilitiesApartment.innerPark.name,
                    );
                  },
                ),
                checkBoxTienIch(
                  context,
                  S.current.khu_thuong_mai,
                  element.commercialServiceArea,
                  (newValue) {
                    element.updateUtils(
                      newValue,
                      UtilitiesApartment.commercialServiceArea.name,
                    );
                  },
                ),
                checkBoxTienIch(
                  context,
                  S.current.thang_may,
                  element.elevator,
                  (newValue) {
                    element.updateUtils(
                      newValue,
                      UtilitiesApartment.elevator.name,
                    );
                  },
                ),
                checkBoxTienIch(
                  context,
                  S.current.benh_vien,
                  element.hospitalSchoolPreschool,
                  (newValue) {
                    element.updateUtils(
                      newValue,
                      UtilitiesApartment.hospitalSchoolPreschool.name,
                    );
                  },
                ),
                checkBoxTienIch(
                  context,
                  S.current.sanh_le_tan,
                  element.receptionHall,
                  (newValue) {
                    element.updateUtils(
                      newValue,
                      UtilitiesApartment.receptionHall.name,
                    );
                  },
                ),
              ],
            );
          },
        )
      ],
      topLsInputField: [],
    );
  }

  Widget checkBoxTienIch(BuildContext context, String title, bool? value,
      void Function(bool?)? onChanged) {
    return HookConsumer(builder: (context, ref, child) {
      final isCheck = useState(value ?? false);
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          isCheck.value = !isCheck.value;
          onChanged?.call(isCheck.value);
        },
        child: Row(
          children: [
            IgnorePointer(
              child: Checkbox(
                value: isCheck.value,
                onChanged: onChanged,
              ),
            ),
            Text(title),
          ],
        ),
      );
    });
  }
}
