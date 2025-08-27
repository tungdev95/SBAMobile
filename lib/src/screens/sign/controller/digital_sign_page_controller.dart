import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/helper/digital_sign.dart';
import 'package:sba/src/models/assets/approval_submission_model.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/models/base/base_api_model.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/screens/sign/state/digital_sign_data_state.dart';
import 'package:sba/src/screens/sign/state/digital_sign_state.dart';
import 'package:sba/src/services/api/assets_api.dart';
import 'package:sba/src/services/api/submission_api.dart';
import 'package:sba/src/services/base_api_services.dart';
import 'package:sba/src/widgets/bottomsheet/bottomsheet_dropdown_select.dart';

class DigitalSignPageController extends BaseController<DigitalSignState> {
  DigitalSignPageController(super.state, super.ref);

  AssetsModel? assetDetail;
  ApprovalSubmissionInfo? submissionInfo;

  static final digitalSignPageController = StateNotifierProvider.autoDispose
      .family<DigitalSignPageController, DigitalSignState,
          DigitalSignDataState>(
    (ref, arg) {
      return DigitalSignPageController(
        DigitalSignState(
          appraisalFilesId: arg.appraisalFilesId ?? '',
          fileStatus: arg.fileStatus,
        ),
        ref,
      );
    },
  );

  @override
  Future<void> initialLoad() async {
    super.initialLoad();
    getLichSuToTrinh();
    await getTBKQThamDinh();
    getKQThamDinh();
    getSubmissionInfo();
    getAssetsDetail();
  }

  String getPdfUrl(int page) {
    // final baseUrl = ref.read(dioProvider).options.baseUrl;
    if (state.fileStatus == FileStatus.daKySo ||
        state.fileStatus == FileStatus.daGuiThongBao ||
        state.fileStatus == FileStatus.daGuiKQThamDinh) {
      return 'report/api/v1/signature/appraisal?appraisalFilesId=${state.appraisalFilesId}&page=$page';
    } else {
      final type = page == 1 ? 'inform' : 'result';
      final url = 'report/api/v1/$type/${state.appraisalFilesId}';
      return url;
    }
  }

  Future<void> getAssetsDetail() async {
    final result = await ref.read(assetsApiProvider).getAssetDetailFromFileId(
          appraisalFileId: state.appraisalFilesId,
        );

    assetDetail = result.data;
  }

  /// Ký số
  void kySo(BuildContext context) async {
    if (isShowLoading) return;
    final loginResponse = await DigitalSign.instance.getAuthentication();
    if ((loginResponse ?? '').isEmpty) {
      BotToast.showText(text: S.current.thong_tin_chu_ky_so_khong_hop_le);
      return;
    }
    showLoading();
    final result = await ref.read(submissionApiProvider).startSign(
          appraisalFileId: state.appraisalFilesId,
          accessToken: loginResponse ?? '',
          page: state.pageIndex,
        );
    hideLoading();
    if (await handleResponse(result, (p0) => null)) {
      final signResult = await DigitalSign.instance.startSign(result.data);

      if (signResult != null && signResult.statusDesc.isNotEmpty) {
        if (signResult.statusDesc == 'REJECTED_SUCCESS') {
          BotToast.showText(text: signResult.data.toString());
        } else {
          changeStatusAndComplete(context, loginResponse);
        }
      } else {
        BotToast.showText(text: S.current.ky_so_khong_thanh_cong);
      }
    } else {
      if (result.exception?.code == 201) {
        //Đã ký số xong hết, call api hoàn thành
        changeStatusAndComplete(context, loginResponse);
      } else if (result.exception?.code == 202) {
        //Trang này đã được ký, vui lòng ký trang sau
      }
    }
  }

  void changeTab(int index) {
    state = state.copyWith(pageIndex: index + 1);
  }

