// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/detail/base_asset_detail_page.dart';
import 'package:sba/src/screens/assets/detail/chcc/chcc_detail_page.dart';
import 'package:sba/src/screens/assets/detail/duan/duan_detail_page.dart';
import 'package:sba/src/screens/assets/detail/dutoan/dutoan_detail_page.dart';
import 'package:sba/src/screens/assets/detail/mmtb/mmtb_detail_page.dart';
import 'package:sba/src/screens/assets/detail/ptdb/ptdb_detail_page.dart';
import 'package:sba/src/screens/assets/detail/ptdt/ptdt_detail_page.dart';
import 'package:sba/src/screens/assets/detail/real_estate/real_estate_detail_page.dart';
import 'package:sba/src/screens/base/controller/base_paging_controller.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/screens/home/controller/taisan_page_controller.dart';
import 'package:sba/src/screens/other/pdf_viewer_page.dart';
import 'package:sba/src/screens/sign/state/digital_sign_data_state.dart';
import 'package:sba/src/screens/trinhky/submission_page.dart';
import 'package:sba/src/screens/sign/digital_sign_page.dart';
import 'package:sba/src/services/api/assets_api.dart';
import 'package:sba/src/utils/utils.dart';
part 'taisan_cho_khaosat_list_controller.g.dart';

@riverpod
Future<ApiResponse<List<AssetsModel>?>> _getListAssets(
  _GetListAssetsRef ref, {
  int? pageIndex,
  required AssetsTypeEnum? assetsType,
  FileStatus? fileStatus,
}) async {
  final result = await ref.read(assetsApiProvider).getListAssets(
        page: pageIndex ?? 1,
        assetLevelTwoId: assetsType?.assetsLevel2Id,
        assetLevelOneId: assetsType?.assetsLevel1Id,
        fileStatus: fileStatus,
      );

  return result;
}

@riverpod
Future<ApiResponse<List<AssetsModel>?>> _getListAssetsSend(
  _GetListAssetsSendRef ref, {
  int? pageIndex,
  required AssetsTypeEnum? assetsType,
  FileStatus? fileStatus,
}) async {
  final result = await ref.read(assetsApiProvider).getListAssetsSend(
        page: pageIndex ?? 1,
        assetLevelTwoId: assetsType?.assetsLevel2Id,
        assetLevelOneId: assetsType?.assetsLevel1Id,
        fileStatus: fileStatus,
      );

  return result;
}

