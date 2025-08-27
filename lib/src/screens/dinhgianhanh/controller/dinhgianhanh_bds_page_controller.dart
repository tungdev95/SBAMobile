import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/fast_valuation_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/dinhgianhanh/dinhgianhanh_map_page.dart';
import 'package:sba/src/screens/dinhgianhanh/ketqua_dinhgia_bds_page.dart';
import 'package:sba/src/screens/dinhgianhanh/state/dinhgianhanh_page_state.dart';
import 'package:sba/src/services/api/assets_api.dart';
import 'package:sba/src/services/api/fast_valuation_api.dart';
import 'package:sba/src/services/api/map_api.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/utils/uuid.dart';
part 'dinhgianhanh_bds_page_controller.g.dart';

///Selected Loại CTXD
final selectedConstructionType =
    StateProvider.family<KeyValueModel?, FastValueConstruction>(
  (ref, params) {
    if (params.typeId == null) return null;
    ref.listenSelf((previous, next) {
      params.typeId = int.tryParse(next?.key ?? '');
      if (previous == null && next != null) return;

      params.nameId = null;
      params.name = null;
      ref.read(selectedDacTinh(params).notifier).state = null;
    });

    return KeyValueModel(key: params.typeId.toString(), title: null);
  },
);

final selectedDacTinh =
    StateProvider.family<KeyValueModel?, FastValueConstruction>(
  (ref, params) {
    if (params.typeId == null && params.name == null) return null;

    return KeyValueModel(key: params.nameId, title: params.name);
  },
);

