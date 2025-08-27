import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/services/api/assets_api.dart';
// import 'package:sba/src/screens/assets/controller/real_estate/real_estate_detail_page_controller.dart'
//     as parent;
import 'package:sba/src/services/providers/asset_api_provider.dart' as api;
import 'package:sba/src/services/providers/bds_api_provider.dart' as bds;
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/utils/validator_util.dart';
part 'detail_land_info_controller.g.dart';

@riverpod
Future<List<KeyValueModel>> getListCayTrong(GetListCayTrongRef ref) async {
  final result = await ref.read(assetsApiProvider).getTreeTypes();
  if (result.data?.isNotEmpty == true) {
    ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getHSPLCTXD(GetHSPLCTXDRef ref) async {
  final result = await ref.read(assetsApiProvider).getConstructionLegal();
  if (result.data?.isNotEmpty == true) {
    ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getTenCTXD(
    GetTenCTXDRef ref, ConstructionModel construction) async {
  final loaiCTXD = ref.watch(selectedConstructionType(construction))?.key;
  if (loaiCTXD == null) return [];
  final result = await ref
      .read(assetsApiProvider)
      .getConstructionName(constructionType: loaiCTXD);
  if (result.data?.isNotEmpty == true) {
    final keepAlive = ref.keepAlive();
    ref.listen(selectedConstructionType(construction), (previous, next) {
      if (previous?.key != next?.key) {
        keepAlive.close();
      }
    });
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getLoaiCTXD(GetLoaiCTXDRef ref) async {
  final result = await ref.read(assetsApiProvider).getConstructionType();
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
Future<List<KeyValueModel>> getDoanDuongTrongKhungGia(
    GetDoanDuongTrongKhungGiaRef ref, AssetLandInfo landInfo) async {
  final result = await ref
      .read(assetsApiProvider)
      .getRoadInPrice(provinceCode: landInfo.realAddressProvince);
  if (result.data?.isNotEmpty == true) {
    final keepAlive = ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListDistrict(
  GetListDistrictRef ref,
  AssetLandInfo landInfo,
) async {
  final provinceSelected = ref.watch(selectedProvinceProvider(landInfo));
  final result = await ref
      .read(assetsApiProvider)
      .getListDistrict(provinceCode: provinceSelected?.key ?? '');
  if (result.data?.isNotEmpty == true) {
    final keepAlive = ref.keepAlive();
    ref.listen(selectedProvinceProvider(landInfo), (previous, next) {
      if (previous?.key != next?.key) {
        keepAlive.close();
      }
    });
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListAddress(
  GetListAddressRef ref,
  AssetLandInfo landInfo,
) async {
  final districtSelected = ref.watch(selectedDistrictProvider(landInfo));
  final result = await ref
      .read(assetsApiProvider)
      .getListAddress(districtCode: districtSelected?.key ?? '');
  if (result.data?.isNotEmpty == true) {
    final keepAlive = ref.keepAlive();
    ref.listen(selectedDistrictProvider(landInfo), (previous, next) {
      if (previous?.key != next?.key) {
        keepAlive.close();
      }
    });
  }
  return result.data ?? [];
}

//Selected Tỉnh
final selectedProvinceProvider =
    StateProvider.family<KeyValueModel?, AssetLandInfo>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.legalAddressProvince = next?.key;
      if (previous == null && next != null) return;
      params.legalAddressDistrict = null;
      params.legalAddressWard = null;
      //reset phường xã
      ref.read(selectedDistrictProvider(params).notifier).state = null;
      //reset đoạn đường trong khung giá
      // ref.read(selectedRoadInPrice(params).notifier).state = null;
    });

    if (params.legalAddressProvince == null) return null;

    return KeyValueModel(key: params.legalAddressProvince, title: null);
  },
);

//Selected Phường xã
final selectedDistrictProvider =
    StateProvider.family<KeyValueModel?, AssetLandInfo>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.legalAddressDistrict = next?.key;
      if (previous == null && next != null) return;
      params.legalAddressWard = null;
      ref.read(selectedAddressProvider(params).notifier).state = null;
    });
    if (params.legalAddressDistrict == null) return null;

    return KeyValueModel(key: params.legalAddressDistrict, title: null);
  },
);

//Selected Quận huyện
final selectedAddressProvider =
    StateProvider.family<KeyValueModel?, AssetLandInfo>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.legalAddressWard = next?.key;
    });
    if (params.legalAddressWard == null) return null;

    return KeyValueModel(key: params.legalAddressWard, title: null);
  },
);

///Selected đoạn đường trong khung giá
final selectedRoadInPrice = StateProvider.family<KeyValueModel?, AssetLandInfo>(
  (ref, params) {
    if (params.roadInPriceRange == null) return null;

    return KeyValueModel(key: params.roadInPriceRange.toString(), title: null);
  },
);

///Selected Loại CTXD
final selectedConstructionType =
    StateProvider.family<KeyValueModel?, ConstructionModel>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      if (previous == null && next != null) return;
      params.constructionNameId = null;
      //reset tên công trình
      ref.read(selectedConstructionName(params).notifier).state = null;
    });
    if (params.constructionTypeId == null) return null;

    return KeyValueModel(
        key: params.constructionTypeId.toString(), title: null);
  },
);

///Selected Tên CTXD
final selectedConstructionName =
    StateProvider.family<KeyValueModel?, ConstructionModel>(
  (ref, params) {
    if (params.constructionNameId == null) return null;

    return KeyValueModel(
        key: params.constructionNameId.toString(), title: null);
  },
);

///Selected HSPL
final selectedConstructionLegal =
    StateProvider.family<KeyValueModel?, ConstructionModel>(
  (ref, params) {
    if (params.constructionLegalTypeId == null) return null;

    return KeyValueModel(
        key: params.constructionLegalTypeId.toString(), title: null);
  },
);

