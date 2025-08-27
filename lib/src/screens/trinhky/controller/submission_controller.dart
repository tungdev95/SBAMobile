// import 'package:get/get.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/approval_submission_model.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/assets/submission_detail_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/screens/other/pdf_viewer_page.dart';
import 'package:sba/src/screens/other/states/pdf_view_state.dart';
import 'package:sba/src/screens/sign/state/digital_sign_data_state.dart';
import 'package:sba/src/screens/trinhky/lichsu_pheduyet_page.dart';
import 'package:sba/src/screens/trinhky/widgets/ctxd_info_bottomsheet.dart';
import 'package:sba/src/screens/sign/digital_sign_page.dart';
import 'package:sba/src/screens/trinhky/widgets/ketqua_chitiet_bottomsheet.dart';
import 'package:sba/src/services/api/pdf_api.dart';
import 'package:sba/src/services/api/submission_api.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/utils/validator_util.dart';
import 'package:sba/src/widgets/bottomsheet/bottomsheet_dropdown_select.dart';
// import 'dart:collection';

class SubmissionPageController extends BaseController<PdfViewState> {
  SubmissionPageController(super.state, super.ref);

  static final pdfControllerProvider = StateNotifierProvider.autoDispose
      .family<SubmissionPageController, PdfViewState, AssetsModel?>(
          (ref, params) {
    return SubmissionPageController(
      PdfViewState(
        data: null,
        assetsModel: params,
        yKien: '',
      ),
      ref,
    );
  });

  bool firstInit = true;

  @override
  Future<void> initialLoad() async {
    getThongTinBuocDyet();
    getThongTinToTrinh();
    getPdf();
  }

  void getThongTinBuocDyet() async {
    final result =
        await ref.read(submissionApiProvider).getApprovalSubmissionInfo(
              appraisalFileId: state.assetsModel?.appraisalFileId ?? '',
            );
    if (!mounted) return;

    state = state.copyWith(submissionInfo: result.data);
  }

  void getThongTinToTrinh() async {
    final result = await ref.read(submissionApiProvider).chiTietToTrinh(
          appraisalFileId: state.assetsModel?.appraisalFileId ?? '',
          assetLevelTwoId: state.assetsModel?.assetLevelTwoId,
        );
    final lichSuToTrinh = await getLichSuToTrinh();
    if (!mounted) return;

    final tableKQDat = result.data?.tableKQDat ?? [];
    final tableKQCTXD = result.data?.tableKQCTXD ?? [];
    final tableKQ = result.data?.tableKQ ?? [];
    final assetType = state.assetsModel?.assetType;
    final lastItem = lichSuToTrinh.lastOrNull;

    final userLogin = ref.read(appController).userLogin;
    state = state.copyWith(
      submissionDetail: result.data,
      coQuyenDuyet: lastItem?.approvalNextEmployeeId == userLogin?.staffId,
      coQuyenKySo: lastItem?.approvalEmployeeId == userLogin?.staffId,
      lichSuToTrinh: lichSuToTrinh,
    );
  }