class TaiSanChoKhaoSatListController
    extends PagingValueNotifier<int?, AssetsModel> {
  static final listTaiSanProvider = StateNotifierProvider.autoDispose.family<
      TaiSanChoKhaoSatListController,
      PagingValue<int?, AssetsModel>,
      FileStatus>((ref, status) {
    KeepAliveLink? link;
    final currentType =
        ref.watch(TaiSanPageController.taiSanPageProvider).currentType;
    final controller = TaiSanChoKhaoSatListController(
      const PagingValue.loading(),
      ref,
      currentType,
      status,
    );
    link = ref.keepAlive();
    ref.listen(appController, (previous, next) {
      if (previous?.userLogin != next.userLogin) {
        link?.close();
      }
    });
    controller.doInitialLoad();
    return controller;
  });

  static final listTaiSanDiProvider = StateNotifierProvider.autoDispose.family<
      TaiSanChoKhaoSatListController,
      PagingValue<int?, AssetsModel>,
      FileStatus>((ref, status) {
    KeepAliveLink? link;
    final currentType =
        ref.watch(TaiSanPageController.taiSanPageProvider).currentType;
    final controller = TaiSanChoKhaoSatListController(
      const PagingValue.loading(),
      ref,
      currentType,
      status,
      isSend: true,
    );
    link = ref.keepAlive();
    ref.listen(appController, (previous, next) {
      if (previous?.userLogin != next.userLogin) {
        link?.close();
      }
    });
    controller.doInitialLoad();
    return controller;
  });

  static final tatCaTaiSanChoKSProvider = StateNotifierProvider.autoDispose<
      TaiSanChoKhaoSatListController, PagingValue<int?, AssetsModel>>(
    (ref) {
      final controller = TaiSanChoKhaoSatListController(
        const PagingValue.loading(),
        ref,
        null,
        FileStatus.dangKhaoSat,
      );
      controller.doInitialLoad();
      return controller;
    },
    name: 'Tất cả TS đang khảo sát',
  );

  final AssetsTypeEnum? currentType;
  final FileStatus? fileStatus;
  final bool isSend;

  TaiSanChoKhaoSatListController(
    super.state,
    super.ref,
    this.currentType,
    this.fileStatus, {
    this.isSend = false,
  });

  @override
  Future<void> doInitialLoad() async {
    final result = isSend
        ? await ref.read(_getListAssetsSendProvider(
            assetsType: currentType,
            fileStatus: fileStatus,
          ).future)
        : await ref.read(_getListAssetsProvider(
            assetsType: currentType,
            fileStatus: fileStatus,
          ).future);
    bool isOK = await handleResponse(result, (p0) {
      final data = p0 ?? [];
      state = PagingValue(items: data, nextPageKey: data.isNotEmpty ? 2 : null);
    }, error: (e) {
      state = const PagingValue.error();
    });
  }

  @override
  Future<void> loadMore(int? nextPageKey) async {
    if (nextPageKey == null) return;
    final result = isSend
        ? await ref.read(_getListAssetsSendProvider(
            pageIndex: nextPageKey,
            assetsType: currentType,
            fileStatus: fileStatus,
          ).future)
        : await ref.read(_getListAssetsProvider(
            pageIndex: nextPageKey,
            assetsType: currentType,
            fileStatus: fileStatus,
          ).future);
    bool isOK = await handleResponse(result, (p0) {
      final data = p0 ?? [];

      appendLastPage(
        p0 ?? [],
        data.isNotEmpty ? nextPageKey + 1 : null,
      );
    }, error: (e) {
      appendLastPage([], null);
    });
  }

  void goToDetailPage(BuildContext context, AssetsModel item) async {
    final fileStatus = item.fileStatus;
    if (isSend) {
      if (fileStatus == FileStatus.choDuyet ||
          fileStatus == FileStatus.dangDuyet) {
        duyetHoSo(context, item);
      } else {
        chiTietHoSoKySo(context, item);
      }
    } else {
      if ((fileStatus?.id ?? 100) <= FileStatus.dangKhaoSat.id) {
        chiTietDangKhaoSat(context, item);
      } else if (fileStatus == FileStatus.hoanThanhBBKS) {
        chiTietHoanThanh(context, item);
      } else if (fileStatus == FileStatus.choDuyet ||
          fileStatus == FileStatus.dangDuyet ||
          fileStatus == FileStatus.daTuChoiDuyetVaChoDieuChinh) {
        duyetHoSo(context, item);
      } else if (fileStatus == FileStatus.daDuyet) {
        chiTietHoSoKySo(context, item);
      } else if (fileStatus == FileStatus.daKySo ||
          fileStatus == FileStatus.daGuiThongBao ||
          fileStatus == FileStatus.daGuiKQThamDinh) {
        chiTietHoSoKySo(context, item);
      }
    }
  }

  void chiTietDangKhaoSat(BuildContext context, AssetsModel item) async {
    Widget? detailWidget;
    if (item.assetType == AssetsTypeEnum.bds) {
      detailWidget = const RealEstateDetailPage();
    } else if (item.assetType == AssetsTypeEnum.chcc) {
      detailWidget = const CHCCDetailPage();
    } else if (item.assetType == AssetsTypeEnum.duToan) {
      detailWidget = const DuToanDetailPage();
    } else if (item.assetType == AssetsTypeEnum.ptdb) {
      detailWidget = const PTDBDetailPage();
    } else if (item.assetType == AssetsTypeEnum.mmtb) {
      detailWidget = const MMTBDetailPage();
    } else if (item.assetType == AssetsTypeEnum.ptdt) {
      detailWidget = const PTDTDetailPage();
    } else if (item.assetType == AssetsTypeEnum.duAn) {
      detailWidget = const DuAnDetailPage();
    } else {
      showMessageDialog(S.current.loai_tai_san_chua_ho_tro);
    }

    if (detailWidget == null) return;

    await AppRoutes.push(
      context,
      ProviderScope(
        overrides: [assetsDetailProvider.overrideWithValue(item)],
        child: detailWidget,
      ),
    );

    doInitialLoad();
  }

  void duyetHoSo(BuildContext context, AssetsModel item) async {
    await AppRoutes.push(
      context,
      ProviderScope(
        overrides: [
          subMissionDetail.overrideWithValue(item),
        ],
        child: SubmissionPage(
            isSend: isSend ||
                item.fileStatus == FileStatus.daTuChoiDuyetVaChoDieuChinh),
      ),
    );
    doInitialLoad();
  }

  void chiTietHoSoKySo(BuildContext context, AssetsModel item) async {
    await AppRoutes.push(
      context,
      ProviderScope(
        overrides: [
          digitalSignDataProvider.overrideWithValue(
            DigitalSignDataState(
              appraisalFilesId: item.appraisalFileId ?? '',
              fileStatus: item.fileStatus,
            ),
          )
        ],
        child: const DigitalSignPage(),
      ),
    );
    doInitialLoad();
  }

  void chiTietHoanThanh(BuildContext context, AssetsModel item) {
    AppRoutes.push(
      context,
      ProviderScope(
        overrides: [
          pdfViewProvider.overrideWithValue((assetsModel: item, file: null)),
        ],
        child: const PdfViewerPage(),
      ),
    );
  }
}
