// import 'package:get/get.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/screens/other/states/pdf_view_state.dart';
import 'package:sba/src/services/api/assets_api.dart';
import 'package:sba/src/services/api/pdf_api.dart';

class PdfViewerPageController extends BaseController<PdfViewState> {
  PdfViewerPageController(super.state, super.ref);

  static final pdfControllerProvider = StateNotifierProvider.autoDispose.family<
      PdfViewerPageController,
      PdfViewState,
      ({AttachmentFile? file, AssetsModel? assetsModel})>((ref, params) {
    return PdfViewerPageController(
      PdfViewState(
        data: params.file,
        assetsModel: params.assetsModel,
      ),
      ref,
    );
  });

  @override
  Future<void> initialLoad() async {
    if (state.assetsModel != null) {
      final appraisalFileId = state.assetsModel?.appraisalFileId;
      showLoading();
      final assetsModel = state.assetsModel;
      var typeExportList = assetsModel?.assetCommons?.map((e) => 0).toList();
      if (assetsModel?.assetType == AssetsTypeEnum.bds ||
          assetsModel?.assetType == AssetsTypeEnum.duToan) {
        try {
          final detailResponse = await ref
              .read(
                assetsApiProvider,
              )
              .getAssetDetailFromFileId(
                appraisalFileId: state.assetsModel?.appraisalFileId ?? '',
              );

          final bdsDetail =
              await ref.read(assetsApiProvider).getAssetDetail<RealEstateModel>(
                    assetLevelTwoId: assetsModel?.assetType.assetsLevel2Id ??
                        AssetsTypeEnum.bds.assetsLevel2Id,
                    assetCodes: detailResponse.data?.assetCodes ?? [],
                  );

          typeExportList =
              (bdsDetail.data ?? []).map((e) => e.asset.exportType).toList();
        } catch (_) {}
      }

      final result = await ref.read(pdfApiProvider).getSurveyDetail(
            appraisalFileId: appraisalFileId ?? '',
            typeExport: typeExportList,
          );

      hideLoading();
      final data = result.data;
      if (data == null) {
        return;
      }
      if (!mounted) return;
      state = state.copyWith(
        data: AttachmentFile(
            size: data.length, bytes: data, name: '$appraisalFileId.pdf'),
      );
    }
  }
}
