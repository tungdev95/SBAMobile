import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/chcc_fast_valuation_model.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/assets/fast_valuation_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/dinhgianhanh/dinhgianhanh_map_page.dart';
import 'package:sba/src/screens/dinhgianhanh/ketqua_dinhgia_chcc_page.dart';
import 'package:sba/src/screens/dinhgianhanh/state/dinhgianhanh_chcc_page_state.dart';
import 'package:sba/src/services/api/assets_api.dart';
import 'package:sba/src/services/api/fast_valuation_api.dart';
import 'package:sba/src/services/api/map_api.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/utils/uuid.dart';
import 'package:sba/src/services/providers/asset_api_provider.dart' as asset;
import 'package:sba/src/services/providers/bds_api_provider.dart' as bds;
part 'dinhgianhanh_chcc_page_controller.g.dart';

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
Future<List<KeyValueModel>> getListAddress(
  GetListAddressRef ref,
  CHCCFastValModel landInfo,
) async {
  final districtSelected = ref.watch(selectedDistrictProvider(landInfo));
  final result = await ref
      .read(assetsApiProvider)
      .getListAddress(districtCode: districtSelected?.key ?? '');
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
    ref.listen(selectedDistrictProvider(landInfo), (previous, next) {
      keepAliveLink.close();
    });
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListDistrict(
  GetListDistrictRef ref,
  CHCCFastValModel landInfo,
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

@riverpod
Future<List<KeyValueModel>> getListDuAn(
    GetListDuAnRef ref, String? textSearch) async {
  final result =
      await ref.read(fastApiProvider).layDanhSachDuAnCHCC(name: textSearch);
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
    // ref.listen(selectedDuAn(landInfo), (previous, next) {
    //   if (previous?.key != next?.key) {
    //     keepAliveLink.close();
    //   }
    // });
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListToaNha(
    GetListToaNhaRef ref, CHCCFastValModel landInfo, String? textSearch) async {
  final projectSelected = ref.watch(selectedDuAn(landInfo));
  final result = await ref
      .read(fastApiProvider)
      .layDanhSachToaNha(projectId: projectSelected?.key, name: textSearch);
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
    ref.listen(selectedDuAn(landInfo), (previous, next) {
      if (previous?.key != next?.key) {
        keepAliveLink.close();
      }
    });
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListBlock(
    GetListBlockRef ref, CHCCFastValModel landInfo, String? textSearch) async {
  final projectSelected = ref.watch(selectedDuAn(landInfo));
  final buildingSelected = ref.watch(selectedToanNha(landInfo));
  final result = await ref.read(fastApiProvider).layDanhSachBlock(
        projectId: projectSelected?.key,
        buildingId: buildingSelected?.key,
        name: textSearch,
      );
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
    ref.listen(selectedToanNha(landInfo), (previous, next) {
      if (previous?.key != next?.key) {
        keepAliveLink.close();
      }
    });
  }
  return result.data ?? [];
}

//Selected Tỉnh
final selectedProvinceProvider =
    StateProvider.family<KeyValueModel?, CHCCFastValModel>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.addressProvince = next?.key;
      params.provinceId = next?.key;
      if (params.provinces?.code != params.provinceId) {
        params.provinces = Provinces(
          code: next?.key,
          name: next?.title,
          fullName: next?.title,
        );
      }

      if (previous == null && next != null) return;
      params.districtId = null;
      ref.read(selectedDistrictProvider(params).notifier).state = null;
    });
    if (params.provinceId == null) return null;

    return KeyValueModel(
      key: params.provinceId,
    );
  },
);

//Selected Phường xã
final selectedDistrictProvider =
    StateProvider.family<KeyValueModel?, CHCCFastValModel>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.addressDistrict = next?.key;
      params.districtId = next?.key;
      if (params.districts?.code != params.districtId) {
        params.districts = Districts(
          code: next?.key,
          name: next?.title,
          fullName: next?.title,
        );
      }
      if (previous == null && next != null) return;
      params.wardId = null;
      ref.read(selectedAddressProvider(params).notifier).state = null;
    });
    if (params.districtId == null) return null;

    return KeyValueModel(key: params.districtId, title: null);
  },
);

