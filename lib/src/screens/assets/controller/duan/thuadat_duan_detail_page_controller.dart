import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/detail_describe_model.dart';
import 'package:sba/src/models/assets/duan_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/assets/state/detail_thuadat_duan_state.dart';
import 'package:sba/src/services/api/assets_api.dart';
import 'package:sba/src/services/providers/asset_api_provider.dart' as api;
import 'package:sba/src/services/providers/bds_api_provider.dart' as bds;
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/utils/validator_util.dart';
part 'thuadat_duan_detail_page_controller.g.dart';

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
Future<List<KeyValueModel>> getDacTinhKyThuat(
    GetDacTinhKyThuatRef ref, ConstructionModel construction) async {
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
    GetDoanDuongTrongKhungGiaRef ref, AssetLandInfo info) async {
  final result = await ref
      .read(assetsApiProvider)
      .getRoadInPrice(provinceCode: info.realAddressProvince);
  if (result.data?.isNotEmpty == true) {
    final keepAlive = ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListDistrict(
  GetListDistrictRef ref,
  AssetLandInfo info,
) async {
  final provinceSelected = ref.watch(selectedProvinceProvider(info));
  final result = await ref
      .read(assetsApiProvider)
      .getListDistrict(provinceCode: provinceSelected?.key ?? '');
  if (result.data?.isNotEmpty == true) {
    final keepAlive = ref.keepAlive();
    ref.listen(selectedProvinceProvider(info), (previous, next) {
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
  AssetLandInfo info,
) async {
  final districtSelected = ref.watch(selectedDistrictProvider(info));
  final result = await ref
      .read(assetsApiProvider)
      .getListAddress(districtCode: districtSelected?.key ?? '');
  if (result.data?.isNotEmpty == true) {
    final keepAlive = ref.keepAlive();
    ref.listen(selectedDistrictProvider(info), (previous, next) {
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
      id: params.constructionNameId,
      title: null,
    );
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

class ThuaDatDuAnDetailPageController
    extends BaseDetailInfoPageController<DetailThuaDatState> {
  ThuaDatDuAnDetailPageController(super.state, super.ref);

  static final detailLandInfoProvider = StateNotifierProvider.autoDispose
      .family<ThuaDatDuAnDetailPageController, DetailThuaDatState,
          AssetProjectInfo>(
    (ref, element) {
      final controller = ThuaDatDuAnDetailPageController(
        DetailThuaDatState(
          info: element,
          expandList: [],
        ),
        ref,
      );
      return controller;
    },
  );

  @override
  Future<void> initialLoad() async {
    final lsExpand = <ExpandModel>[];
    final info = state.info;

    ExpandModel mucDichSuDung = ExpandModel(
      key: mucDichSDDat,
      title: S.current.muc_dich_sd,
      isExpand: true,
      child: const [],
      lsInputField: const [],
      trailingExpandWidgetBuilder: (context, ref) {
        return CupertinoSwitch(
          activeColor: Theme.of(context).primaryColor,
          value: info.haveLandingPurpose,
          onChanged: (newValue) {
            info.haveLandingPurpose = newValue;
            toggleMucDichSuDungDat(newValue);
          },
        );
      },
      topLsInputField: const [],
    );

    if (info.assetLandUsingPurposes.isNotEmpty) {
      var lsChild = <ExpandModel>[];
      info.assetLandUsingPurposes.forEachIndexed((index, element) {
        lsChild.add(generateMucDichSDDat(element));
      });
      mucDichSuDung.child = lsChild;
    }

    ExpandModel cayTrong = generateGroupCayTrong();

    ExpandModel congTrinhXayDung = generateGroupCTXD();

    ExpandModel moTaChiTiet = generateGroupMoTaChiTiet();

    lsExpand.add(mucDichSuDung);
    lsExpand.add(cayTrong);
    lsExpand.add(congTrinhXayDung);
    lsExpand.add(moTaChiTiet);
    state = state.copyWith(expandList: lsExpand);

    if (info.haveLandingPurpose == true) {
      toggleMucDichSuDungDat(true);
    }

    if (info.haveCayTrong == true) {
      toggleCayTrong(true);
    }

    if (info.haveCTXD == true) {
      toggleCTXD(true);
    }

    if (info.haveMoTaChiTiet == true) {
      toggleMoTaChiTiet(true);
    }
  }

  ///Thông tin thửa đất pháp lý
  ExpandModel generateinfo(AssetLandInfo info) {
    final tinhTP = InputFieldModel<String>(
      label: S.current.tinh_tp,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: selectedProvinceProvider(info),
      listDataProvider: (p0) => p0.call(
        api.getListProvinceProvider,
      ),
      onChange: (newValue) {
        info.legalAddressProvince = newValue?.key;
      },
    );

    final quanHuyen = InputFieldModel<String>(
      label: S.current.tp_quan_huyen,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: selectedDistrictProvider(info),
      listDataProvider: (p0) => p0.call(
        getListDistrictProvider(info),
      ),
      onChange: (newValue) {
        info.legalAddressDistrict = newValue?.key;
      },
    );

    final phuongXa = InputFieldModel<String>(
      label: S.current.xa_phuong_thi_tran,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: selectedAddressProvider(info),
      listDataProvider: (p0) => p0.call(
        getListAddressProvider(info),
      ),
      onChange: (newValue) {
        info.legalAddressWard = newValue?.key;
      },
    );

    final duongPho = InputFieldModel<String>(
        label: S.current.duong_pho,
        data: info.legalAddressStreet,
        onTextChanged: (newValue) => info.legalAddressStreet = newValue);

    final chiTiet = InputFieldModel<String>(
        label: S.current.chi_tiet,
        data: info.legalAddressDetail,
        onTextChanged: (newValue) => info.legalAddressDetail = newValue);

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
  ExpandModel generateRealLandInfo(AssetLandInfo info) {
    final tinhTP = InputFieldModel<String>(
      label: S.current.tinh_tp,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: bds.selectedProvinceProvider(info),
      listDataProvider: (p0) => p0.call(
        api.getListProvinceProvider,
      ),
      enable: false,
    );

    final quanHuyen = InputFieldModel<String>(
      label: S.current.tp_quan_huyen,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: bds.selectedDistrictProvider(info),
      listDataProvider: (p0) => p0.call(
        bds.getListDistrictProvider(info),
      ),
      enable: false,
    );

    final phuongXa = InputFieldModel<String>(
      label: S.current.xa_phuong_thi_tran,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: bds.selectedAddressProvider(info),
      listDataProvider: (p0) => p0.call(
        bds.getListAddressProvider(info),
      ),
      enable: false,
    );

    final duongPho = InputFieldModel<String>(
      label: S.current.duong_pho,
      data: info.realAddressStreet,
      onTextChanged: (newValue) => info.realAddressStreet = newValue,
      enable: false,
    );

    final chiTiet = InputFieldModel<String>(
      label: S.current.chi_tiet,
      data: info.realAddressDetail,
      onTextChanged: (newValue) => info.realAddressDetail = newValue,
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
  ExpandModel listDacTiemThuaDatPhapLy(AssetLandInfo info) {
    final dienTichKoPhuHopQuyHoach = InputFieldModel<double>(
      label: S.current.dien_tich_khong_phu_hop_quy_hoach,
      data: info.legalAreaUnPlan,
      enable: false,
      onTextChanged: (newValue) => info.legalAreaUnPlan = newValue,
    );
    return ExpandModel(
      title: '',
      isExpand: false,
      child: const [],
      lsInputField: [
        InputFieldModel<String>(
          label: S.current.huong_chinh,
          data: info.legalMainDirection,
          onTextChanged: (newValue) => info.legalMainDirection = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.hinh_dang,
          data: info.legalShape,
          onTextChanged: (newValue) => info.legalShape = newValue,
        ),
        InputFieldModel<int>(
          label: S.current.so_mat_thoang,
          data: info.legalNumberOfFacade,
          onTextChanged: (newValue) => info.legalNumberOfFacade = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.kich_thuoc_mat_tien_tiep_giap,
          data: info.legalFacadeLength,
          onTextChanged: (newValue) => info.legalFacadeLength = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.kich_thuoc_chieu_dai,
          // value: info.legalLandLength.toString(),
          data: info.legalLandLength,

          onTextChanged: (newValue) => info.legalLandLength = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_khuon_vien,
          data: info.legalAreaWidth,
          onTextChanged: (newValue) {
            info.legalAreaWidth = newValue;
            dienTichKoPhuHopQuyHoach.updateText?.call(
              tinhToanDienTichKhongPhuHopQuyHoach(
                info.legalAreaWidth,
                info.legalAreaInPlan,
              ).text(),
            );
          },
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_phu_hop_quy_hoach,
          data: info.legalAreaInPlan,
          required: false,
          validator: (value) {
            try {
              double newValue = double.tryParse(value ?? '0.0') ?? 0.0;
              if (newValue > (info.legalAreaWidth ?? 0.0)) {
                return S
                    .current.dt_phu_hop_quy_hoach_phai_nho_hon_dt_khuon_vien;
              }
              return null;
            } catch (e) {
              return null;
            }
          },
          onTextChanged: (newValue) {
            info.legalAreaInPlan = newValue;
            dienTichKoPhuHopQuyHoach.updateText?.call(
              tinhToanDienTichKhongPhuHopQuyHoach(
                info.legalAreaWidth,
                info.legalAreaInPlan,
              ).text(),
            );
          },
        ),
        dienTichKoPhuHopQuyHoach,
        InputFieldModel<double>(
          label: S.current.dien_tich_sd_rieng,
          data: info.legalPrivateArea,
          onTextChanged: (newValue) => info.legalPrivateArea = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.dtich_su_dung_chung,
          // value: info.legalCommonArea.toString(),
          data: info.legalCommonArea,

          onTextChanged: (newValue) => info.legalCommonArea = newValue,
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
        inputFieldType: InputFieldType.dropDown,
        required: true,
        listDataProvider: (p0) => p0.call(getMucDichSuDungSBAProvider),
        onChange: (newValue) => landingPurposeModel.usingPurposeId =
            int.tryParse(newValue?.key ?? ''),
      ),
      InputFieldModel<String>(
        label: S.current.nguon_goc_theo_sba,
        data: landingPurposeModel.usingOrigin,
        required: false,
        onTextChanged: (newValue) => landingPurposeModel.usingOrigin = newValue,
      ),
      InputFieldModel<String>(
        label: S.current.thoi_han_su_dung,
        data: landingPurposeModel.usingPeriod,
        required: false,
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
              tinhToanDienTichKhongPhuHopQuyHoach(
                landingPurposeModel.legalAreaWidth,
                landingPurposeModel.legalAreaInPlan,
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
            final rs = tinhToanDienTichKhongPhuHopQuyHoach(
              landingPurposeModel.legalAreaWidth,
              landingPurposeModel.legalAreaInPlan,
            );
            dtKoPhuHopQuyHoach.updateText?.call(rs.text());
          },
        ),
        dtKoPhuHopQuyHoach,
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
              tinhToanDienTichKhongPhuHopQuyHoach(
                landingPurposeModel.realAreaWidth,
                landingPurposeModel.realAreaInPlan,
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
              double newValue = double.tryParse(value ?? '0.0') ?? 0.0;
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
              tinhToanDienTichKhongPhuHopQuyHoach(
                landingPurposeModel.realAreaWidth,
                landingPurposeModel.realAreaInPlan,
              ).text(),
            );
          },
        ),
        dtKoPhuHopQuyHoach,
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
    state.info.assetLandUsingPurposes.add(landingPurposeModel);
    state.expandList[parentIndex].child.add(
      generateMucDichSDDat(
        landingPurposeModel,
      ),
    );
    state = state.copyWith();
  }

  ///Xóa mục đích sử dụng đất
  void deleteMucDichSDDat(String landingPurposeId, String expandId) {
    state.info.assetLandUsingPurposes
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
    var landingPurposes = [...state.info.assetLandUsingPurposes];
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
        info: state.info.copyWith(assetLandUsingPurposes: landingPurposes));
  }

  ExpandModel generateGroupCayTrong() {
    return ExpandModel(
      key: cayTrong,
      title: S.current.cay_trong,
      isExpand: false,
      child: const [],
      lsInputField: const [],
      topLsInputField: [],
      trailingExpandWidgetBuilder: (context, ref) {
        return CupertinoSwitch(
          activeColor: Theme.of(context).primaryColor,
          value: state.info.haveCayTrong,
          onChanged: (newValue) {
            state.info.haveCayTrong = newValue;
            toggleCayTrong(newValue);
          },
        );
      },
    );
  }

  ExpandModel generateGroupCTXD() {
    return ExpandModel(
      key: ctxd,
      title: S.current.cong_trinh_xd,
      isExpand: false,
      child: const [],
      lsInputField: const [],
      topLsInputField: [],
      trailingExpandWidgetBuilder: (context, ref) {
        return CupertinoSwitch(
          activeColor: Theme.of(context).primaryColor,
          value: state.info.haveCTXD,
          onChanged: (newValue) {
            state.info.haveCTXD = newValue;
            toggleCTXD(newValue);
          },
        );
      },
    );
  }

  ExpandModel generateGroupMoTaChiTiet() {
    return ExpandModel(
      key: moTaChiTiet,
      title: S.current.mo_ta_chi_tiet,
      isExpand: false,
      child: const [],
      lsInputField: const [],
      topLsInputField: [],
      trailingExpandWidgetBuilder: (context, ref) {
        return CupertinoSwitch(
          activeColor: Theme.of(context).primaryColor,
          value: state.info.haveMoTaChiTiet,
          onChanged: (newValue) {
            state.info.haveMoTaChiTiet = newValue;
            toggleMoTaChiTiet(newValue);
          },
        );
      },
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
        data: treeModel.yearOld,
        inputFormatter: [FilteringTextInputFormatter.digitsOnly],
        value: treeModel.yearOld?.toString() ?? '',
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
    // state.info.haveCayTrong = newValue;
    var lsCayTrong = [...state.info.assetTrees];
    final parentIndex =
        state.expandList.indexWhere((element) => element.key == cayTrong);
    if (newValue == false) {
      state.expandList[parentIndex].child = [];
      lsCayTrong = [];
    } else {
      if (state.info.assetTrees.isEmpty) {
        lsCayTrong.add(TreeModel());
      }
      state.expandList[parentIndex]
        ..isExpand = newValue ?? false
        ..child = lsCayTrong
            .mapIndexed((index, element) => generateCayTrong(element))
            .toList();
    }
    state = state.copyWith(
      info: state.info.copyWith(assetTrees: lsCayTrong),
    );
  }

  ///Thêm 1 cây trồng mới
  void addNewCayTrong() {
    final newTree = TreeModel();
    final lsCayTrong = [...state.info.assetTrees];
    lsCayTrong.add(newTree);
    final cayTrongInput = generateCayTrong(newTree);
    final parentIndex =
        state.expandList.indexWhere((element) => element.key == cayTrong);
    state.expandList[parentIndex].child.add(cayTrongInput);
    state.info.assetTrees.add(newTree);
    state = state.copyWith();
  }

  ///Xóa cây trồng
  void deleteCayTrong(String treeId, String expandId) {
    state.info.assetTrees.removeWhere((e) => e.id == treeId);
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
        listDataProvider: (p0) => p0.call(getLoaiCTXDProvider),
        selectedItemProvider: selectedConstructionType(item),
        onChange: (newValue) {
          item.constructionTypeId = int.tryParse(newValue?.key ?? '');
        },
      ),
      InputFieldModel<String>(
        label: S.current.mo_ta_dac_tinh_ky_thuat,
        inputFieldType: InputFieldType.dropDown,
        listDataProvider: (p0) => p0.call(getDacTinhKyThuatProvider(item)),
        selectedItemProvider: selectedConstructionName(item),
        onChange: (newValue) {
          item.constructionNameId = newValue?.id;
        },
      ),
      InputFieldModel<double>(
        label: S.current.dien_tich_su_dung,
        data: item.constructionArea,
        onTextChanged: (newValue) => item.constructionArea = newValue,
      ),
      InputFieldModel<String>(
        label: S.current.ho_so_pl,
        listDataProvider: (p0) => p0.call(getHSPLCTXDProvider),
        inputFieldType: InputFieldType.dropDown,
        selectedItemProvider: selectedConstructionLegal(item),
        onChange: (newValue) =>
            item.constructionLegalTypeId = int.tryParse(newValue?.key ?? ''),
      ),
      InputFieldModel<double>(
        label: S.current.clcl,
        data: item.remainingQuality,
        onTextChanged: (newValue) => item.remainingQuality = newValue,
        validator: Validator.validatePercent,
      ),
      InputFieldModel<double>(
        label: S.current.mdht,
        data: item.mdht,
        onTextChanged: (newValue) => item.mdht = newValue,
        validator: Validator.validatePercent,
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
    var lsCTXD = state.info.constructions;
    final parentIndex =
        state.expandList.indexWhere((element) => element.key == ctxd);
    if (newValue == false) {
      state.expandList[parentIndex].child = [];
      lsCTXD = [];
    } else {
      if (state.info.constructions.isEmpty) {
        lsCTXD.add(ConstructionModel());
      }
      state.expandList[parentIndex]
        ..isExpand = newValue ?? false
        ..child = lsCTXD
            .mapIndexed((index, element) => generateCTXD(element))
            .toList();
    }
    state = state.copyWith(
      info: state.info.copyWith(constructions: lsCTXD),
    );
  }

  ///Thêm 1 CTXD mới
  void addNewCTXD() {
    ConstructionModel newConstruction = ConstructionModel();
    state.info.constructions.add(newConstruction);
    final ctxdInput = generateCTXD(newConstruction);
    final parentIndex =
        state.expandList.indexWhere((element) => element.key == ctxd);
    state.expandList[parentIndex].child.add(ctxdInput);
    state = state.copyWith();
  }

  ///Xóa CTXD
  void deleteCTXD(String constructionId, String expandId) {
    state.info.constructions.removeWhere(
      (e) => e.id == constructionId,
    );

    state.expandList
        .firstWhere((element) => element.key == ctxd)
        .child
        .removeWhere((element) => element.id == expandId);
    state = state.copyWith();
  }

  void copyMucDichSDDatToTT(LandingPurposeModel landingPurposeModel) {
    landingPurposeModel
      ..realAreaWidth = landingPurposeModel.legalAreaWidth
      ..realAreaInPlan = landingPurposeModel.legalAreaInPlan
      ..realAreaUnPlan = landingPurposeModel.legalAreaUnPlan
      ..realPrivateArea = landingPurposeModel.legalPrivateArea
      ..realCommonArea = landingPurposeModel.legalCommonArea;

    final mucDichSDDatExpand =
        state.expandList.firstWhere((element) => element.key == mucDichSDDat);
    final item = mucDichSDDatExpand.child.firstWhere((element) =>
        element.key?.contains(landingPurposeModel.id ?? '') == true);
    // lsChild
    item.child[1] = listMucDichSDDatTT(landingPurposeModel);
    final lsLand = state.info.assetLandUsingPurposes;
    final itemIndex =
        lsLand.indexWhere((element) => element.id == landingPurposeModel.id);
    state.info.assetLandUsingPurposes[itemIndex] = landingPurposeModel;
    state = state.copyWith(info: state.info);
  }

  ///Ẩn hiện mô tả chi tiết
  void toggleMoTaChiTiet(bool? newValue) {
    // state.info.haveCayTrong = newValue;
    var lsDetail = [...state.info.detailDescribes];
    final parentIndex =
        state.expandList.indexWhere((element) => element.key == moTaChiTiet);
    if (newValue == false) {
      state.expandList[parentIndex].child = [];
      lsDetail = [];
    } else {
      if (state.info.detailDescribes.isEmpty) {
        lsDetail.add(DetailDescribeModel());
      }
      state.expandList[parentIndex]
        ..isExpand = newValue ?? false
        ..child = lsDetail
            .mapIndexed((index, element) => generateDetail(element))
            .toList();
    }
    state = state.copyWith(
      info: state.info.copyWith(detailDescribes: lsDetail),
    );
  }

  ///Generate 1 group detail
  ExpandModel generateDetail(DetailDescribeModel detailDescribeModel) {
    final lsInput = <InputFieldModel>[
      InputFieldModel<String>(
        label: S.current.ten_hang_muc,
        data: detailDescribeModel.categoryName,
        onTextChanged: (newValue) =>
            detailDescribeModel.categoryName = newValue,
      ),
      InputFieldModel<String>(
        label: S.current.dac_diem_kinh_te_ky_thuat,
        data: detailDescribeModel.feature,
        onTextChanged: (newValue) => detailDescribeModel.feature = newValue,
      ),
      InputFieldModel<String>(
        label: S.current.dien_tich_su_dung,
        data: detailDescribeModel.area,
        onTextChanged: (newValue) => detailDescribeModel.area = newValue,
      ),
    ];
    return ExpandModel(
      title: S.current.mo_ta_chi_tiet,
      isExpand: false,
      allowDelete: true,
      allowAdd: true,
      generateTitleIndex: true,
      child: const [],
      addNewExpandClicked: (context, ref, expandId) {
        addNewDetail();
      },
      removeExpandClicked: (context, ref, expandId) {
        deleteDetail(detailDescribeModel.id ?? '', expandId);
      },
      lsInputField: lsInput,
      topLsInputField: [],
    );
  }

  void addNewDetail() {
    DetailDescribeModel newDetail = DetailDescribeModel();
    state.info.detailDescribes.add(newDetail);
    final detailInput = generateDetail(newDetail);
    final parentIndex =
        state.expandList.indexWhere((element) => element.key == moTaChiTiet);
    state.expandList[parentIndex].child.add(detailInput);
    state = state.copyWith();
  }

  void deleteDetail(String detailId, String expandId) {
    state.info.detailDescribes.removeWhere(
      (e) => e.id == detailId,
    );

    state.expandList
        .firstWhere((element) => element.key == moTaChiTiet)
        .child
        .removeWhere((element) => element.id == expandId);
    state = state.copyWith();
  }

  @override
  Future<bool> saveData() async {
    final isValid = await super.saveData();
    if (isValid) {
      Navigator.of(context).pop(state.info);
    } else {
      String errorMess = '';
      for (var element in state.expandList) {
        errorMess = element.getError();
        if (errorMess.isNotEmpty) {
          errorMess = '${element.title} - $errorMess';
          break;
        }
      }
      showMessageDialog(errorMess);
    }
    return true;
  }
}
