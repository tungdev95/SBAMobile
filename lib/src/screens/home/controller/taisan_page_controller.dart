import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/screens/home/states/taisan_page_state.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

class TaiSanPageController extends BaseController<TaiSanPageState> {
  TaiSanPageController(
    super.state,
    super.ref,
  );

  static final taiSanPageProvider =
      StateNotifierProvider.autoDispose<TaiSanPageController, TaiSanPageState>(
    (ref) {
      final oldStatus = ref
          .read(sharedPreferencesProvider)
          .getInt(AppConstants.kLastSelectedStatus);

      final selectedStatus = $enumDecodeNullable(fileStatusEnumMap, oldStatus,
              unknownValue: FileStatus.chuaCoLichKhaoSat) ??
          FileStatus.chuaCoLichKhaoSat;

      final state = TaiSanPageState(
        lsMenuModel: [
          AssetMenuModel<SvgGenImage>(
              id: AssetsTypeEnum.bds,
              title: 'Bất động\nsản',
              imageName: ImageName.ic_bds,
              notiCount: 0,
              image: Assets.images.home.icBds),
          AssetMenuModel<SvgGenImage>(
            id: AssetsTypeEnum.chcc,
            title: 'Căn hộ\nchung cư',
            imageName: ImageName.ic_chcc,
            notiCount: 0,
            image: Assets.images.home.icChcc,
          ),
          AssetMenuModel<SvgGenImage>(
            id: AssetsTypeEnum.duAn,
            title: 'Dự án',
            imageName: ImageName.ic_mmtb,
            notiCount: 0,
            image: Assets.images.home.icDuan,
          ),
          AssetMenuModel<SvgGenImage>(
            id: AssetsTypeEnum.duToan,
            title: 'Dự toán',
            imageName: ImageName.ic_pt_db,
            notiCount: 0,
            image: Assets.images.home.icDutoan,
          ),
          AssetMenuModel<SvgGenImage>(
            id: AssetsTypeEnum.ptdb,
            title: 'PTVT \n đường bộ',
            imageName: ImageName.ic_pt_dt,
            notiCount: 0,
            image: Assets.images.home.icPtdb,
          ),
          AssetMenuModel<SvgGenImage>(
            id: AssetsTypeEnum.ptdt,
            title: 'PTVT \n đường thủy',
            imageName: ImageName.ic_pt_dt,
            notiCount: 0,
            image: Assets.images.home.icPtdt,
          ),
          AssetMenuModel<SvgGenImage>(
            id: AssetsTypeEnum.mmtb,
            title: 'Máy móc thiết bị',
            imageName: ImageName.ic_pt_dt,
            notiCount: 0,
            image: Assets.images.home.icMmtb,
          ),
          AssetMenuModel<SvgGenImage>(
            id: AssetsTypeEnum.tsk,
            title: 'Tài sản\nkhác',
            imageName: ImageName.ic_pt_dt,
            notiCount: 0,
            image: Assets.images.home.icTskhac,
          ),
        ],
        currentStatus: selectedStatus,
      );

      return TaiSanPageController(state, ref);
    },
  );

  ///Thêm tài sản mới
  void themTaiSanMoi(BuildContext cContext) async {
    // await showModalBottomSheet(
    //   context: context,
    //   backgroundColor: Colors.white,
    //   isScrollControlled: true,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(
    //       top: Radius.circular(16),
    //     ),
    //   ),
    //   builder: (context) {
    //     return ProviderScope(
    //       overrides: [
    //         DialogThemTaiSan.selectedMenuProvider.overrideWithValue(
    //           DialogThemTaiSanData(
    //             lsMenu: state.lsMenuModel,
    //             currentType: state.currentType,
    //           ),
    //         )
    //       ],
    //       child: const DialogThemTaiSan(),
    //     );
    //   },
    // );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeType(AssetsTypeEnum id) {
    if (state.currentType == id) {
      state = state.copyWith(currentType: null);
    } else {
      state = state.copyWith(currentType: id);
    }
  }

  void changeTypeDi(AssetsTypeEnum id) {
    if (state.currentTypeDi == id) {
      state = state.copyWith(currentTypeDi: null);
    } else {
      state = state.copyWith(currentTypeDi: id);
    }
  }

  void updateStatus(FileStatus? newItem) {
    if (newItem == null) return;
    ref
        .read(sharedPreferencesProvider)
        .setInt(AppConstants.kLastSelectedStatus, newItem.id);
    state = state.copyWith.call(currentStatus: newItem);
  }
}