//Selected Quận huyện
final selectedAddressProvider =
    StateProvider.family<KeyValueModel?, CHCCFastValModel>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.wardId = next?.key;
      params.addressWard = next?.key;
      if (params.wards?.code != next?.key) {
        params.wards = Wards(
          code: next?.key,
          name: next?.title,
          fullName: next?.title,
        );
      }
    });
    if (params.wardId == null) return null;

    return KeyValueModel(key: params.wardId, title: null);
  },
);

//Selected Dự án
final selectedDuAn = StateProvider.family<KeyValueModel?, CHCCFastValModel>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.projectId = next?.key;
      params.projectName = next?.title;
      String? provinceId = next?.otherField?['provinceId'];
      String? districtId = next?.otherField?['districtId'];
      String? wardId = next?.otherField?['wardId'];
      if (provinceId != null) {
        ref.read(selectedProvinceProvider(params).notifier).state =
            KeyValueModel(key: provinceId);
      }
      if (districtId != null) {
        ref.read(selectedDistrictProvider(params).notifier).state =
            KeyValueModel(key: districtId);
      }
      if (wardId != null) {
        ref.read(selectedAddressProvider(params).notifier).state =
            KeyValueModel(key: wardId);
      }
      if (previous == null && next != null) return;
      ref.read(selectedToanNha(params).notifier).state = null;
    });
    if (params.projectId == null) return null;

    return KeyValueModel(key: params.projectId, title: params.projectName);
  },
);

//Selected Tòa nhà
final selectedToanNha = StateProvider.family<KeyValueModel?, CHCCFastValModel>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.buildingId = next?.key;
      params.building = next?.title;
      if (previous == null && next != null) return;
      ref.read(selectedBlock(params).notifier).state = null;
    });
    if (params.buildingId == null) return null;

    return KeyValueModel(key: params.buildingId, title: params.building);
  },
);

//Selected Block
final selectedBlock = StateProvider.family<KeyValueModel?, CHCCFastValModel>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.blockId = next?.key;
      params.block = next?.title;
    });
    if (params.blockId == null) return null;

    return KeyValueModel(key: params.blockId, title: params.block);
  },
);