class DetailLandInfoPageController
    extends BaseDetailInfoPageController<DetailLandState> {
  DetailLandInfoPageController(super.state, super.ref);

  static final detailLandInfoProvider = StateNotifierProvider.autoDispose
      .family<DetailLandInfoPageController, DetailLandState, DetailData>(
    (ref, element) {
      final controller = DetailLandInfoPageController(
        DetailLandState(
          landInfo: element.landInfo,
          expandList: [],
          detailModel: element.detailModel,
        ),
        ref,
      );
      return controller;
    },
  );

  @override
  Future<void> initialLoad() async {
    final lsExpand = <ExpandModel>[];
    final landInfo = state.landInfo;
    ExpandModel thongTinThuaDat = ExpandModel(
      key: '$phapLyThucTe-thuaDat',
      title: S.current.thong_tin_thua_dat,
      isExpand: false,
      topLsInputField: [
        InputFieldModel<String>(
          label: S.current.so_thua,
          data: landInfo.landPlotNumber,
          onTextChanged: (newValue) => landInfo.landPlotNumber = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.so_to_ban_do,
          data: landInfo.mapSheetNumber,
          onTextChanged: (newValue) => landInfo.mapSheetNumber = newValue,
        ),
      ],
      child: [
        generatelandInfo(landInfo),
        generateRealLandInfo(landInfo),
      ],
      lsInputField: [
        InputFieldModel<String>(
          label: S.current.doan_duong_trong_khung_gia,
          inputFieldType: InputFieldType.dropDown,
          listDataProvider: (p0) => p0.call(
            getDoanDuongTrongKhungGiaProvider(landInfo),
          ),
          selectedItemProvider: selectedRoadInPrice(landInfo),
          onChange: (newValue) =>
              landInfo.roadInPriceRange = int.tryParse(newValue?.key ?? ''),
        ),
        InputFieldModel<String>(
          label: S.current.loai_duong_tiep_giap,
          inputFieldType: InputFieldType.dropDown,
          listDataProvider: (p0) => p0.call(
            bds.getLoaiDuongTiepGiapProvider,
          ),
          selectedValue: landInfo.roadContiguousTypeId == null
              ? null
              : KeyValueModel(
                  key: landInfo.roadContiguousTypeId.toString(),
                ),
          onChange: (newValue) {
            landInfo.roadContiguousTypeId = int.tryParse(newValue?.key ?? '');
          },
        ),
        InputFieldModel<String>(
          label: S.current.vi_tri,
          inputFieldType: InputFieldType.dropDown,
          listDataProvider: (p0) => p0.call(
            bds.getPositionProvider,
          ),
          selectedValue: landInfo.positionId == null
              ? null
              : KeyValueModel(
                  key: landInfo.positionId.toString(),
                ),
          onChange: (newValue) {
            landInfo.positionId = int.tryParse(newValue?.key ?? '');
          },
        ),
        InputFieldModel<String>(
          label: S.current.khu_vuc,
          inputFieldType: InputFieldType.dropDown,
          listDataProvider: (p0) => p0.call(
            bds.getZoneProvider,
          ),
          selectedValue: landInfo.zoneId == null
              ? null
              : KeyValueModel(
                  key: landInfo.zoneId.toString(),
                ),
          onChange: (newValue) {
            landInfo.zoneId = int.tryParse(newValue?.key ?? '');
          },
        ),
        InputFieldModel<double>(
          label: S.current.kc_den_duong_chinh,
          data: landInfo.distanceToMainRoad,
          onTextChanged: (newText) {
            landInfo.distanceToMainRoad = newText;
          },
        ),
        InputFieldModel<String>(
          label: S.current.vi_tri_trong_khung_gia,
          inputFieldType: InputFieldType.dropDown,
          listDataProvider: (p0) => p0.call(
            bds.getViTriTrongKhungGiaProvider,
          ),
          selectedValue: landInfo.positionInPriceRangeId == null
              ? null
              : KeyValueModel(
                  key: landInfo.positionInPriceRangeId.toString(),
                ),
          onChange: (newValue) => landInfo.positionInPriceRangeId =
              int.tryParse(newValue?.key ?? ''),
        ),
        InputFieldModel<double>(
          label: S.current.do_rong_duong_nn,
          data: landInfo.minWidthToMainRoad,
          onTextChanged: (newValue) => landInfo.minWidthToMainRoad = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.do_rong_duong_ln,
          data: landInfo.maxWidthToMainRoad,
          onTextChanged: (newValue) => landInfo.maxWidthToMainRoad = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.mo_ta_chi_tiet_vi_tri,
          data: landInfo.note,
          maxLines: 10,
          // enable: false,
          readOnly: true,
          required: false,
        ),
      ],
    );
    ExpandModel dacDiemThuaDat = ExpandModel(
      key: '$phapLyThucTe-dacDiemThuaDat',
      title: S.current.dac_diem_thua_dat,
      isExpand: false,
      child: [
        listDacTiemThuaDatPhapLy(landInfo),
        listDacTiemThuaDatThucTe(landInfo)
      ],
      copyLegalToFactual: () {
        copyThuaDatPhapLySangThucTe(landInfo);
      },
      lsInputField: [],
      topLsInputField: [],
    );

    ExpandModel mucDichSuDung = ExpandModel(
      key: mucDichSDDat,
      title: S.current.muc_dich_sd,
      isExpand: true,
      child: const [],
      lsInputField: const [],
      trailingExpandWidgetBuilder: (context, ref) {
        return CupertinoSwitch(
          activeColor: Theme.of(context).primaryColor,
          value: state.landInfo.haveLandingPurpose,
          onChanged: (newValue) {
            toggleMucDichSuDungDat(newValue);
          },
        );
      },
      topLsInputField: const [],
    );

    if (landInfo.assetLandUsingPurposes.isNotEmpty) {
      var lsChild = <ExpandModel>[];
      landInfo.assetLandUsingPurposes.forEachIndexed((index, element) {
        lsChild.add(generateMucDichSDDat(element));
      });
      mucDichSuDung.child = lsChild;
    }

    ExpandModel cayTrong = generateGroupCayTrong();

    ExpandModel congTrinhXayDung = generateGroupCTXD();

    ExpandModel hopThua = thongTinHopThua();

    lsExpand.add(thongTinThuaDat);
    lsExpand.add(dacDiemThuaDat);
    lsExpand.add(mucDichSuDung);
    lsExpand.add(cayTrong);
    lsExpand.add(congTrinhXayDung);
    lsExpand.add(hopThua);

    state = state.copyWith(expandList: lsExpand);

    if (landInfo.haveLandingPurpose == true) {
      toggleMucDichSuDungDat(true);
    }
    if (landInfo.haveCayTrong == true) {
      toggleCayTrong(true);
    }
    if (landInfo.haveCTXD == true) {
      toggleCTXD(true);
    }

    updateHopThua(state.landInfo.isConsolidation);
  }

  ///Thông tin thửa đất pháp lý
  ExpandModel generatelandInfo(AssetLandInfo landInfo) {
    final tinhTP = InputFieldModel<String>(
      label: S.current.tinh_tp,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: selectedProvinceProvider(landInfo),
      listDataProvider: (p0) => p0.call(
        api.getListProvinceProvider,
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
        data: landInfo.legalAddressStreet,
        onTextChanged: (newValue) => landInfo.legalAddressStreet = newValue);

    final chiTiet = InputFieldModel<String>(
        label: S.current.chi_tiet,
        data: landInfo.legalAddressDetail,
        onTextChanged: (newValue) => landInfo.legalAddressDetail = newValue);

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

  ///Thông tin thửa đất thực tế - không cho edit
  ExpandModel generateRealLandInfo(AssetLandInfo landInfo) {
    final tinhTP = InputFieldModel<String>(
      label: S.current.tinh_tp,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: bds.selectedProvinceProvider(landInfo),
      listDataProvider: (p0) => p0.call(
        api.getListProvinceProvider,
      ),
      enable: false,
    );

    final quanHuyen = InputFieldModel<String>(
      label: S.current.tp_quan_huyen,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: bds.selectedDistrictProvider(landInfo),
      listDataProvider: (p0) => p0.call(
        bds.getListDistrictProvider(landInfo),
      ),
      enable: false,
    );

    final phuongXa = InputFieldModel<String>(
      label: S.current.xa_phuong_thi_tran,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: bds.selectedAddressProvider(landInfo),
      listDataProvider: (p0) => p0.call(
        bds.getListAddressProvider(landInfo),
      ),
      enable: false,
    );

    final duongPho = InputFieldModel<String>(
      label: S.current.duong_pho,
      data: landInfo.realAddressStreet,
      onTextChanged: (newValue) => landInfo.realAddressStreet = newValue,
      enable: false,
    );

    final chiTiet = InputFieldModel<String>(
      label: S.current.chi_tiet,
      data: landInfo.realAddressDetail,
      onTextChanged: (newValue) => landInfo.realAddressDetail = newValue,
      enable: false,
    );

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

  /// Đặc điểm thửa đất pháp lý
  ExpandModel listDacTiemThuaDatPhapLy(AssetLandInfo landInfo) {
    final dienTichKoPhuHopQuyHoach = InputFieldModel<double>(
      label: S.current.dien_tich_khong_phu_hop_quy_hoach,
      data: landInfo.legalAreaUnPlan,
      enable: false,
      onTextChanged: (newValue) => landInfo.legalAreaUnPlan = newValue,
    );
    return ExpandModel(
      title: '',
      isExpand: false,
      child: const [],
      lsInputField: [
        InputFieldModel<String>(
          label: S.current.huong_chinh,
          data: landInfo.legalMainDirection,
          onTextChanged: (newValue) => landInfo.legalMainDirection = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.hinh_dang,
          data: landInfo.legalShape,
          minLines: 4,
          maxLines: 4,
          maxLength: 500,
          onTextChanged: (newValue) => landInfo.legalShape = newValue,
        ),
        InputFieldModel<int>(
          label: S.current.so_mat_thoang,
          data: landInfo.legalNumberOfFacade,
          onTextChanged: (newValue) => landInfo.legalNumberOfFacade = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.kich_thuoc_mat_tien_tiep_giap,
          data: landInfo.legalFacadeLength,
          onTextChanged: (newValue) => landInfo.legalFacadeLength = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.kich_thuoc_chieu_dai,
          data: landInfo.legalLandLength,
          onTextChanged: (newValue) => landInfo.legalLandLength = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.chi_tiet_kich_thuoc,
          data: landInfo.legalLandLengthDetail,
          onTextChanged: (newValue) =>
              landInfo.legalLandLengthDetail = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_khuon_vien,
          data: landInfo.legalAreaWidth,
          onTextChanged: (newValue) {
            landInfo.legalAreaWidth = newValue;
            dienTichKoPhuHopQuyHoach.updateText?.call(
              tinhToanDienTichKhongPhuHopQuyHoachMoDuong(
                landInfo.legalAreaWidth,
                landInfo.legalAreaInPlan,
                landInfo.legalAreaNotConsiderValue ?? 0.0,
              ).text(),
            );
          },
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_phu_hop_quy_hoach,
          data: landInfo.legalAreaInPlan,
          required: false,
          validator: (value) {
            try {
              double newValue = double.tryParse(value ?? '0.0') ?? 0.0;
              if (newValue > (landInfo.legalAreaWidth ?? 0.0)) {
                return S
                    .current.dt_phu_hop_quy_hoach_phai_nho_hon_dt_khuon_vien;
              }
              return null;
            } catch (e) {
              return null;
            }
          },
          onTextChanged: (newValue) {
            landInfo.legalAreaInPlan = newValue;
            dienTichKoPhuHopQuyHoach.updateText?.call(
              tinhToanDienTichKhongPhuHopQuyHoachMoDuong(
                landInfo.legalAreaWidth,
                landInfo.legalAreaInPlan,
                landInfo.legalAreaNotConsiderValue ?? 0.0,
              ).text(),
            );
          },
        ),
        dienTichKoPhuHopQuyHoach,
        InputFieldModel<double>(
          label: S.current.dien_tich_mo_duong,
          data: landInfo.legalAreaNotConsiderValue,
          onTextChanged: (newValue) {
            landInfo.legalAreaNotConsiderValue = newValue;
            dienTichKoPhuHopQuyHoach.updateText?.call(
              tinhToanDienTichKhongPhuHopQuyHoachMoDuong(
                landInfo.legalAreaWidth,
                landInfo.legalAreaInPlan,
                landInfo.legalAreaNotConsiderValue ?? 0.0,
              ).text(),
            );
          },
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_sd_rieng,
          data: landInfo.legalPrivateArea,
          onTextChanged: (newValue) => landInfo.legalPrivateArea = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.dtich_su_dung_chung,
          // value: landInfo.legalCommonArea.toString(),
          data: landInfo.legalCommonArea,
          onTextChanged: (newValue) => landInfo.legalCommonArea = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.hien_trang_su_dung_rieng,
          data: landInfo.legalCurrentPrivateUsing,
          onTextChanged: (newValue) {
            landInfo.legalCurrentPrivateUsing = newValue;
          },
        ),
      ],
      topLsInputField: [],
    );
  }

  /// Đặc điểm thửa đất thực tế
  ExpandModel listDacTiemThuaDatThucTe(AssetLandInfo landInfo) {
    final dtKoPhuHopQuyHoach = InputFieldModel<double>(
      label: S.current.dien_tich_khong_phu_hop_quy_hoach,
      data: landInfo.realAreaUnPlan,
      enable: false,
      onTextChanged: (newValue) {
        landInfo.realAreaUnPlan = newValue;
        initThongTinHopThua();
      },
    );
    return ExpandModel(
      title: '',
      isExpand: false,
      child: [],
      lsInputField: [
        InputFieldModel<String>(
          label: S.current.huong_chinh,
          data: landInfo.realMainDirection,
          onTextChanged: (newValue) => landInfo.realMainDirection = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.hinh_dang,
          data: landInfo.realShape,
          minLines: 4,
          maxLines: 4,
          maxLength: 500,
          onTextChanged: (newValue) => landInfo.realShape = newValue,
        ),
        InputFieldModel<int>(
          label: S.current.so_mat_thoang,
          data: landInfo.realNumberOfFacade,
          onTextChanged: (newValue) => landInfo.realNumberOfFacade = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.kich_thuoc_mat_tien_tiep_giap,
          data: landInfo.realFacadeLength,
          onTextChanged: (newValue) {
            landInfo.realFacadeLength = newValue;
            initThongTinHopThua();
          },
        ),
        InputFieldModel<double>(
          label: S.current.kich_thuoc_chieu_dai,
          data: landInfo.realLandLength,
          onTextChanged: (newValue) {
            landInfo.realLandLength = newValue;
            initThongTinHopThua();
          },
        ),
        InputFieldModel<String>(
          label: S.current.chi_tiet_kich_thuoc,
          data: landInfo.realLandLengthDetail,
          onTextChanged: (newValue) => landInfo.realLandLengthDetail = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_khuon_vien,
          data: landInfo.realAreaWidth,
          required: true,
          onTextChanged: (newValue) {
            landInfo.realAreaWidth = newValue;
            dtKoPhuHopQuyHoach.updateText
                ?.call(tinhToanDienTichKhongPhuHopQuyHoachMoDuong(
              landInfo.realAreaWidth,
              landInfo.realAreaInPlan,
              landInfo.realAreaNotConsiderValue ?? 0.0,
            ).text());
            initThongTinHopThua();
          },
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_phu_hop_quy_hoach,
          data: landInfo.realAreaInPlan,
          required: false,
          validator: (value) {
            try {
              double newValue = double.tryParse(value!) ?? 0.0;
              if (newValue > (landInfo.realAreaWidth ?? 0.0)) {
                return S
                    .current.dt_phu_hop_quy_hoach_phai_nho_hon_dt_khuon_vien;
              }
              return null;
            } catch (e) {
              return null;
            }
          },
          onTextChanged: (newValue) {
            landInfo.realAreaInPlan = newValue;
            dtKoPhuHopQuyHoach.updateText
                ?.call(tinhToanDienTichKhongPhuHopQuyHoachMoDuong(
              landInfo.realAreaWidth,
              landInfo.realAreaInPlan,
              landInfo.realAreaNotConsiderValue ?? 0.0,
            ).text());
            initThongTinHopThua();
          },
        ),
        dtKoPhuHopQuyHoach,
        InputFieldModel<double>(
          label: S.current.dien_tich_mo_duong,
          data: landInfo.realAreaNotConsiderValue,
          onTextChanged: (newValue) {
            landInfo.realAreaNotConsiderValue = newValue;
            dtKoPhuHopQuyHoach.updateText?.call(
              tinhToanDienTichKhongPhuHopQuyHoachMoDuong(
                landInfo.realAreaWidth,
                landInfo.realAreaInPlan,
                landInfo.realAreaNotConsiderValue ?? 0.0,
              ).text(),
            );
          },
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_sd_rieng,
          data: landInfo.realPrivateArea,
          onTextChanged: (newValue) {
            landInfo.realPrivateArea = newValue;
            initThongTinHopThua();
          },
        ),
        InputFieldModel<double>(
          label: S.current.dtich_su_dung_chung,
          data: landInfo.realCommonArea,
          onTextChanged: (newValue) {
            landInfo.realCommonArea = newValue;
            initThongTinHopThua();
          },
        ),
        InputFieldModel<String>(
          label: S.current.hien_trang_su_dung_rieng,
          data: landInfo.realCurrentPrivateUsing,
          onTextChanged: (newValue) {
            landInfo.realCurrentPrivateUsing = newValue;
            initThongTinHopThua();
          },
        ),
      ],
      topLsInputField: [],
    );
  }

  //Mục đích sử dụng đất
  ExpandModel generateMucDichSDDat(LandingPurposeModel landingPurposeModel) {
    final topListInput = [
      InputFieldModel<String>(
        label: S.current.muc_dich_theo_sba,
        selectedValue: KeyValueModel(
          key: landingPurposeModel.usingPurposeId?.toString(),
        ),
        required: true,
        inputFieldType: InputFieldType.dropDown,
        listDataProvider: (p0) => p0.call(getMucDichSuDungSBAProvider),
        onChange: (newValue) => landingPurposeModel.usingPurposeId =
            int.tryParse(newValue?.key ?? ''),
      ),
      InputFieldModel<String>(
        label: S.current.nguon_goc_theo_sba,
        data: landingPurposeModel.usingOrigin,
        onTextChanged: (newValue) => landingPurposeModel.usingOrigin = newValue,
      ),
      InputFieldModel<String>(
        label: S.current.thoi_han_su_dung,
        data: landingPurposeModel.usingPeriod,
        onTextChanged: (newValue) => landingPurposeModel.usingPeriod = newValue,
      ),
    ];
    return ExpandModel(
      key: '$phapLyThucTe-${landingPurposeModel.id}',
      title: S.current.muc_dich_sdung_dat,
      isExpand: false,
      generateTitleIndex: true,
      allowDelete: true,
      allowAdd: true,
      removeExpandClicked: (context, ref, id) {
        deleteMucDichSDDat(landingPurposeModel.id ?? '', id);
      },
      addNewExpandClicked: (context, ref, value) {
        addNewMucDichSD();
      },
      copyLegalToFactual: () {
        copyMucDichSDDatToTT(landingPurposeModel);
      },
      topLsInputField: topListInput,
      child: [
        listMucDichSDDatPL(landingPurposeModel),
        listMucDichSDDatTT(landingPurposeModel),
      ],
      lsInputField: [],
    );
  }

  //Danh sách mục đích sd đất pháp lý
  ExpandModel listMucDichSDDatPL(LandingPurposeModel landingPurposeModel) {
    final dtKoPhuHopQuyHoach = InputFieldModel<double>(
      label: S.current.dien_tich_khong_phu_hop_quy_hoach,
      data: landingPurposeModel.legalAreaUnPlan,
      onTextChanged: (newValue) =>
          landingPurposeModel.legalAreaUnPlan = newValue,
    );
    return ExpandModel(
      title: '',
      isExpand: false,
      child: const [],
      lsInputField: [
        InputFieldModel<double>(
          label: S.current.dien_tich_khuon_vien,
          data: landingPurposeModel.legalAreaWidth,
          onTextChanged: (newValue) {
            landingPurposeModel.legalAreaWidth = newValue;
            dtKoPhuHopQuyHoach.updateText?.call(
              tinhToanDienTichKhongPhuHopQuyHoachMoDuong(
                landingPurposeModel.legalAreaWidth,
                landingPurposeModel.legalAreaInPlan,
                landingPurposeModel.legalAreaNotConsiderValue,
              ).text(),
            );
          },
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_phu_hop_quy_hoach,
          data: landingPurposeModel.legalAreaInPlan,
          required: false,
          validator: (value) {
            try {
              double newValue = double.tryParse(value ?? '0.0') ?? 0.0;
              if (newValue > (landingPurposeModel.legalAreaWidth ?? 0.0)) {
                return S
                    .current.dt_phu_hop_quy_hoach_phai_nho_hon_dt_khuon_vien;
              }
              return null;
            } catch (e) {
              return null;
            }
          },
          onTextChanged: (newValue) {
            landingPurposeModel.legalAreaInPlan = newValue;
            final rs = tinhToanDienTichKhongPhuHopQuyHoachMoDuong(
              landingPurposeModel.legalAreaWidth,
              landingPurposeModel.legalAreaInPlan,
              landingPurposeModel.legalAreaNotConsiderValue,
            );
            dtKoPhuHopQuyHoach.updateText?.call(rs.text());
          },
        ),
        dtKoPhuHopQuyHoach,
        InputFieldModel<double>(
          label: S.current.dien_tich_mo_duong,
          data: landingPurposeModel.legalAreaNotConsiderValue,
          onTextChanged: (newValue) {
            landingPurposeModel.legalAreaNotConsiderValue = newValue;
            dtKoPhuHopQuyHoach.updateText?.call(
              tinhToanDienTichKhongPhuHopQuyHoachMoDuong(
                landingPurposeModel.legalAreaWidth,
                landingPurposeModel.legalAreaInPlan,
                landingPurposeModel.legalAreaNotConsiderValue,
              ).text(),
            );
          },
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_sd_rieng,
          data: landingPurposeModel.legalPrivateArea,
          onTextChanged: (newValue) =>
              landingPurposeModel.legalPrivateArea = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.dtich_su_dung_chung,
          data: landingPurposeModel.legalCommonArea,
          onTextChanged: (newValue) =>
              landingPurposeModel.legalCommonArea = newValue,
        ),
      ],
      topLsInputField: [],
    );
  }

  //Danh sách mục đích sd đất thực tế
  ExpandModel listMucDichSDDatTT(LandingPurposeModel landingPurposeModel) {
    final dtKoPhuHopQuyHoach = InputFieldModel<double>(
      label: S.current.dien_tich_khong_phu_hop_quy_hoach,
      data: landingPurposeModel.realAreaUnPlan,
      onTextChanged: (newValue) =>
          landingPurposeModel.realAreaUnPlan = newValue,
    );
    return ExpandModel(
      title: '',
      isExpand: false,
      child: const [],
      lsInputField: [
        InputFieldModel<double>(
          label: S.current.dien_tich_khuon_vien,
          data: landingPurposeModel.realAreaWidth,
          required: true,
          onTextChanged: (newValue) {
            landingPurposeModel.realAreaWidth = newValue;
            dtKoPhuHopQuyHoach.updateText?.call(
              tinhToanDienTichKhongPhuHopQuyHoachMoDuong(
                landingPurposeModel.realAreaWidth,
                landingPurposeModel.realAreaInPlan,
                landingPurposeModel.realAreaNotConsiderValue,
              ).text(),
            );
          },
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_phu_hop_quy_hoach,
          data: landingPurposeModel.realAreaInPlan,
          required: false,
          validator: (value) {
            try {
              double newValue = double.tryParse(value!) ?? 0.0;
              if (newValue > (landingPurposeModel.realAreaWidth ?? 0.0)) {
                return S
                    .current.dt_phu_hop_quy_hoach_phai_nho_hon_dt_khuon_vien;
              }
              return null;
            } catch (e) {
              return null;
            }
          },
          onTextChanged: (newValue) {
            landingPurposeModel.realAreaInPlan = newValue;
            dtKoPhuHopQuyHoach.updateText?.call(
              tinhToanDienTichKhongPhuHopQuyHoachMoDuong(
                landingPurposeModel.realAreaWidth,
                landingPurposeModel.realAreaInPlan,
                landingPurposeModel.realAreaNotConsiderValue ?? 0.0,
              ).text(),
            );
          },
        ),
        dtKoPhuHopQuyHoach,
        InputFieldModel<double>(
          label: S.current.dien_tich_mo_duong,
          data: landingPurposeModel.realAreaNotConsiderValue,
          onTextChanged: (newValue) {
            landingPurposeModel.realAreaNotConsiderValue = newValue;
            dtKoPhuHopQuyHoach.updateText?.call(
              tinhToanDienTichKhongPhuHopQuyHoachMoDuong(
                landingPurposeModel.realAreaWidth,
                landingPurposeModel.realAreaInPlan,
                landingPurposeModel.realAreaNotConsiderValue ?? 0.0,
              ).text(),
            );
          },
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_sd_rieng,
          data: landingPurposeModel.realPrivateArea,
          onTextChanged: (newValue) =>
              landingPurposeModel.realPrivateArea = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.dtich_su_dung_chung,
          data: landingPurposeModel.realCommonArea,
          onTextChanged: (newValue) =>
              landingPurposeModel.realCommonArea = newValue,
        ),
      ],
      topLsInputField: [],
    );
  }

  //Thêm mục đích sử dụng đất
  void addNewMucDichSD() {
    final parentIndex =
        state.expandList.indexWhere((element) => element.key == mucDichSDDat);
    LandingPurposeModel landingPurposeModel = LandingPurposeModel();
    // final lsLandPurpose = [
    //   ...state.landInfo.assetLandUsingPurposes,
    // ];
    // lsLandPurpose.add(landingPurposeModel);
    state.landInfo.assetLandUsingPurposes.add(landingPurposeModel);
    state.expandList[parentIndex].child.add(
      generateMucDichSDDat(
        landingPurposeModel,
      ),
    );
    state = state.copyWith(
        // expandList: [...state.expandList],
        // landInfo: state.landInfo.copyWith(assetLandUsingPurposes: lsLandPurpose),
        );
  }

  ///Xóa mục đích sử dụng đất
  void deleteMucDichSDDat(String landingPurposeId, String expandId) {
    state.landInfo.assetLandUsingPurposes
        .removeWhere((e) => e.id == landingPurposeId);
    state.expandList
        .firstWhere((element) => element.key == mucDichSDDat)
        .child
        .removeWhere((element) => element.id == expandId);

    state = state.copyWith();
  }

  ///Ẩn hiện mục đích sử dụng
  void toggleMucDichSuDungDat(bool? newValue) {
    final parentIndex =
        state.expandList.indexWhere((element) => element.key == mucDichSDDat);
    var landingPurposes = [...state.landInfo.assetLandUsingPurposes];
    if (newValue == false) {
      state.expandList[parentIndex].child = [];
      landingPurposes = [];
    } else {
      if (landingPurposes.isEmpty) {
        landingPurposes.add(LandingPurposeModel());
      }

      state.expandList[parentIndex].child = landingPurposes
          .mapIndexed((index, element) => generateMucDichSDDat(element))
          .toList();
    }
    state = state.copyWith(
        landInfo:
            state.landInfo.copyWith(assetLandUsingPurposes: landingPurposes));
  }

  ExpandModel generateGroupCayTrong() {
    return ExpandModel(
      key: cayTrong,
      title: S.current.cay_trong,
      isExpand: false,
      child: const [],
      lsInputField: const [],
      trailingExpandWidgetBuilder: (context, ref) {
        return CupertinoSwitch(
          activeColor: Theme.of(context).primaryColor,
          value: state.landInfo.haveCayTrong,
          onChanged: (newValue) {
            toggleCayTrong(
              newValue,
            );
          },
        );
      },
      topLsInputField: [],
    );
  }

  ExpandModel generateGroupCTXD() {
    return ExpandModel(
      key: ctxd,
      title: S.current.cong_trinh_xd,
      isExpand: false,
      child: const [],
      lsInputField: const [],
      trailingExpandWidgetBuilder: (context, ref) {
        return CupertinoSwitch(
          activeColor: Theme.of(context).primaryColor,
          value: state.landInfo.haveCTXD,
          onChanged: (newValue) {
            toggleCTXD(
              newValue,
            );
          },
        );
      },
      topLsInputField: [],
    );
  }

  ///Generate 1 group cây trồng
  ExpandModel generateCayTrong(TreeModel treeModel) {
    final lsInput = <InputFieldModel>[
      InputFieldModel<String>(
        label: S.current.loai_cay_trong,
        listDataProvider: (p0) => p0.call(getListCayTrongProvider),
        selectedValue: treeModel.treeTypeId != null
            ? KeyValueModel(key: treeModel.treeTypeId.toString())
            : null,
        inputFieldType: InputFieldType.dropDown,
        onChange: (newValue) =>
            treeModel.treeTypeId = int.tryParse(newValue?.key ?? ''),
      ),
      InputFieldModel<String>(
        label: S.current.chi_tiet_cay_trong,
        data: treeModel.treeDetail,
        onTextChanged: (newValue) => treeModel.treeDetail = newValue,
      ),
      InputFieldModel<int>(
        label: S.current.nam_tuoi,
        value: treeModel.yearOld?.toString() ?? '',
        inputFormatter: [FilteringTextInputFormatter.digitsOnly],
        data: treeModel.yearOld,
        onTextChanged: (newValue) => treeModel.yearOld = newValue,
      ),
      InputFieldModel<double>(
        label: S.current.mat_do_cay,
        data: treeModel.density,
        onTextChanged: (newValue) => treeModel.density = newValue,
      ),
      InputFieldModel<double>(
        label: S.current.dien_tich,
        data: treeModel.area,
        onTextChanged: (newValue) => treeModel.area = newValue,
      ),
      InputFieldModel<double>(
        label: S.current.ti_le_hao_hut,
        data: treeModel.lossRate,
        onTextChanged: (newValue) => treeModel.lossRate = newValue,
        validator: Validator.validatePercent,
      ),
      InputFieldModel<int>(
        label: S.current.so_luong_cay,
        data: treeModel.amount,
        onTextChanged: (newValue) => treeModel.amount = newValue,
      ),
    ];
    return ExpandModel(
      title: S.current.cay_trong,
      isExpand: false,
      allowDelete: true,
      allowAdd: true,
      generateTitleIndex: true,
      child: const [],
      addNewExpandClicked: (context, ref, expandId) {
        addNewCayTrong();
      },
      removeExpandClicked: (context, ref, expandId) {
        deleteCayTrong(treeModel.id ?? '', expandId);
      },
      lsInputField: lsInput,
      topLsInputField: [],
    );
  }

  ///Ẩn hiện cây trồng
  void toggleCayTrong(bool? newValue) {
    // state.landInfo.haveCayTrong = newValue;
    var lsCayTrong = [...state.landInfo.assetTrees];
    final parentIndex =
        state.expandList.indexWhere((element) => element.key == cayTrong);
    if (newValue == false) {
      state.expandList[parentIndex].child = [];
      lsCayTrong = [];
    } else {
      if (state.landInfo.assetTrees.isEmpty) {
        lsCayTrong.add(TreeModel());
      }
      state.expandList[parentIndex]
        ..isExpand = newValue ?? false
        ..child = lsCayTrong
            .mapIndexed((index, element) => generateCayTrong(element))
            .toList();
    }
    state = state.copyWith(
      landInfo: state.landInfo.copyWith(assetTrees: lsCayTrong),
    );
  }

  ///Thêm 1 cây trồng mới
  void addNewCayTrong() {
    final newTree = TreeModel();
    final lsCayTrong = [...state.landInfo.assetTrees];
    lsCayTrong.add(newTree);
    final cayTrongInput = generateCayTrong(newTree);
    final parentIndex =
        state.expandList.indexWhere((element) => element.key == cayTrong);
    state.expandList[parentIndex].child.add(cayTrongInput);
    state.landInfo.assetTrees.add(newTree);
    state = state.copyWith();
  }

  ///Xóa cây trồng
  void deleteCayTrong(String treeId, String expandId) {
    state.landInfo.assetTrees.removeWhere((e) => e.id == treeId);
    state.expandList
        .firstWhere((element) => element.key == cayTrong)
        .child
        .removeWhere((element) => element.id == expandId);
    state = state.copyWith();
  }

  ///Generate 1 group CTXD
  ExpandModel generateCTXD(ConstructionModel item) {
    final lsInput = <InputFieldModel>[
      InputFieldModel<String>(
        label: S.current.loai_ctxd,
        inputFieldType: InputFieldType.dropDown,
        required: true,
        listDataProvider: (p0) => p0.call(getLoaiCTXDProvider),
        selectedItemProvider: selectedConstructionType(item),
        onChange: (newValue) {
          item.constructionTypeId = int.tryParse(newValue?.key ?? '');
        },
      ),
      InputFieldModel<String>(
        label: S.current.ten_ctrinh,
        inputFieldType: InputFieldType.dropDown,
        required: true,
        listDataProvider: (p0) => p0.call(getTenCTXDProvider(item)),
        selectedItemProvider: selectedConstructionName(item),
        onChange: (newValue) {
          item.constructionNameId = int.tryParse(newValue?.key ?? '');
        },
      ),
      InputFieldModel<double>(
        label: S.current.dien_tich_su_dung,
        data: item.constructionArea,
        required: true,
        onTextChanged: (newValue) => item.constructionArea = newValue,
      ),
      InputFieldModel<String>(
        label: S.current.ho_so_pl,
        listDataProvider: (p0) => p0.call(getHSPLCTXDProvider),
        inputFieldType: InputFieldType.dropDown,
        required: true,
        selectedItemProvider: selectedConstructionLegal(item),
        onChange: (newValue) =>
            item.constructionLegalTypeId = int.tryParse(newValue?.key ?? ''),
      ),
      InputFieldModel<double>(
        label: S.current.so_tang,
        data: item.floors,
        onTextChanged: (newValue) => item.floors = newValue,
      ),
      InputFieldModel<double>(
        label: S.current.so_tang_ham,
        data: item.baseFloors,
        onTextChanged: (newValue) => item.baseFloors = newValue,
      ),
      InputFieldModel<String>(
        label: S.current.noi_that,
        required: true,
        data: item.furnitures,
        onTextChanged: (newValue) => item.furnitures = newValue,
      ),
      InputFieldModel<int>(
        label: S.current.nam_xd,
        data: item.constructionYear,
        inputFormatter: [FilteringTextInputFormatter.digitsOnly],
        value: item.constructionYear?.toString() ?? '',
        onTextChanged: (newValue) => item.constructionYear = newValue,
        validator: (p0) => Validator.validateYear(p0, required: false),
      ),
      InputFieldModel<int>(
        label: S.current.nam_sua_chua,
        data: item.repairYear,
        inputFormatter: [FilteringTextInputFormatter.digitsOnly],
        value: item.repairYear?.toString() ?? '',
        onTextChanged: (newValue) => item.repairYear = newValue,
        validator: (p0) => Validator.validateYear(p0, required: false),
      ),
      InputFieldModel<double>(
        label: S.current.clcl,
        data: item.remainingQuality,
        required: true,
        onTextChanged: (newValue) => item.remainingQuality = newValue,
        validator: (p0) => Validator.validatePercent(p0, required: true),
      ),
      InputFieldModel<double>(
        label: S.current.mdht,
        data: item.mdht,
        onTextChanged: (newValue) => item.mdht = newValue,
        validator: Validator.validatePercent,
      ),
      InputFieldModel<String>(
        label: S.current.mo_ta_khac,
        data: item.describe,
        onTextChanged: (newValue) => item.describe = newValue,
      ),
    ];
    return ExpandModel(
      title: S.current.cong_trinh_xd,
      isExpand: false,
      allowDelete: true,
      allowAdd: true,
      generateTitleIndex: true,
      child: const [],
      addNewExpandClicked: (context, ref, expandId) {
        addNewCTXD();
      },
      removeExpandClicked: (context, ref, expandId) {
        deleteCTXD(item.id ?? '', expandId);
      },
      lsInputField: lsInput,
      topLsInputField: [],
    );
  }

  ///Ẩn hiện CTXD
  void toggleCTXD(bool? newValue) {
    var lsCTXD = state.landInfo.constructions;
    final parentIndex =
        state.expandList.indexWhere((element) => element.key == ctxd);
    if (newValue == false) {
      state.expandList[parentIndex].child = [];
      lsCTXD = [];
    } else {
      if (state.landInfo.constructions.isEmpty) {
        lsCTXD.add(ConstructionModel());
      }
      state.expandList[parentIndex]
        ..isExpand = newValue ?? false
        ..child = lsCTXD
            .mapIndexed((index, element) => generateCTXD(element))
            .toList();
    }
    state = state.copyWith(
      landInfo: state.landInfo.copyWith(constructions: lsCTXD),
    );
  }

  ///Thêm 1 CTXD mới
  void addNewCTXD() {
    ConstructionModel newConstruction = ConstructionModel();
    state.landInfo.constructions.add(newConstruction);
    final ctxdInput = generateCTXD(newConstruction);
    final parentIndex =
        state.expandList.indexWhere((element) => element.key == ctxd);
    state.expandList[parentIndex].child.add(ctxdInput);
    state = state.copyWith();
  }

  ///Xóa CTXD
  void deleteCTXD(String constructionId, String expandId) {
    state.landInfo.constructions.removeWhere(
      (e) => e.id == constructionId,
    );

    state.expandList
        .firstWhere((element) => element.key == ctxd)
        .child
        .removeWhere((element) => element.id == expandId);
    state = state.copyWith();
  }

  void copyThuaDatPhapLySangThucTe(AssetLandInfo landInfo) {
    landInfo
      ..realMainDirection = landInfo.legalMainDirection
      ..realShape = landInfo.legalShape
      ..realNumberOfFacade = landInfo.legalNumberOfFacade
      ..realFacadeLength = landInfo.legalFacadeLength
      ..realLandLength = landInfo.legalLandLength
      ..realAreaWidth = landInfo.legalAreaWidth
      ..realAreaInPlan = landInfo.legalAreaInPlan
      ..realAreaUnPlan = landInfo.legalAreaUnPlan
      ..realPrivateArea = landInfo.legalPrivateArea
      ..realAreaNotConsiderValue = landInfo.legalAreaNotConsiderValue
      ..realCommonArea = landInfo.legalCommonArea
      ..realCurrentPrivateUsing = landInfo.legalCurrentPrivateUsing
      ..realLandLengthDetail = landInfo.legalLandLengthDetail;

    final dacDiemThuaDatIndex = state.expandList.indexWhere(
      (element) => element.key?.contains('-dacDiemThuaDat') == true,
    );
    final dacDiemThuaDat = state.expandList[dacDiemThuaDatIndex];
    dacDiemThuaDat.child[1] = listDacTiemThuaDatThucTe(landInfo);
    state.expandList[dacDiemThuaDatIndex] = dacDiemThuaDat;
    state = state.copyWith(landInfo: landInfo);
  }

  void copyMucDichSDDatToTT(LandingPurposeModel landingPurposeModel) {
    landingPurposeModel
      ..realAreaWidth = landingPurposeModel.legalAreaWidth
      ..realAreaInPlan = landingPurposeModel.legalAreaInPlan
      ..realAreaUnPlan = landingPurposeModel.legalAreaUnPlan
      ..realPrivateArea = landingPurposeModel.legalPrivateArea
      ..realAreaNotConsiderValue = landingPurposeModel.legalAreaNotConsiderValue
      ..realCommonArea = landingPurposeModel.legalCommonArea;

    final mucDichSDDatExpand =
        state.expandList.firstWhere((element) => element.key == mucDichSDDat);
    final item = mucDichSDDatExpand.child.firstWhere((element) =>
        element.key?.contains(landingPurposeModel.id ?? '') == true);
    // lsChild
    item.child[1] = listMucDichSDDatTT(landingPurposeModel);
    final lsLand = state.landInfo.assetLandUsingPurposes;
    final itemIndex =
        lsLand.indexWhere((element) => element.id == landingPurposeModel.id);
    state.landInfo.assetLandUsingPurposes[itemIndex] = landingPurposeModel;
    state = state.copyWith(landInfo: state.landInfo);
  }

  @override
  Future<bool> saveData() async {
    final isValid = await super.saveData();
    if (isValid) {
      Navigator.of(context).pop(state.landInfo);
    } else {
      String errorMess = '';
      for (var element in state.expandList) {
        errorMess = element.getError();
        if (errorMess.isNotEmpty) {
          break;
        }
      }
      showMessageDialog(errorMess);
    }
    return true;
  }

  ///Cập nhật mục đích hỗn hợp
  void updateMucDichHonHop(bool? onChanged) {
    state = state.copyWith(
      landInfo: state.landInfo.copyWith(
        isConsolidationPurpose: onChanged,
      ),
    );
  }

  ///Cập nhật hợp thửa
  void updateHopThua(bool? isChecked) {
    state = state.copyWith(
      landInfo: state.landInfo.copyWith(
        isConsolidation: isChecked,
      ),
    );
    initThongTinHopThua();
  }

  ///Khởi tạo thông tin hợp thửa
  void initThongTinHopThua() {
    bool isChecked = state.landInfo.isConsolidation;
    final hopThuaIndex =
        state.expandList.indexWhere((element) => element.key == hopThua);

    if (isChecked == true) {
      state.expandList[hopThuaIndex].lsInputField = [
        InputFieldModel<double>(
          label: S.current.k_thuoc_mat_tien,
          data: state.detailModel.facadeLength,
          onTextChanged: (newValue) {
            state.detailModel.facadeLength = newValue;
          },
        ),
        InputFieldModel<double>(
          label: S.current.k_thuoc_chieu_dai,
          data: state.detailModel.totalLength,
          onTextChanged: (newValue) {
            state.detailModel.totalLength = newValue;
          },
        ),
        InputFieldModel<String>(
          label: S.current.chi_tiet_kich_thuoc,
          data: state.detailModel.combineAreaWidthDetail,
          onTextChanged: (newValue) {
            state.detailModel.combineAreaWidthDetail = newValue;
          },
        ),
        InputFieldModel<String>(
          label: S.current.mo_ta_hinh_dang,
          data: state.detailModel.combineLandShape,
          minLines: 4,
          maxLines: 4,
          maxLength: 500,
          onTextChanged: (newValue) =>
              state.detailModel.combineLandShape = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_khuon_vien,
          data: state.detailModel.dienTichKhuonVien,
          enable: false,
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_sd_rieng,
          data: state.detailModel.dienTichSDRieng,
          enable: false,
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_phu_hop_quy_hoach,
          data: state.detailModel.dienTichPhuHopQuyHoach,
          enable: false,
        ),
        InputFieldModel<double>(
          label: S.current.dtich_su_dung_chung,
          data: state.detailModel.dienTichSDChung,
          enable: false,
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_khong_phu_hop_quy_hoach,
          data: state.detailModel.dienTichKoPhuHopQuyHoach,
          enable: false,
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_mo_duong,
          data: state.detailModel.dienTichMoDuong,
          enable: false,
        ),
        InputFieldModel<String>(
          label: S.current.dia_diem_tham_dinh,
          data: state.detailModel.combineAppraisalLocation,
          required: true,
          onTextChanged: (newValue) =>
              state.detailModel.combineAppraisalLocation = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.mo_ta_chi_tiet_hop_thua,
          data: state.detailModel.combineNote,
          required: true,
          onTextChanged: (newValue) => state.detailModel.combineNote = newValue,
          minLines: 4,
          maxLines: 4,
        ),
      ];
    } else {
      state.expandList[hopThuaIndex].lsInputField = [];
    }
    state = state.copyWith();
  }

  /// Thông tin hợp thửa
  ExpandModel thongTinHopThua() {
    return ExpandModel(
      key: hopThua,
      title: S.current.hop_thua,
      isExpand: false,
      child: const [],
      lsInputField: const [],
      trailingExpandWidgetBuilder: (context, ref) {
        bool isEnableHopThua = state.detailModel.assetLandInfors.length > 1 &&
            !state.landInfo.isConsolidationPurpose;
        return CupertinoSwitch(
          activeColor: Theme.of(context).primaryColor,
          value: state.landInfo.isConsolidation,
          onChanged: !isEnableHopThua
              ? null
              : (newValue) {
                  updateHopThua(
                    newValue,
                  );
                },
        );
      },
      topLsInputField: [],
    );
  }

  double tinhToanDienTichKhongPhuHopQuyHoachMoDuong(
    double? kichThuocKhuonVien,
    double? dienTichPhuHopQuyHoach,
    double? dienTichMoDuong,
  ) {
    double dienTichKoPhuHopQuyHoach = 0.0;
    if (kichThuocKhuonVien != null &&
        dienTichPhuHopQuyHoach != null &&
        dienTichMoDuong != null) {
      dienTichKoPhuHopQuyHoach =
          kichThuocKhuonVien - dienTichPhuHopQuyHoach - dienTichMoDuong;
    }
    return dienTichKoPhuHopQuyHoach;
  }
}