  ///Tải file pdf
  void getPdf() async {
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      showLoading();

      final result = await ref.read(pdfApiProvider).getSubmissionPdf(
            appraisalFileId: state.assetsModel?.appraisalFileId ?? '',
          );

      hideLoading();
      if ((result.data?.length ?? 0) == 0) {
        await showMessageDialog(S.current.pdf_load_error);
        Navigator.maybePop(context);
        return;
      }
      final attachment = result.data
          ?.toAttachment(name: state.assetsModel?.appraisalFileId ?? '');
      state = state.copyWith(data: attachment);
    });
  }

  ///Gửi duyệt hồ sơ
  void guiDuyetToTrinh(BuildContext context) async {
    if (isLoading) return;
    if (state.submissionInfo?.laCapDuyetCuoi == true) {
      duyetToTrinh(null);
    } else {
      chonCapDuyet(context, state.yKien ?? '');
    }
  }

  ///Chọn cấp duyệt tờ trình
  void chonCapDuyet(BuildContext context, String comment) async {
    showLoading();
    final result = await ref.read(submissionApiProvider).getListUserSubmission(
          appraisalFileId: state.assetsModel?.appraisalFileId ?? '',
        );
    hideLoading();

    var selectResult = await showModalBottomSheet<KeyValueModel?>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: DraggableScrollableSheet(
            minChildSize: .5,
            maxChildSize: .9,
            initialChildSize: .5,
            expand: false,
            builder: (context, controller) {
              return DropDownSelectionBottomSheet(
                title: S.current.chon_cap_duyet,
                lsDropDown: result ?? [],
                controller: controller,
              );
            },
          ),
        );
      },
    );

    if (selectResult != null) {
      duyetToTrinh(selectResult.key);
    }
  }

  void duyetToTrinh(String? approvalUserId) async {
    if (isShowLoading) return;
    if ((state.yKien ?? '').isEmpty) {
      showMessageDialog('Vui lòng nhập ${S.current.y_kien_duyet}');
      return;
    }
    final assetType = state.assetsModel?.assetType;
    List<ApprovalHistoryValue> approvalHistoryValues = [];
    //MMTB
    if (assetType == AssetsTypeEnum.mmtb) {
      state.submissionDetail?.tableKQ.forEach((element) {
        ApprovalHistoryValue item = ApprovalHistoryValue(
          approvalHistoryId: 0,
          valuationResultLandEstateId: element.valuationResultLandEstateId,
          assetChildId: element.assetChildId,
          assetGrandChildId: element.assetGrandChildId,
          name: element.name,
          type: element.type,
          totalArea: element.totalAreaApprovaled,
          unitPrice: element.unitPriceApprovaled,
          totalValue: element.totalValueApprovaled,
          realCommonMachine: element.realCommonMachine,
          productLineName: element.productLineName,
        );
        approvalHistoryValues.add(item);
      });
    } else {
      List<KQDatModel> listKQ = assetType == AssetsTypeEnum.chcc
          ? (state.submissionDetail?.tableKQ ?? [])
          : (state.submissionDetail?.tableKQDat ?? []);
      for (var element in listKQ) {
        ApprovalHistoryValue item = ApprovalHistoryValue(
          approvalHistoryId: 0,
          valuationResultLandEstateId: element.valuationResultLandEstateId,
          assetChildId: element.assetChildId ?? 0,
          assetGrandChildId: element.assetGrandChildId ?? 0,
          name: element.name,
          type: element.type ?? 0,
          totalArea: element.totalAreaApprovaled ?? 0.0,
          unitPrice: element.unitPriceApprovaled?.toInt(),
          totalValue: element.totalValueApprovaled?.toInt(),
          appraisalFileId: state.assetsModel?.appraisalFileId,
        );
        if (assetType == AssetsTypeEnum.ptdt) {
          item
            ..valuationResultWaterwayVehicleId =
                element.valuationResultWaterwayVehicleId
            ..valuationResultLandEstateId =
                element.valuationResultWaterwayVehicleId;
        } else if (assetType == AssetsTypeEnum.ptdb) {
          item
            ..valuationResultRoadVehicleId =
                element.valuationResultRoadVehicleId
            ..valuationResultLandEstateId =
                element.valuationResultRoadVehicleId;
        }
        approvalHistoryValues.add(item);
      }
    }

    List<ApprovalHistoryConstruction> approvalHistoryConstructionDtos = [];
    state.submissionDetail?.tableKQCTXD.forEach((element) {
      ApprovalHistoryConstruction item = ApprovalHistoryConstruction(
        approvalHistoryId: 0,
        constructionId: element.constructionId,
        assetLandInforId: element.assetLandInforId,
        constructionTypeName: element.constructionType?.constructionTypeName,
        constructionName: element.constructionName?.constructionName,
        constructionArea: element.constructionArea,
        remainingQuality: element.remainingQuality,
        mdht: element.mdht,
        unitPrice: element.unitPriceApprovaled,
        totalValue: element.totalValueApprovaled,
      );
      approvalHistoryConstructionDtos.add(item);
    });

    final body = ApproveSubmission(
      approvalSubmissionId: state.submissionInfo?.approvalSubmissionId,
      approvalEmployeeId: ref.read(appController).userLogin?.staffId,
      approvalNextEmployeeId: approvalUserId,
      approvalComment: state.yKien,
      approvalHistoryValues: approvalHistoryValues,
      approvalHistoryConstructionDtos: approvalHistoryConstructionDtos,
      constructionFutureValue:
          state.submissionDetail?.tableTong?.constructionFutureValueApprovaled,
    );
    showLoading();

    ApiResponse<dynamic> result =
        await ref.read(submissionApiProvider).acceptSubmission(
              body: body,
            );

    hideLoading();
    final isOK = await handleResponse(result, (p0) => null);
    if (isOK) {
      BotToast.showText(text: S.current.thao_tac_thanh_cong);
      AppRoutes.popUntilCustom(context, 'MainPage');
    }
  }

  /// Từ chối tờ trình
  void tuChoi(BuildContext context) async {
    if (state.yKien?.isEmpty == true) {
      showMessageDialog(S.current.vui_long_nhap_y_kien_tu_choi);
      return;
    }
    showLoading();
    final result = await ref.read(submissionApiProvider).cancelSubmission(
          approvalSubmissionId: state.submissionInfo?.approvalSubmissionId,
          approvalEmployeeId: ref.read(appController).userLogin?.staffId,
          approvalComment: state.yKien,
        );
    hideLoading();
    final isOK = await handleResponse(result, (p0) => null);
    if (isOK) {
      BotToast.showText(text: S.current.thao_tac_thanh_cong);
      Navigator.maybePop(context);
    }
  }

  ///Mở pdf full screen
  void fullScreenPdf(BuildContext context) {
    if (state.data == null) return;
    AppRoutes.push(
      context,
      ProviderScope(
        overrides: [
          pdfViewProvider
              .overrideWithValue((assetsModel: null, file: state.data)),
        ],
        child: PdfViewerPage(
          pageTitle: S.current.thong_tin_to_trinh,
        ),
      ),
    );
  }

  void chiTietInfo(BuildContext context, KQDatModel item) {
    final assets = state.assetsModel;
    if (assets?.assetType == AssetsTypeEnum.ptdb ||
        assets?.assetType == AssetsTypeEnum.ptdt) {
      chiTietPTDB(context, item);
    } else {
      chiTietGiaDat(context, item);
    }
  }

  /// Hiển thị chi tiết giá đất
  void chiTietGiaDat(BuildContext context, KQDatModel item) async {
    final tenTaiSan = InputFieldModel<String>(
      label: S.current.ten_tai_san,
      data: item.name,
      enable: item.isValuationResultProject == true,
      required: item.isValuationResultProject == true,
      onTextChanged: (newValue) {
        item.name = newValue;
      },
    );
    final giaTri = InputFieldModel<int>(
      label: S.current.gia_tri,
      data: item.totalValueApprovaled,
      isCurrency: true,
      onTextChanged: (newValue) {
        item.totalValueApprovaled = newValue;
      },
    );
    final dienTich = InputFieldModel<double>(
      label: S.current.dien_tich,
      data: item.totalAreaApprovaled,
      onTextChanged: (newValue) {
        item.totalAreaApprovaled = newValue;
        if (item.isValuationResultProject != true) {
          item.totalValueApprovaled = ((item.totalAreaApprovaled ?? 0.0) *
                  (item.unitPriceApprovaled ?? 0))
              .toInt();
          giaTri.updateText
              ?.call((item.totalValueApprovaled ?? 0).toPriceFormat());
        }
      },
    );
    final donGia = InputFieldModel<int>(
      label: S.current.don_gia,
      data: item.unitPriceApprovaled,
      isCurrency: true,
      onTextChanged: (newValue) {
        item.unitPriceApprovaled = newValue;
        if (item.isValuationResultProject != true) {
          item.totalValueApprovaled = ((item.totalAreaApprovaled ?? 0.0) *
                  (item.unitPriceApprovaled ?? 0))
              .toInt();
          giaTri.updateText
              ?.call((item.totalValueApprovaled ?? 0).toPriceFormat());
        }
      },
    );

    final phanLoai = InputFieldModel<String>(
      label: S.current.phan_loai,
      data: item.typeString,
      enable: false,
    );

    final lsItem = [
      tenTaiSan,
      if (item.typeString.isNotEmpty) phanLoai,
      dienTich,
      donGia,
      giaTri,
    ];
    await showModalBottomSheet<KQDatModel>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: KetQuaChiTietBottomSheet(
            lsItem: lsItem,
          ),
        );
      },
    );
    state = state.copyWith();
  }

  /// Hiển thị chi tiết CTXD
  void chiTietCTXD(BuildContext context, KQCTXDModel item) async {
    final giaTri = InputFieldModel<int>(
      label: S.current.gia_tri,
      data: item.totalValueApprovaled,
      isCurrency: true,
      onTextChanged: (newValue) => item.totalValueApprovaled = newValue,
    );
    final clcl = InputFieldModel<double>(
      label: S.current.clcl,
      data: item.remainingQuality,
      onTextChanged: (newText) {
        item.remainingQuality = newText;
        item.totalValueApprovaled = calculateTotalValue(item);
        giaTri.updateText
            ?.call((item.totalValueApprovaled ?? 0).toPriceFormat());
      },
      validator: Validator.validatePercent,
      required: false,
    );
    final mdht = InputFieldModel<double>(
      label: S.current.muc_do_hoan_thien,
      data: item.mdht,
      onTextChanged: (newText) {
        item.mdht = newText;
        item.totalValueApprovaled = calculateTotalValue(item);
        giaTri.updateText
            ?.call((item.totalValueApprovaled ?? 0).toPriceFormat());
      },
      validator: Validator.validatePercent,
      required: false,
    );
    final dienTich = InputFieldModel<double>(
      label: S.current.dien_tich,
      data: item.constructionArea,
      onTextChanged: (newValue) {
        item.constructionArea = newValue;
        item.totalValueApprovaled = calculateTotalValue(item);
        giaTri.updateText
            ?.call((item.totalValueApprovaled ?? 0).toPriceFormat());
      },
    );
    final donGia = InputFieldModel<int>(
      label: S.current.don_gia,
      data: item.unitPriceApprovaled,
      isCurrency: true,
      onTextChanged: (newValue) {
        item.unitPriceApprovaled = newValue;
        item.totalValueApprovaled = calculateTotalValue(item);
        giaTri.updateText
            ?.call((item.totalValueApprovaled ?? 0).toPriceFormat());
      },
    );
    final lsItem = [
      InputFieldModel<String>(
        label: S.current.phan_loai,
        data: item.constructionType?.constructionTypeName,
        enable: false,
      ),
      InputFieldModel<String>(
        label: S.current.ten_ctrinh,
        data: item.constructionName?.constructionName,
        enable: false,
      ),
      clcl,
      mdht,
      dienTich,
      donGia,
      giaTri
    ];
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: KetQuaChiTietCTXD(
            // item: item,
            lsItem: lsItem,
          ),
        );
      },
    );
    state = state.copyWith();
  }

  int calculateTotalValue(KQCTXDModel item) {
    if (item.remainingQuality != null && item.mdht != null) {
      return ((item.constructionArea ?? 0.0) * (item.unitPriceApprovaled ?? 0))
          .round();
    }
    if (item.remainingQuality != null) {
      return ((item.constructionArea ?? 0.0) *
              (item.unitPriceApprovaled ?? 0).toDouble() *
              ((item.remainingQuality ?? 0.0) / 100))
          .round();
    }
    return 0;
  }

  /// Hiển thi chi tiết PTDB
  void chiTietPTDB(BuildContext context, KQDatModel item) async {
    final tenTaiSan = InputFieldModel<String>(
      label: S.current.ten_tai_san,
      data: item.name,
      enable: false,
    );
    final giaTri = InputFieldModel<int>(
      label: S.current.gia_tri,
      data: item.totalValueApprovaled,
      isCurrency: true,
      enable: false,
    );
    final donGia = InputFieldModel<int>(
      label: S.current.don_gia_,
      data: item.unitPriceApprovaled,
      isCurrency: true,
      onTextChanged: (newValue) {
        item.unitPriceApprovaled = newValue;
        item.totalValueApprovaled = newValue;
        giaTri.updateText
            ?.call((item.totalValueApprovaled ?? 0).toPriceFormat());
      },
    );

    final lsItem = [
      InputFieldModel<String>(
        label: S.current.ten_tai_san,
        data: item.name,
        enable: false,
      ),
      donGia,
      giaTri,
    ];

    KQDatModel? result = await showModalBottomSheet<KQDatModel>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: KetQuaChiTietBottomSheet(
            // item: item,
            lsItem: lsItem,
          ),
        );
      },
    );
    state = state.copyWith();
    // if (result != null) {
    //   item
    //     ..unitPriceApprovaled = result.unitPriceApprovaled
    //     ..totalValueApprovaled = result.totalValueApprovaled;
    // }
  }

  ///Ký số
  void kySo(BuildContext context) {
    AppRoutes.push(
      context,
      ProviderScope(
        overrides: [
          digitalSignDataProvider.overrideWithValue(
            DigitalSignDataState(
              appraisalFilesId: state.assetsModel?.appraisalFileId ?? '',
              fileStatus: FileStatus.choDuyet,
            ),
          )
        ],
        child: const DigitalSignPage(),
      ),
    );
  }

  ///Hiển thị lịch sử tờ trình
  void lichSuToTrinh(BuildContext context) async {
    AppRoutes.push(
      context,
      ProviderScope(
        overrides: [assetInfo.overrideWithValue(state.assetsModel!)],
        child: const LichSuPheDuyetPage(),
      ),
    );
  }

  Future<List<ApprovalHistory>> getLichSuToTrinh() async {
    final result = await ref
        .read(submissionApiProvider)
        .getSubmissionHistory(state.assetsModel?.appraisalFileId);
    if (result.status == Status.complete) {
      return result.data?.approvalHistoryDtos ?? [];
    }
    return [];
  }

  void chiTietMMTB(BuildContext context, KQDatModel e) async {
    final tenTaiSan = InputFieldModel<String>(
      label: S.current.ten_tai_san,
      data: e.name,
      enable: false,
    );
    final soLuongMMTB = InputFieldModel<int>(
      label: S.current.so_luong_MMTB,
      data: e.realCommonMachine,
      enable: false,
    );

    final giaTri = InputFieldModel<int>(
      label: S.current.gia_tri,
      data: e.totalValueApprovaled,
      isCurrency: true,
      enable: false,
    );

    final donGia = InputFieldModel<int>(
      label: S.current.don_gia_,
      data: e.unitPriceApprovaled,
      isCurrency: true,
      onTextChanged: (newValue) {
        e.unitPriceApprovaled = newValue;
        final newPrive =
            (e.unitPriceApprovaled ?? 0) * (e.realCommonMachine ?? 0);
        e.totalValueApprovaled = newPrive;
        giaTri.updateText?.call(newPrive.toPriceFormat());
      },
    );

    final lsItem = [
      InputFieldModel<String>(
        label: S.current.ten_tai_san,
        data: e.name,
        enable: false,
      ),
      soLuongMMTB,
      donGia,
      giaTri,
    ];

    await showModalBottomSheet<KQDatModel>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: KetQuaChiTietBottomSheet(
            lsItem: lsItem,
          ),
        );
      },
    );
    state = state.copyWith();
  }

  void reloadUI() {
    state = state.copyWith();
  }
}