@riverpod
Future<List<KeyValueModel>> getLoaiCTXD(GetLoaiCTXDRef ref) async {
  final result = await ref.read(assetsApiProvider).getConstructionType();
  if (result.data?.isNotEmpty == true) {
    final keepAlive = ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getDacTinhKyThuat(
    GetDacTinhKyThuatRef ref, FastValueConstruction value) async {
  final selectedLoai = ref.watch(selectedConstructionType(value));
  final result =
      await ref.read(fastApiProvider).getDacTinhKyThuat(iD: selectedLoai?.key);
  if (result?.isNotEmpty == true) {
    final keepAlive = ref.keepAlive();
    ref.listen(selectedConstructionType(value), (previous, next) {
      if (previous?.key != next?.key) {
        keepAlive.close();
      }
    });
  }
  return result ?? [];
}

@riverpod
Future<List<KeyValueModel>> getLoaiDuongTiepGiap(
    GetLoaiDuongTiepGiapRef ref) async {
  final result = await ref.read(assetsApiProvider).getLoaiDuongTiepGiap();
  if (result.data?.isNotEmpty == true) {
    final keepAlive = ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListPosition(GetListPositionRef ref) async {
  final result = await ref.read(assetsApiProvider).getPosition();
  if (result.data?.isNotEmpty == true) {
    ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getDoanDuongTrongKhungGia(
    GetDoanDuongTrongKhungGiaRef ref, FastValuationModel landInfo) async {
  final result = await ref
      .read(assetsApiProvider)
      .getRoadInPrice(provinceCode: landInfo.provinceId);
  if (result.data?.isNotEmpty == true) {
    final keepAlive = ref.keepAlive();
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
  if ((result.data ?? []).isNotEmpty) {
    ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListDistrict(
  GetListDistrictRef ref,
  FastValuationModel landInfo,
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
Future<List<KeyValueModel>> getListAddress(
  GetListAddressRef ref,
  FastValuationModel landInfo,
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

//Selected Tỉnh
final selectedProvinceProvider =
    StateProvider.family<KeyValueModel?, FastValuationModel>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.addressProvince = next?.key;
      params.provinceId = next?.key;
      params.provinces = Provinces(
        name: next?.title,
        fullName: next?.title,
      );
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
    StateProvider.family<KeyValueModel?, FastValuationModel>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.addressDistrict = next?.key;
      params.districtId = next?.key;
      params.districts = Districts(
        name: next?.title,
        fullName: next?.title,
      );
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
    StateProvider.family<KeyValueModel?, FastValuationModel>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.wards = Wards(
        name: next?.title,
        fullName: next?.title,
      );
      params.wardId = next?.key;
      params.addressWard = next?.key;
    });
    if (params.wardId == null) return null;

    return KeyValueModel(key: params.wardId, title: null);
  },
);

final selectedRoadInPrice =
    StateProvider.family<KeyValueModel?, FastValuationModel>(
  (ref, params) {
    if (params.roadInPriceRange == null && params.roadInPriceRangeId == null) {
      return null;
    }

    return KeyValueModel(
        key: params.roadInPriceRangeId.toString(),
        title: params.roadInPriceRange);
  },
);

class DinhGiaNhanhBDSPageController
    extends BaseDetailInfoPageController<DinhGiaNhanhPageState> {
  DinhGiaNhanhBDSPageController(super.state, super.ref);

  static final dinhGiaNhanhController = StateNotifierProvider.autoDispose
      .family<DinhGiaNhanhBDSPageController, DinhGiaNhanhPageState,
          FastValuationModel>(
    (ref, arg) {
      return DinhGiaNhanhBDSPageController(
        DinhGiaNhanhPageState(
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
        .getDetail(iD: state.detailModel.assetId ?? '');
    result.data?.assetId = null;
    result.data?.roadInPriceRange = null;
    hideLoading();
    state = state.copyWith(detailModel: result.data);
    initExpandModel();
  }

  void initExpandModel() {
    ExpandModel thongTinThamDinh = generateThongTinThamDinh();

    ExpandModel dacDiemThuaDat = generateDacDiemThuaDat();

    ExpandModel congTrinhXayDung = ExpandModel(
      key: ctxd,
      title: S.current.cong_trinh_xd,
      isExpand: true,
      child: [],
      lsInputField: [],
      topLsInputField: [],
    );

    if (state.detailModel.constructions.isEmpty) {
      state.detailModel.constructions.add(FastValueConstruction());
    }
    if (state.detailModel.constructions.isNotEmpty) {
      var lsChild = <ExpandModel>[];
      state.detailModel.constructions.forEachIndexed((index, element) {
        lsChild.add(generateCTXD(element));
      });
      congTrinhXayDung.child = lsChild;
    }

    state = state.copyWith(
      expandList: [
        thongTinThamDinh,
        dacDiemThuaDat,
        congTrinhXayDung,
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

  ExpandModel generateDacDiemThuaDat() {
    final soThua = InputFieldModel<String>(
      label: S.current.so_thua,
      data: state.detailModel.landPlotNumber,
      onTextChanged: (newValue) {
        state.detailModel.landPlotNumber = newValue;
      },
    );

    final soToBanDo = InputFieldModel<String>(
      label: S.current.so_to_ban_do,
      data: state.detailModel.mapSheetNumber,
      onTextChanged: (newValue) {
        state.detailModel.mapSheetNumber = newValue;
      },
    );

    final tinhTP = InputFieldModel<String>(
      label: S.current.tinh_tp,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: selectedProvinceProvider(state.detailModel),
      listDataProvider: (p0) => p0.call(
        getListProvinceProvider,
      ),
      required: true,
      onChange: (newValue) {
        // state.detailModel.realAddressProvince = newValue?.key;
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
      inputFormatter: [],
      onTextChanged: (newValue) => state.detailModel.latitude = newValue,
    );

    final toaDoY = InputFieldModel<double>(
      label: S.current.toa_do_y,
      data: state.detailModel.longitude,
      inputFormatter: [],
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
                getCoordinate(toaDoX, toaDoY);
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

    final dienTichKoPhuHopQH = InputFieldModel<double>(
      label: S.current.dien_tich_khong_phu_hop_quy_hoach,
      data: state.detailModel.areaUnplan,
      required: true,
      enable: false,
      onTextChanged: (newValue) => state.detailModel.areaUnplan = newValue,
    );

    final dienTichKhuonVien = InputFieldModel<double>(
      label: S.current.dien_tich_khuon_vien,
      data: state.detailModel.areaWidth,
      required: true,
      onTextChanged: (newValue) {
        state.detailModel.areaWidth = newValue;
        dienTichKoPhuHopQH.updateText?.call(
          tinhToanDienTichKhongPhuHopQuyHoach(
            state.detailModel.areaWidth,
            state.detailModel.areaInplan,
          ).text(),
        );
      },
    );

    final dienTichPhuHopQH = InputFieldModel<double>(
      label: S.current.dien_tich_phu_hop_quy_hoach,
      data: state.detailModel.areaInplan,
      required: true,
      onTextChanged: (newValue) {
        state.detailModel.areaInplan = newValue;
        dienTichKoPhuHopQH.updateText?.call(
          tinhToanDienTichKhongPhuHopQuyHoach(
            state.detailModel.areaWidth,
            state.detailModel.areaInplan,
          ).text(),
        );
      },
    );

    final mucDichSDDat = InputFieldModel<String>(
        label: S.current.muc_dich_sdung_dat,
        selectedValue: state.detailModel.usingPurposeId != null
            ? KeyValueModel(
                key: state.detailModel.usingPurposeId?.toString(),
              )
            : null,
        inputFieldType: InputFieldType.dropDown,
        required: true,
        listDataProvider: (p0) => p0.call(getMucDichSuDungSBAProvider),
        onChange: (newValue) => state.detailModel.usingPurposeId =
            int.tryParse(newValue?.key ?? ''));

    final hinhDang = InputFieldModel<String>(
      label: S.current.hinh_dang,
      data: state.detailModel.shape,
      onTextChanged: (newValue) => state.detailModel.shape = newValue,
    );

    final soMatTien = InputFieldModel<int>(
      label: S.current.so_mat_tien_mat_thoang,
      data: state.detailModel.numberOfFacade,
      onTextChanged: (newValue) => state.detailModel.numberOfFacade = newValue,
    );

    final phamViBanKinh = InputFieldModel<double>(
      label: S.current.pham_vi_ban_kinh,
      data: state.detailModel.radius,
      onTextChanged: (newValue) => state.detailModel.radius = newValue,
    );

    final kichThuocMatTien = InputFieldModel<double>(
      label: S.current.kich_thuoc_mat_tien,
      data: state.detailModel.facadeLength,
      onTextChanged: (newValue) => state.detailModel.facadeLength = newValue,
    );

    final doanDuongKhungGia = InputFieldModel<String>(
      label: S.current.doan_duong_trong_khung_gia,
      inputFieldType: InputFieldType.dropDown,
      listDataProvider: (p0) => p0.call(
        getDoanDuongTrongKhungGiaProvider(state.detailModel),
      ),
      selectedItemProvider: selectedRoadInPrice(state.detailModel),
      onChange: (newValue) {
        state.detailModel.roadInPriceRangeId =
            int.tryParse(newValue?.key ?? '');
        state.detailModel.roadInPriceRange = newValue?.title;
      },
    );

    final loaiDuongTiepGiap = InputFieldModel<String>(
      label: S.current.loai_duong_tiep_giap,
      inputFieldType: InputFieldType.dropDown,
      listDataProvider: (p0) => p0.call(
        getLoaiDuongTiepGiapProvider,
      ),
      selectedValue: state.detailModel.roadContiguousTypeId == null
          ? null
          : KeyValueModel(
              key: state.detailModel.roadContiguousTypeId.toString(),
            ),
      onChange: (newValue) {
        state.detailModel.roadContiguousTypeId =
            int.tryParse(newValue?.key ?? '');
      },
    );

    final viTri = InputFieldModel<String>(
      label: S.current.vi_tri,
      inputFieldType: InputFieldType.dropDown,
      listDataProvider: (p0) => p0.call(getListPositionProvider),
      selectedValue: state.detailModel.positionId == null
          ? null
          : KeyValueModel(key: state.detailModel.positionId.toString()),
      onChange: (newValue) {
        state.detailModel.positionId = int.tryParse(newValue?.key ?? '');
      },
    );
    final doRongDuong = InputFieldModel<double>(
      label: S.current.do_rong_duong,
      data: state.detailModel.widthToMainRoad,
      onTextChanged: (newValue) => state.detailModel.widthToMainRoad = newValue,
    );

    return ExpandModel(
      title: S.current.dac_diem_thua_dat,
      isExpand: true,
      child: [],
      lsInputField: [
        soThua,
        soToBanDo,
        tinhTP,
        quanHuyen,
        phuongXa,
        duongPho,
        chiTiet,
        layViTriButton,
        toaDoX,
        toaDoY,
        dienTichKhuonVien,
        dienTichPhuHopQH,
        dienTichKoPhuHopQH,
        mucDichSDDat,
        hinhDang,
        soMatTien,
        phamViBanKinh,
        kichThuocMatTien,
        doanDuongKhungGia,
        loaiDuongTiepGiap,
        viTri,
        doRongDuong
      ],
      topLsInputField: [],
    );
  }

  ExpandModel generateCTXD(FastValueConstruction item) {
    final donGia = InputFieldModel<double>(
      label: S.current.don_gia,
      data: item.unitPrice,
      isCurrency: true,
      enable: false,
      onTextChanged: (newValue) => item.unitPrice = newValue,
    );

    final giaTri = InputFieldModel<double>(
      label: S.current.gia_tri,
      data: item.value,
      isCurrency: true,
      enable: false,
      onTextChanged: (newValue) => item.value = newValue,
    );

    final loaiCTXD = InputFieldModel<String>(
      label: S.current.loai_ctxd,
      inputFieldType: InputFieldType.dropDown,
      listDataProvider: (p0) => p0.call(getLoaiCTXDProvider),
      selectedItemProvider: selectedConstructionType(item),
      onChange: (newValue) {
        item.typeId = int.tryParse(newValue?.key ?? '');
      },
    );

    final dacTinhKyThuat = InputFieldModel<String>(
      label: S.current.mo_ta_ky_thuat,
      inputFieldType: InputFieldType.dropDown,
      listDataProvider: (p0) => p0.call(getDacTinhKyThuatProvider(item)),
      selectedItemProvider: selectedDacTinh(item),
      onChange: (newValue) {
        final prop = ConstructionProps.fromJson(newValue?.otherField ?? {});
        item.nameId = newValue?.key;
        item.name = newValue?.title;
        item.unitPrice = prop.lowPrice;
        donGia.updateText?.call(prop.lowPrice.toPriceFormat());

        final newThanhTien =
            (prop.lowPrice ?? 0.0) * (item.area ?? 0.0) * (item.clcl ?? 0.0);
        giaTri.updateText?.call(newThanhTien.toPriceFormat());
      },
    );

    final dienTich = InputFieldModel<double>(
      label: S.current.dien_tich,
      data: item.area,
      onTextChanged: (newValue) {
        item.area = newValue;
        final newThanhTien =
            (item.unitPrice ?? 0) * (item.area ?? 0.0) * (item.clcl ?? 0.0);
        giaTri.updateText?.call(newThanhTien.toPriceFormat());
      },
    );

    final clcl = InputFieldModel<double>(
      label: S.current.clcl,
      data: item.clcl,
      onTextChanged: (newValue) {
        item.clcl = newValue;
        final newThanhTien =
            (item.unitPrice ?? 0) * (item.area ?? 0.0) * (item.clcl ?? 0.0);
        giaTri.updateText?.call(newThanhTien.toPriceFormat());
      },
    );

    final mdht = InputFieldModel<double>(
      label: S.current.mdht,
      data: item.mdht,
      onTextChanged: (newValue) => item.mdht = newValue,
    );

    return ExpandModel(
      title: S.current.cong_trinh_xd,
      generateTitleIndex: true,
      isExpand: false,
      allowAdd: true,
      allowDelete: true,
      child: const [],
      addNewExpandClicked: (context, ref, expandId) {
        addNewCTXD();
      },
      removeExpandClicked: (context, ref, expandId) {
        deleteCTXD(item.itemId ?? '', expandId);
      },
      lsInputField: [
        loaiCTXD,
        dacTinhKyThuat,
        dienTich,
        clcl,
        mdht,
        donGia,
        giaTri,
      ],
      topLsInputField: [],
    );
  }

  ///Thêm 1 CTXD mới
  void addNewCTXD() {
    FastValueConstruction newConstruction = FastValueConstruction();
    state.detailModel.constructions.add(newConstruction);
    final ctxdInput = generateCTXD(newConstruction);
    final parentIndex =
        state.expandList.indexWhere((element) => element.key == ctxd);
    state.detailModel.constructions.add(newConstruction);
    state.expandList[parentIndex].child.add(ctxdInput);
    state = state.copyWith();
  }

  ///Xóa CTXD
  void deleteCTXD(String constructionId, String expandId) {
    state.detailModel.constructions
        .removeWhere((e) => e.itemId == constructionId);
    final lsChild = [
      ...state.expandList.firstWhere((element) => element.key == ctxd).child
    ];

    state.expandList
        .firstWhere((element) => element.key == ctxd)
        .child
        .removeWhere((element) => element.id == expandId);

    state = state.copyWith();
  }

  void getCoordinate(
      InputFieldModel<double> toaDoX, InputFieldModel<double> toaDoY) async {
    final detail = state.detailModel;
    String location = [
      detail.addressDetail,
      detail.address,
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
    final result = await ref.read(fastApiProvider).getFastValuationInfo(
          body: state.detailModel,
        );
    hideLoading();
    handleResponse(result, (data) async {
      final losResult =
          await ref.read(fastApiProvider).findByLos(body: state.detailModel);
      state.detailModel
        ..valuations = data?.data ?? []
        ..estimatePrice = data?.value
        ..valuationIds = data?.data.map((e) => e.assetId ?? '').toList()
        ..logs = data?.logs ?? [];
      handleResponse(losResult, (p0) {
        if (p0 == null) return;
        state.detailModel
          ..totalValue = p0.totalValue
          ..roadInPriceRange = p0.roadInPriceRange
          ..landPrice = p0.landPrice
          ..constructionPrice = p0.constructionPrice
          ..address = p0.address
          ..areaUnPlanPrice = p0.areaUnPlanPrice
          ..areaInPlanPrice = p0.areaInPlanPrice
          ..areaInPlanValue = p0.areaInPlanValue
          ..isNew = true;
        AppRoutes.pushReplacement(
          context,
          ProviderScope(
            overrides: [
              ketQuaDinhGiaNhanhItem.overrideWithValue(state.detailModel)
            ],
            child: const KetQuaDinhGiaNhanhPage(),
          ),
        );
      });
    });
  }
}
