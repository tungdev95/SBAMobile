import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/src/models/assets/chcc_fast_valuation_model.dart';
import 'package:sba/src/models/assets/fast_valuation_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/screens/dinhgianhanh/dinhgianhanh_detail_bds_page.dart';
import 'package:sba/src/screens/dinhgianhanh/dinhgianhanh_detail_chcc_page.dart';
import 'package:sba/src/screens/dinhgianhanh/ketqua_dinhgia_bds_page.dart';
import 'package:sba/src/screens/dinhgianhanh/ketqua_dinhgia_chcc_page.dart';
import 'package:sba/src/screens/home/states/dinh_gia_nhanh_state.dart';
import 'package:sba/src/utils/utils.dart';

class DinhGiaNhanhController extends BaseController<DinhGiaNhanhState> {
  DinhGiaNhanhController(super.state, super.ref);

  static final dinhGiaNhanhProvider = StateNotifierProvider.autoDispose<
      DinhGiaNhanhController, DinhGiaNhanhState>(
    (ref) {
      final state = DinhGiaNhanhState(lsMenuModel: [
        AssetMenuModel<SvgGenImage>(
            id: AssetsTypeEnum.dinhGiaNhanhBDS,
            title: 'Bất động\nsản',
            imageName: ImageName.ic_bds,
            notiCount: 0,
            image: Assets.images.home.icBds),
        AssetMenuModel<SvgGenImage>(
          id: AssetsTypeEnum.dinhGiaNhanhCHCC,
          title: 'Căn hộ\nchung cư',
          imageName: ImageName.ic_chcc,
          notiCount: 0,
          image: Assets.images.home.icChcc,
        ),
        AssetMenuModel<SvgGenImage>(
          id: AssetsTypeEnum.dinhGiaNhanhPTVT,
          title: 'PTVT \n đường bộ',
          imageName: ImageName.ic_pt_dt,
          notiCount: 0,
          image: Assets.images.home.icPtdb,
        ),
      ]);
      return DinhGiaNhanhController(state, ref);
    },
  );

  void changeType(AssetsTypeEnum id) {
    state = state.copyWith(
      currentType: id,
    );
  }

  Future<void> chiTietBDS(BuildContext context, FastValuationModel item) async {
    return AppRoutes.push(
      context,
      ProviderScope(
        overrides: [ketQuaDinhGiaNhanhItem.overrideWithValue(item)],
        child: const KetQuaDinhGiaNhanhPage(),
      ),
    );
  }

  Future<void> chiTietCHCC(BuildContext context, CHCCFastValModel item) async {
    item.getDetail = true;
    AppRoutes.push(
      context,
      ProviderScope(
        overrides: [
          ketQuaDinhGiaNhanhCHCCItem.overrideWithValue(item),
        ],
        child: const KetQuaDinhGiaNhanhCHCCPage(),
      ),
    );
  }

  void themTaiSanMoi(BuildContext context) {
    final type = state.currentType;
    if (type == AssetsTypeEnum.dinhGiaNhanhBDS) {
      AppRoutes.push(
        context,
        ProviderScope(
          overrides: [
            fastBDSItemProvider.overrideWithValue(
              FastValuationModel(
                valuations: [],
                constructions: [],
                logs: [],
              ),
            ),
          ],
          child: const DinhGiaNhanhBDSPage(),
        ),
      );
    } else if (type == AssetsTypeEnum.dinhGiaNhanhCHCC) {
      AppRoutes.push(
        context,
        ProviderScope(
          overrides: [
            fastCHCCItemProvider.overrideWithValue(
              CHCCFastValModel(
                valuations: [],
                constructions: [],
                logs: [],
              ),
            ),
          ],
          child: const DinhGiaNhanhCHCCPage(),
        ),
      );
    }
  }
}
