import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/assets/controller/bds/bds_detail_page_controller.dart';
import 'package:sba/src/screens/assets/detail/dutoan/detail_dutoan_info_page.dart';
import 'package:sba/src/utils/utils.dart';

class DuToanDetailPageController extends BDSDetailPageController {
  DuToanDetailPageController(super.state, super.ref);

  static final detailPageControllerProvider = StateNotifierProvider.autoDispose
      .family<DuToanDetailPageController, AssetsDetailState<RealEstateModel>,
          AssetDetailProviderElement>(
    (ref, element) {
      final controller = DuToanDetailPageController(
        AssetsDetailState.element(element),
        ref,
      );
      return controller;
    },
  );

  @override
  bool get enableUploadDinhVi => true;

  @override
  Future<void> goToEditLandPage(BuildContext context, WidgetRef ref,
      AssetLandInfo landInfo, AssetsDetailModel<RealEstateModel> asset) async {
    AssetLandInfo? result = await AppRoutes.push(
      context,
      ProviderScope(
        overrides: [
          detailDuToanLandProvider.overrideWithValue(DetailData(
            landInfo: asset.asset.assetLandInfors
                .firstWhere((element) => element.id == landInfo.id),
            detailModel: asset.asset,
          ))
        ],
        child: const DetailDuToanInfoPage(),
      ),
    );
    if (result != null) {
      final index = asset.asset.assetLandInfors
          .indexWhere((element) => element.id == landInfo.id);

      asset.asset.assetLandInfors[index] = landInfo
        ..assetLandUsingPurposes = result.assetLandUsingPurposes
        ..constructionChecklists = result.constructionChecklists
        ..assetTrees = result.assetTrees
        ..constructionFutureInfors = result.constructionFutureInfors
        ..constructions = result.constructions
        ..isConsolidation = result.isConsolidation
        ..isConsolidationPurpose = result.isConsolidationPurpose;

      state.assets?.forEach(
        (element) {
          for (var land in element.asset.assetLandInfors) {
            land.isConsolidation = result.isConsolidation;
          }
        },
      );

      if (result.isConsolidation) {
        state.assets?.forEach(
          (element) {
            element.asset.xuatThongTinTomTat = false;
          },
        );
      }

      var lsExpand = state.assetInfo[asset.assetCode] ?? [];
      final thuaDatItem =
          lsExpand.firstWhere((element) => element.key == thuaDatKey);
      thuaDatItem.topLsInputField =
          getThongTinThuaDatExpandModel(asset).topLsInputField;

      state = state.copyWith();
    }
  }

  @override
  List<KeyValueModel> get getListQuyHoach => lsQuyHoachBDS;

  @override
  InputFieldModel<String> getThongTinTranhChap(RealEstateModel item) {
    return InputFieldModel<String>(
      label: S.current.thong_tin_tranh_chap,
      data: item.disputeInfor,
      onTextChanged: (p0) => item.disputeInfor = p0,
    );
  }
}
