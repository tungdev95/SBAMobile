import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/utils/validator_util.dart';

class CongTrinhTuongLaiController
    extends BaseDetailInfoPageController<DetailLandState> {
  CongTrinhTuongLaiController(super.state, super.ref);

  static final detailLandInfoProvider = StateNotifierProvider.autoDispose
      .family<CongTrinhTuongLaiController, DetailLandState, DetailData>(
    (ref, element) {
      final controller = CongTrinhTuongLaiController(
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

    ExpandModel chiTieu = ExpandModel(
      key: chiTieuKey,
      title: S.current.chi_tieu,
      isExpand: true,
      child: generateChiTieu(landInfo),
      lsInputField: [],
      topLsInputField: [],
    );

    ExpandModel thongTinCongTrinh = ExpandModel(
      title: S.current.thong_tin_cong_trinh,
      isExpand: true,
      child: const [],
      lsInputField: [
        InputFieldModel<double>(
          label: S.current.tong_dien_tich_dat_quy_hoach,
          data: landInfo.totalArea,
          onTextChanged: (newValue) => landInfo.totalArea = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.mat_do_xay_dung,
          data: landInfo.buildingDensity,
          onTextChanged: (newValue) => landInfo.buildingDensity = newValue,
          required: false,
          validator: Validator.validatePercent,
        ),
        InputFieldModel<double>(
          label: S.current.he_so_sd_dat,
          data: landInfo.coeffcientsUsed,
          onTextChanged: (newValue) => landInfo.coeffcientsUsed = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.chieu_cao_cong_trinh,
          data: landInfo.height,
          onTextChanged: (newValue) => landInfo.height = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.tong_dt_san_xay_dung,
          data: landInfo.totalFloorArea,
          required: true,
          onTextChanged: (newValue) => landInfo.totalFloorArea = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.so_tang,
          data: landInfo.numOfFloors,
          onTextChanged: (newValue) => landInfo.numOfFloors = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.tong_can_ho,
          data: landInfo.totalApartments,
          onTextChanged: (newValue) => landInfo.totalApartments = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.be_nuoc_ngam,
          data: landInfo.underTankArea,
          onTextChanged: (newValue) => landInfo.underTankArea = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.be_nuoc_thai,
          data: landInfo.wasteTankArea,
          onTextChanged: (newValue) => landInfo.wasteTankArea = newValue,
        ),
      ],
      topLsInputField: [],
    );

    ExpandModel phanNgam = ExpandModel(
      title: S.current.phan_ngam,
      isExpand: true,
      child: [],
      lsInputField: [
        InputFieldModel<double>(
          label: S.current.so_tang,
          data: landInfo.numOfUnderFloors,
          onTextChanged: (newValue) => landInfo.numOfUnderFloors = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.cot_san_tang_ham_1,
          data: double.tryParse(landInfo.basementFloor ?? ''),
          onTextChanged: (newValue) =>
              landInfo.basementFloor = newValue.toString(),
        ),
        InputFieldModel<double>(
          label: S.current.chieu_sau_cong_trinh,
          data: landInfo.depth,
          onTextChanged: (newValue) => landInfo.depth = newValue,
        ),
      ],
      topLsInputField: [],
    );

    ExpandModel phanNoi = ExpandModel(
      title: S.current.phan_noi,
      isExpand: true,
      child: const [],
      lsInputField: [
        InputFieldModel<double>(
          label: S.current.cot_san_xd_tang_1,
          data: double.tryParse(landInfo.constructionFloor ?? ''),
          onTextChanged: (newValue) =>
              landInfo.constructionFloor = newValue.toString(),
        ),
        InputFieldModel<double>(
          label: S.current.dien_tich_xay_dung_m2,
          data: landInfo.constructionArea,
          onTextChanged: (newValue) => landInfo.constructionArea = newValue,
        ),
      ],
      topLsInputField: [],
    );

    ExpandModel thongTinKhac = ExpandModel(
      title: S.current.thong_tin_khac,
      isExpand: true,
      child: const [],
      lsInputField: [
        InputFieldModel<String>(
          label: S.current.phan_ham,
          data: landInfo.turnPart,
          onTextChanged: (newValue) => landInfo.turnPart = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.phan_de,
          data: landInfo.solePart,
          onTextChanged: (newValue) => landInfo.solePart = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.phan_thap,
          data: landInfo.towerPart,
          onTextChanged: (newValue) => landInfo.towerPart = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.cac_de_muc_ct,
          data: landInfo.constructionTitle,
          onTextChanged: (newValue) => landInfo.constructionTitle = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.giai_phap_ket_cau,
          data: landInfo.structuralSolution,
          onTextChanged: (newValue) => landInfo.structuralSolution = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.giai_phap_kien_truc,
          data: landInfo.architectualSolution,
          onTextChanged: (newValue) => landInfo.architectualSolution = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.phan_dien_nuoc_tong_the,
          data: landInfo.systemEngineering,
          onTextChanged: (newValue) => landInfo.systemEngineering = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.he_thong_giao_thong,
          data: landInfo.systemTraffic,
          onTextChanged: (newValue) => landInfo.systemTraffic = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.noi_that,
          data: landInfo.interior,
          onTextChanged: (newValue) => landInfo.interior = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.nhan_dinh_du_toan,
          data: landInfo.estimateComment,
          onTextChanged: (newValue) => landInfo.estimateComment = newValue,
        ),
      ],
      topLsInputField: [],
    );

    ExpandModel congTrinh = ExpandModel(
      key: congTrinhKey,
      title: S.current.cong_trinh,
      isExpand: true,
      child: generateCongTrinh(landInfo),
      lsInputField: [],
      topLsInputField: [],
    );

    lsExpand.add(chiTieu);
    lsExpand.add(thongTinCongTrinh);
    lsExpand.add(phanNgam);
    lsExpand.add(phanNoi);
    lsExpand.add(thongTinKhac);
    lsExpand.add(congTrinh);

    state = state.copyWith(expandList: lsExpand);
  }

  ///Chỉ tiêu
  List<ExpandModel> generateChiTieu(AssetLandInfo landInfo) {
    final result = <ExpandModel>[];
    // final lsInput = <>[];
    var furureInfos = landInfo.constructionFutureInfors;
    if (furureInfos.isEmpty) {
      furureInfos.add(ConstructionFutureInfo());
    }
    for (var i = 0; i < furureInfos.length; i++) {
      final info = furureInfos[i];
      final lsInput = <InputFieldModel>[];
      final legalExpand = getChiTieuExpandItem(info);
      result.add(legalExpand);
    }

    return result;
  }

  ///Thêm Chỉ tiêu
  void addNewChiTieu() {
    final newItem = ConstructionFutureInfo();
    state.landInfo.constructionFutureInfors.add(newItem);
    final chiTieuExpandItem = getChiTieuExpandItem(newItem);
    var lsExpand = state.expandList;
    lsExpand
        .firstWhere((element) => element.key == chiTieuKey)
        .child
        .add(chiTieuExpandItem);
    state = state.copyWith();
  }

  ///Xóa chỉ tiêu
  void removeChiTieu(String expandId, String itemId) {
    state.landInfo.constructionFutureInfors.removeWhere((e) => e.id == itemId);
    var lsExpand = state.expandList;
    lsExpand
        .firstWhere((element) => element.key == chiTieuKey)
        .child
        .removeWhere((element) => element.id == expandId);
    state = state.copyWith();
  }

  ///Generate 1 chi tieu
  ExpandModel getChiTieuExpandItem(ConstructionFutureInfo item) {
    final tenChiTieu = InputFieldModel<String>(
      label: S.current.ten_chi_tieu,
      data: item.name,
      onTextChanged: (newValue) => item.name = newValue,
    );

    final thietKeCoSo = InputFieldModel<String>(
      label: S.current.thiet_ke_co_so,
      data: item.basicDesign,
      onTextChanged: (newValue) => item.basicDesign = newValue,
    );

    final quyetDinh = InputFieldModel<String>(
      label: S.current.quyet_dinh,
      data: item.decision,
      onTextChanged: (newValue) => item.decision = newValue,
    );

    return ExpandModel(
      title: S.current.chi_tieu,
      isExpand: true,
      generateTitleIndex: true,
      allowAdd: true,
      allowDelete: true,
      child: const [],
      removeExpandClicked: (context, ref, expandId) {
        removeChiTieu(expandId, item.id ?? '');
      },
      addNewExpandClicked: (context, ref, expandId) {
        addNewChiTieu();
      },
      lsInputField: [
        tenChiTieu,
        thietKeCoSo,
        quyetDinh,
      ],
      topLsInputField: [],
    );
  }

  ///Công trình
  List<ExpandModel> generateCongTrinh(AssetLandInfo landInfo) {
    final result = <ExpandModel>[];
    // final lsInput = <>[];
    var furureInfos = landInfo.constructionChecklists;
    if (furureInfos.isEmpty) {
      furureInfos.add(ConstructionCheckList());
    }
    for (var i = 0; i < furureInfos.length; i++) {
      final info = furureInfos[i];
      final lsInput = <InputFieldModel>[];
      final legalExpand = getCongTrinhExpandItem(info);
      result.add(legalExpand);
    }

    return result;
  }

  ///Thêm công trình
  void addNewCongTrinh() {
    final newItem = ConstructionCheckList();
    state.landInfo.constructionChecklists.add(newItem);
    final chiTieuExpandItem = getCongTrinhExpandItem(newItem);
    var lsExpand = state.expandList;
    lsExpand
        .firstWhere((element) => element.key == congTrinhKey)
        .child
        .add(chiTieuExpandItem);
    state = state.copyWith();
  }

  ///Xóa cong trinh
  void removeCongTrinh(String expandId, String itemId) {
    state.landInfo.constructionChecklists.removeWhere((e) => e.id == itemId);
    var lsExpand = state.expandList;
    lsExpand
        .firstWhere((element) => element.key == congTrinhKey)
        .child
        .removeWhere((element) => element.id == expandId);
    state = state.copyWith();
  }

  ///Generate 1 cong trinh
  ExpandModel getCongTrinhExpandItem(ConstructionCheckList item) {
    final tenCongTrinh = InputFieldModel<String>(
      label: S.current.ten_cong_trinh,
      data: item.name,
      onTextChanged: (newValue) => item.name = newValue,
    );
    final dtXdTangTret = InputFieldModel<double>(
      label: S.current.dt_xay_dung_tang_tret,
      data: item.groundFloorArea,
      onTextChanged: (newValue) => item.groundFloorArea = newValue,
    );
    final tongDtSan = InputFieldModel<double>(
      label: S.current.tong_dt_san,
      data: item.totalFloorArea,
      onTextChanged: (newValue) => item.totalFloorArea = newValue,
    );
    final chieuCaoCongTrinh = InputFieldModel<double>(
      label: S.current.chieu_cao_ct,
      data: item.height,
      onTextChanged: (newValue) => item.height = newValue,
    );
    final soTang = InputFieldModel<double>(
      label: S.current.so_tang,
      data: item.numOfFloor,
      onTextChanged: (newValue) => item.numOfFloor = newValue,
    );
    final chieuDai = InputFieldModel<double>(
      label: S.current.chieu_dai_m2,
      data: item.length,
      onTextChanged: (newValue) => item.length = newValue,
    );
    final chieuSau = InputFieldModel<double>(
      label: S.current.chieu_sau_cong_trinh,
      data: item.depth,
      onTextChanged: (newValue) => item.depth = newValue,
    );

    return ExpandModel(
      title: S.current.cong_trinh,
      isExpand: true,
      generateTitleIndex: true,
      allowAdd: true,
      allowDelete: true,
      child: const [],
      removeExpandClicked: (context, ref, expandId) {
        removeCongTrinh(expandId, item.id ?? '');
      },
      addNewExpandClicked: (context, ref, expandId) {
        addNewCongTrinh();
      },
      lsInputField: [
        tenCongTrinh,
        dtXdTangTret,
        tongDtSan,
        chieuCaoCongTrinh,
        soTang,
        chieuDai,
        chieuSau,
      ],
      topLsInputField: [],
    );
  }

  // @override
  // Future<bool> saveData() async {
  //   final isValid = await super.saveData();
  //   Navigator.of(context).pop(state.landInfo);
  //   return true;
  // }

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
}