class DinhGiaNhanhCHCCPageController
    extends BaseDetailInfoPageController<DinhGiaNhanhCHCCPageState> {
  DinhGiaNhanhCHCCPageController(super.state, super.ref);

  static final dinhGiaNhanhController = StateNotifierProvider.autoDispose
      .family<DinhGiaNhanhCHCCPageController, DinhGiaNhanhCHCCPageState,
          CHCCFastValModel>(
    (ref, arg) {
      return DinhGiaNhanhCHCCPageController(
        DinhGiaNhanhCHCCPageState(
          expandList: [],
          detailModel: arg,
        ),
        ref,
      );
    },
  );

  String sessionToken = Uuid().generateV4();

  @override
  Future<void> initialLoad() async {
    getAssetDetail();
  }

  void getAssetDetail() async {
    if ((state.detailModel.assetId ?? '').isEmpty) {
      initExpandModel();
      return;
    }
    showLoading();
    final result = await ref
        .read(fastApiProvider)
        .getDetailDinhGiaNhanhCHCC(iD: state.detailModel.assetId ?? '');
    result.data?.assetId = null;
    result.data?.roadInPriceRange = null;
    hideLoading();
    state = state.copyWith(detailModel: result.data);
    initExpandModel();
  }

  void initExpandModel() {
    ExpandModel thongTinThamDinh = generateThongTinThamDinh();

    ExpandModel dacDiemChungCu = generateDacDiemChungCu();

    state = state.copyWith(
      expandList: [
        thongTinThamDinh,
        dacDiemChungCu,
        getTienIch(),
      ],
    );
  }

  ExpandModel generateThongTinThamDinh() {
    return ExpandModel(
      title: 'Thông tin thẩm định',
      isExpand: true,
      child: [],
      lsInputField: [
        InputFieldModel<String>(
          label: S.current.thong_tin_khach_hang,
          data: state.detailModel.customerName,
          onTextChanged: (newValue) =>
              state.detailModel.customerName = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.so_cmt_cmnd,
          data: state.detailModel.customerIdentity,
          onTextChanged: (newValue) =>
              state.detailModel.customerIdentity = newValue,
        ),
      ],
      topLsInputField: [],
    );
  }

  ExpandModel generateDacDiemChungCu() {
    // final soSo = InputFieldModel<String>(
    //   label: S.current.so_so,
    //   data: state.detailModel.codeBook,
    //   onTextChanged: (newValue) => state.detailModel.codeBook = newValue,
    // );

    // final soToBanDo = InputFieldModel<String>(
    //   label: S.current.so_to_ban_do,
    //   data: state.detailModel.mapSheetNumber,
    //   onTextChanged: (newValue) {
    //     state.detailModel.mapSheetNumber = newValue;
    //   },
    // );

    final block = InputFieldModel<String>(
      label: S.current.block,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: selectedBlock(state.detailModel),
      listDataProvider: (p0) => p0.call(
        getListBlockProvider(state.detailModel, null),
      ),
      onChange: (newValue) {},
      // onTextChanged: (newValue) {
      //   state.detailModel.block = newValue;
      // },
    );

    final phamViBanKinh = InputFieldModel<double>(
      label: S.current.pham_vi_ban_kinh,
      data: state.detailModel.radius,
      onTextChanged: (newValue) {
        state.detailModel.radius = newValue;
      },
    );

    final tinhTP = InputFieldModel<String>(
      label: S.current.tinh_tp,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: selectedProvinceProvider(state.detailModel),
      listDataProvider: (p0) => p0.call(
        asset.getListProvinceProvider,
      ),
      required: true,
      firstLoadedItemCallBack: (p0) {
        state.detailModel.provinces = Provinces(
          code: p0?.key,
          name: p0?.title,
          fullName: p0?.title,
        );
      },
    );

    final quanHuyen = InputFieldModel<String>(
      label: S.current.tp_quan_huyen,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: selectedDistrictProvider(state.detailModel),
      required: true,
      listDataProvider: (p0) => p0.call(
        getListDistrictProvider(state.detailModel),
      ),
      onChange: (newValue) {
        // landInfo.realAddressDistrict = newValue?.key;
      },
      firstLoadedItemCallBack: (p0) {
        state.detailModel.districts = Districts(
          code: p0?.key,
          name: p0?.title,
          fullName: p0?.title,
        );
      },
    );

    final phuongXa = InputFieldModel<String>(
      label: S.current.xa_phuong_thi_tran,
      inputFieldType: InputFieldType.dropDown,
      required: true,
      selectedItemProvider: selectedAddressProvider(state.detailModel),
      listDataProvider: (p0) => p0.call(
        getListAddressProvider(state.detailModel),
      ),
      onChange: (newValue) {
        // landInfo.realAddressWard = newValue?.key;
      },
      firstLoadedItemCallBack: (p0) {
        state.detailModel.wards = Wards(
          code: p0?.key,
          name: p0?.title,
          fullName: p0?.title,
        );
      },
    );

    final duongPho = InputFieldModel<String>(
      label: S.current.duong_pho,
      data: state.detailModel.addressStreet,
      onTextChanged: (newValue) => state.detailModel.addressStreet = newValue,
    );

    final chiTiet = InputFieldModel<String>(
      label: S.current.chi_tiet,
      data: state.detailModel.addressDetail,
      onTextChanged: (newValue) => state.detailModel.addressDetail = newValue,
    );

    final toaDoX = InputFieldModel<double>(
      label: S.current.toa_do_x,
      data: state.detailModel.latitude,
      inputFormatter: const [],
      onTextChanged: (newValue) => state.detailModel.latitude = newValue,
    );

    final toaDoY = InputFieldModel<double>(
      label: S.current.toa_do_y,
      data: state.detailModel.longitude,
      inputFormatter: const [],
      onTextChanged: (newValue) => state.detailModel.longitude = newValue,
    );

    final layViTriButton = InputFieldModel<String>(
      inputFieldType: InputFieldType.custom,
      widgetBuilder: (context, ref, ontap, data) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: () {
                getCoordinate(
                  toaDoX,
                  toaDoY,
                );
              },
              icon: const Icon(Icons.edit_location_alt_rounded),
              label: Text(S.current.cap_nhat_toa_do),
            ),
            TextButton.icon(
              onPressed: () {
                xemBanDo(context, ref, toaDoX, toaDoY);
              },
              icon: const Icon(Icons.map),
              label: Text(S.current.xem_ban_do),
            ),
          ],
        );
      },
    );

    final toaNhaThucTe = InputFieldModel<String>(
      label: S.current.toa_nha_thuc_te,
      inputFieldType: InputFieldType.dropDown,
      listDataProvider: (p0) => p0.call(
        getListToaNhaProvider(state.detailModel, null),
      ),
      selectedItemProvider: selectedToanNha(state.detailModel),
      onChange: (newValue) {},
    );

    final tenChungCuDuAn = InputFieldModel<String>(
      label: S.current.ten_cc_du_an,
      selectedValue: null,
      inputFieldType: InputFieldType.dropDown,
      required: true,
      listDataProvider: (p0) => p0.call(
        getListDuAnProvider(null),
      ),
      selectedItemProvider: selectedDuAn(state.detailModel),
      // onTextChanged: (newValue) {
      //   state.detailModel.projectName = newValue;
      // },
      onChange: (newValue) {},
    );

    final soTang = InputFieldModel<int>(
      label: S.current.so_tang_toa_nha,
      selectedValue: null,
      required: true,
      data: state.detailModel.totalFloor,
      onTextChanged: (newValue) => state.detailModel.totalFloor = newValue,
    );

    final viTri = InputFieldModel<String>(
      label: S.current.vi_tri,
      inputFieldType: InputFieldType.dropDown,
      listDataProvider: (p0) => p0.call(bds.getPositionProvider),
      selectedValue: state.detailModel.positionId == null
          ? null
          : KeyValueModel(id: state.detailModel.positionId),
      onChange: (newValue) {
        state.detailModel.positionId = newValue?.id;
      },
    );

    final soPhongBep = InputFieldModel<int>(
      label: S.current.so_phong_bep,
      data: state.detailModel.kitchens,
      onTextChanged: (newValue) => state.detailModel.kitchens = newValue,
    );

    // final dienTich = InputFieldModel<double>(
    //   label: S.current.dien_tich,
    //   data: state.detailModel.areaWidth,
    //   onTextChanged: (newValue) => state.detailModel.areaWidth = newValue,
    // );

    final dienTichSuDungRieng = InputFieldModel<double>(
      label: S.current.dien_tich_sd_rieng,
      data: state.detailModel.privateUseArea,
      required: true,
      onTextChanged: (newValue) => state.detailModel.privateUseArea = newValue,
    );

    final dienTichThongThuy = InputFieldModel<double>(
      label: S.current.dien_tich_thong_thuy,
      data: state.detailModel.clearanceArea,
      onTextChanged: (newValue) => state.detailModel.clearanceArea = newValue,
    );

    final dienTichTimTuong = InputFieldModel<double>(
      label: S.current.dien_tich_tim_tuong,
      data: state.detailModel.buildupArea,
      onTextChanged: (newValue) => state.detailModel.buildupArea = newValue,
    );

    final dienTichCoiNoi = InputFieldModel<double>(
      label: S.current.dien_tich_coi_noi,
      data: state.detailModel.extendArea,
      onTextChanged: (newValue) => state.detailModel.extendArea = newValue,
    );

    final tangSo = InputFieldModel<int>(
      label: S.current.tang_so,
      data: state.detailModel.floorNo,
      required: true,
      onTextChanged: (newValue) => state.detailModel.floorNo = newValue,
    );

    final soPhongNgu = InputFieldModel<int>(
      label: S.current.so_phong_ngu,
      data: state.detailModel.bedrooms,
      onTextChanged: (newValue) => state.detailModel.bedrooms = newValue,
    );

    final soPhongWC = InputFieldModel<int>(
      label: S.current.so_phong_wc,
      data: state.detailModel.toilets,
      onTextChanged: (newValue) => state.detailModel.toilets = newValue,
    );

    final soMatThoang = InputFieldModel<int>(
      label: S.current.so_mat_thoang,
      selectedValue: state.detailModel.surfaces != null
          ? KeyValueModel(
              id: state.detailModel.surfaces,
              title: state.detailModel.surfaces.toString(),
            )
          : null,
      lsDropDown: [
        KeyValueModel(id: 1, title: '1'),
        KeyValueModel(id: 2, title: '2'),
        KeyValueModel(id: 3, title: '3'),
        KeyValueModel(id: 4, title: '4'),
      ],
      inputFieldType: InputFieldType.dropDown,
      required: true,
      onChange: (p0) => state.detailModel.surfaces = p0?.id,
    );

    final noiThat = InputFieldModel<String>(
      label: S.current.noi_that,
      data: state.detailModel.furniture,
      onTextChanged: (newValue) => state.detailModel.furniture = newValue,
    );

    return ExpandModel(
      title: S.current.dac_diem_chung_cu,
      isExpand: true,
      child: [],
      lsInputField: [
        tenChungCuDuAn,
        toaNhaThucTe,
        block,
        soTang,
        phamViBanKinh,
        tinhTP,
        quanHuyen,
        phuongXa,
        duongPho,
        chiTiet,
        layViTriButton,
        toaDoX,
        toaDoY,
        soMatThoang,
        tangSo,
        dienTichThongThuy,
        dienTichSuDungRieng,
        dienTichTimTuong,
        dienTichCoiNoi,
      ],
      topLsInputField: [],
    );
  }

  void getCoordinate(
      InputFieldModel<double> toaDoX, InputFieldModel<double> toaDoY) async {
    final detail = state.detailModel;
    String location = [
      detail.addressDetail,
      detail.addressStreet,
      detail.wards?.name,
      detail.districts?.name,
      detail.provinces?.name
    ].where((element) => (element ?? '').isNotEmpty).join(',');

    final result = await ref
        .read(mapApiProvider)
        .getLocationFromInput(location, sessionToken);

    if (result != null) {
      toaDoX.updateText?.call(result.latitude.toString().replaceAll('.', ','));
      toaDoY.updateText?.call(result.longitude.toString().replaceAll('.', ','));
    }

    // log('OKOK');
  }

  void xemBanDo(
    BuildContext context,
    WidgetRef ref,
    InputFieldModel<double> toaDoX,
    InputFieldModel<double> toaDoY,
  ) async {
    LatLng? result = await AppRoutes.push(
      context,
      ProviderScope(
        overrides: [
          detailDinhGiaItem.overrideWithValue(state.detailModel),
        ],
        child: DinhGiaNhanhMapPage(),
      ),
    );
    if (result != null) {
      toaDoX.updateText?.call(result.latitude.toString().replaceAll('.', ','));
      toaDoY.updateText?.call(result.longitude.toString().replaceAll('.', ','));
    }
  }

  void chiTietDinhGia(BuildContext context) async {
    final isOk = detailKey.currentState?.validate();
    if (isOk == false) return;
    showLoading();
    final result = await ref.read(fastApiProvider).getFastValuationInfoCHCC(
          body: state.detailModel,
        );
    hideLoading();
    handleResponse(result, (data) async {
      if (data == null || data.data.isEmpty) return;
      final firstItem = data.data.first;

      state.detailModel
        ..details = data.data
        ..value = data.value
        ..isNew = true;

      AppRoutes.pushReplacement(
        context,
        ProviderScope(
          overrides: [
            ketQuaDinhGiaNhanhCHCCItem.overrideWithValue(state.detailModel)
          ],
          child: const KetQuaDinhGiaNhanhCHCCPage(),
        ),
      );
    });
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
            final element = state.detailModel;
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
                  S.current.sanh_le_tan,
                  element.receptionHall,
                  (newValue) {
                    element.updateUtils(
                      newValue,
                      UtilitiesApartment.receptionHall.name,
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
                  S.current.khu_thuong_mai,
                  element.commercialServiceArea,
                  (newValue) {
                    element.updateUtils(
                      newValue,
                      UtilitiesApartment.commercialServiceArea.name,
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
