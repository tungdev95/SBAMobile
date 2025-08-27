import 'dart:typed_data';

import 'package:bot_toast/bot_toast.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/event/asset_event.dart';
import 'package:sba/src/event/event_bus.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/screens/other/pdf_viewer_page.dart';
import 'package:sba/src/services/api/assets_api.dart';
import 'package:sba/src/services/api/pdf_api.dart';
import 'package:sba/src/sign/states/sign_state.dart';
import 'package:sba/src/utils/utils.dart';

class SignPageController extends BaseController<SignState> {
  SignPageController(super.state, super.ref);

  static final signPageProvider = StateNotifierProvider.autoDispose
      .family<SignPageController, SignState, AssetsModel>((ref, params) {
    return SignPageController(
      SignState(
        assetsModel: params,
      ),
      ref,
    )..getPdf();
  });

  void updateChuKyChuyenVien(Uint8List? uint8list) {
    state = state.copyWith(chuKyChuyenVien: uint8list);
  }

  void updateChuKyKhachHang(Uint8List? uint8list) {
    state = state.copyWith(chuKyKhachHang: uint8list);
  }

  ///Tải file pdf
  void getPdf() async {
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      showLoading();

      final result = await ref.read(pdfApiProvider).getSurveyDetail(
            appraisalFileId: state.assetsModel?.appraisalFileId ?? '',
            typeExport: state.assetsModel?.exportType,
          );

      final assetDetail = await ref.read(assetsApiProvider).getAssetDetailRaw(
            assetLevelTwoId: state.assetsModel?.assetType.assetsLevel2Id ??
                AssetsTypeEnum.bds.assetsLevel2Id,
            assetCodes: state.assetsModel?.assetCodes ?? [],
          );

      final assetCommons = state.assetsModel?.assetCommons ?? [];
      if (assetDetail.data is List) {
        for (var e in (assetDetail.data as List)) {
          var assetLevel3Id = assetCommons
              .firstWhereOrNull((child) => e['assetCode'] == child.assetCode)
              ?.assetLevelThreeId;
          e['assetLevelThreeId'] = assetLevel3Id;
        }
        state = state.copyWith(data: assetDetail.data);
      }

      hideLoading();
      if ((result.data?.length ?? 0) == 0) {
        await showMessageDialog(S.current.pdf_load_error);
        Navigator.maybePop(context);
      }
      final attachment = result.data
          ?.toAttachment(name: state.assetsModel?.appraisalFileId ?? '');
      state = state.copyWith(attachment: attachment);
    });
    // print('okokok');
  }

  ///Mở pdf full screen
  void fullScreenPdf(BuildContext context) {
    if (state.attachment == null) return;
    AppRoutes.push(
      context,
      ProviderScope(
        overrides: [
          pdfViewProvider.overrideWithValue(
            (assetsModel: null, file: state.attachment),
          ),
        ],
        child: const PdfViewerPage(),
      ),
    );
  }

  void deleteCustomerSign() {
    state = state.deleteCustomerSign();
  }

  void deleteStaffSign() {
    state = state.deleteStaffSign();
  }

  ///Hoàn thành biên bản
  void complete() async {
    if (isShowLoading) return;
    if (state.chuKyChuyenVien == null) {
      showMessageDialog(S.current.nhanvien_kyten_validate);
      return;
    }
    if (state.chuKyKhachHang == null) {
      showMessageDialog(S.current.chu_so_huu_kyten_validate);
      return;
    }

    final appraisalFileId = state.assetsModel?.appraisalFileId ?? '';
    showLoading();

    final result = await ref.read(assetsApiProvider).uploadSignature(
          appraisalFileId: appraisalFileId,
          imageStaffSign: state.chuKyChuyenVien!,
          imageCustomerSign: state.chuKyKhachHang!,
          typeExport: state.assetsModel?.exportType,
        );

    final isOK = await handleResponse(result, (p0) => null);
    if (isOK) {
      final completeResult = await ref.read(assetsApiProvider).completeSurvey(
            appraisalFileId: appraisalFileId,
            data: state.data,
          );
      if (await handleResponse(completeResult, (p0) => null)) {
        hideLoading();
        await AppRoutes.popUntilCustom(context, 'MainPage');
        eventBus.fire(
          CompleteAssetEvent(
            id: state.assetsModel?.appraisalFileId,
          ),
        );
        BotToast.showText(text: S.current.thao_tac_thanh_cong);
        return;
      }
    }
    hideLoading();
  }
}