  void changeStatusAndComplete(
    BuildContext context,
    String? loginResponse,
  ) async {
    showLoading();
    await ref.read(submissionApiProvider).checkStatus(
          appraisalFileId: state.appraisalFilesId,
          accessToken: loginResponse ?? '',
        );
    final detailResponse = await ref
        .read(
          assetsApiProvider,
        )
        .getAssetDetailFromFileId(
          appraisalFileId: state.appraisalFilesId,
        );
    hideLoading();
    if (detailResponse.data?.fileStatus == FileStatus.daKySo) {
      BotToast.showText(text: S.current.thao_tac_thanh_cong);
      Navigator.maybePop(context);
    }
  }

  Future<void> getTBKQThamDinh() async {
    final Response<Uint8List?> result = await ref.read(dioProvider).get(
          getPdfUrl(1),
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${ref.read(appController).userLogin?.accessToken}'
            },
            responseType: ResponseType.bytes,
          ),
        );
    if (result.data != null) {
      if (!mounted) return;
      state = state.copyWith(tbkqThamDinh: result.data);
    }
  }

  Future<void> getKQThamDinh() async {
    final Response<Uint8List?> result = await ref.read(dioProvider).get(
          getPdfUrl(2),
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${ref.read(appController).userLogin?.accessToken}'
            },
            responseType: ResponseType.bytes,
          ),
        );
    if (result.data != null) {
      if (!mounted) return;
      state = state.copyWith(kqThamDinh: result.data);
    }
  }

  void getLichSuToTrinh() async {
    final result = await ref
        .read(submissionApiProvider)
        .getSubmissionHistory(state.appraisalFilesId);
    if (result.status == Status.complete) {
      var history = result.data?.approvalHistoryDtos ?? [];
      final lastItem = history.lastOrNull;
      final userLogin = ref.read(appController).userLogin;
      final coQuyenKySo = lastItem?.approvalEmployeeId == userLogin?.staffId;
      state = state.copyWith(coQuyenKySo: coQuyenKySo);
    } else {
      state = state.copyWith(coQuyenKySo: false);
    }
  }

  void getSubmissionInfo() async {
    final result =
        await ref.read(submissionApiProvider).getApprovalSubmissionInfo(
              appraisalFileId: state.appraisalFilesId,
            );
    if (!mounted) return;
    submissionInfo = result.data;
  }

  void tuChoiToTrinh(BuildContext context) async {
    final result = await showTextInputDialog(
      context: context,
      title: S.current.ly_do_tu_choi,
      isDestructiveAction: false,
      textFields: [
        DialogTextField(
          hintText: S.current.ly_do_tu_choi,
          maxLines: 1,
          maxLength: 255,
        ),
      ],
    );
    if (result == null) return;
    if (result.any((element) => element.isEmpty)) {
      await showMessageDialog('Vui lòng nhập lý do từ chối');
      tuChoiToTrinh(context);
    }
    showLoading();
    final cancelResult = await ref.read(submissionApiProvider).cancelSubmission(
          approvalSubmissionId: submissionInfo?.approvalSubmissionId,
          approvalEmployeeId: ref.read(appController).userLogin?.staffId,
          approvalComment: result.firstOrNull ?? '',
        );
    hideLoading();
    final isOK = await handleResponse(cancelResult, (p0) => null);
    if (isOK) {
      BotToast.showText(text: S.current.thao_tac_thanh_cong);
      Navigator.maybePop(context);
    }
  }

  ///Chọn người ủy quyền
  void chonCapDuyet(BuildContext context) async {
    showLoading();
    final result = await ref.read(submissionApiProvider).getStaffCanSign(
          companyBranchId: assetDetail?.appraisalUnit,
          totalPrice: submissionInfo?.total,
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

    showLoading();
    final changeUserResult =
        await ref.read(submissionApiProvider).dieuChinhNguoiKySo(
              appraisalFileId: state.appraisalFilesId,
              staffId: selectResult?.key,
            );
    hideLoading();
    final isOK = await handleResponse(changeUserResult, (p0) => null);
    if (isOK) {
      BotToast.showText(text: S.current.thao_tac_thanh_cong);
      Navigator.maybePop(context);
    }
  }
}
