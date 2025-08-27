import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/models/assets/chcc_fast_valuation_model.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/screens/dinhgianhanh/dinhgianhanh_detail_chcc_page.dart';
import 'package:sba/src/screens/dinhgianhanh/dinhgianhanh_map_page.dart';
import 'package:sba/src/screens/dinhgianhanh/dinhgianhanh_quyhoach_map_page.dart';
import 'package:sba/src/screens/dinhgianhanh/state/ketqua_dinhgia_chcc_state.dart';
import 'package:sba/src/services/api/fast_valuation_api.dart';
import 'package:sba/src/utils/utils.dart';

class KetQuaDinhGiaNhanhCHCCPageController
    extends BaseController<KetQuaDinhGiaNhanhCHCCState> {
  KetQuaDinhGiaNhanhCHCCPageController(super.state, super.ref);

  static final ketQuaDinhGiaPageController = StateNotifierProvider.autoDispose
      .family<KetQuaDinhGiaNhanhCHCCPageController, KetQuaDinhGiaNhanhCHCCState,
          CHCCFastValModel>(
    (ref, args) {
      return KetQuaDinhGiaNhanhCHCCPageController(
        KetQuaDinhGiaNhanhCHCCState(detail: args),
        ref,
      );
    },
  );

  @override
  Future<void> initialLoad() async {
    bool isNew = state.detail.isNew;
    if (state.detail.getDetail == true) {
      getAssetDetail();
    }

    if (isNew) {
      layDanhSachTSSS();
    }
  }

  void getAssetDetail() async {
    showLoading();
    final result = await ref
        .read(fastApiProvider)
        .getDetailDinhGiaNhanhCHCC(iD: state.detail.assetId ?? '');
    result.data?.assetId = null;
    result.data?.roadInPriceRange = null;
    hideLoading();
    state = state.copyWith(detail: result.data);
  }

  void layDanhSachTSSS() async {
    // final result = await ref.read(fastApiProvider).dinhGiaTaiSan(body: body)
  }

  void editValuation(BuildContext context) {
    AppRoutes.pushReplacement(
      context,
      ProviderScope(
        overrides: [fastCHCCItemProvider.overrideWithValue(state.detail)],
        child: const DinhGiaNhanhCHCCPage(),
      ),
    );
  }

  void newFastValuation(BuildContext context) {
    AppRoutes.pushReplacement(
      context,
      ProviderScope(
        overrides: [
          fastCHCCItemProvider.overrideWithValue(
            CHCCFastValModel(
              valuations: [],
              constructions: [],
              logs: [],
            ),
          )
        ],
        child: const DinhGiaNhanhCHCCPage(),
      ),
    );
  }

  void save(BuildContext context) async {
    showLoading();
    final result =
        await ref.read(fastApiProvider).dinhGiaTaiSanCHCC(body: state.detail);
    hideLoading();
    handleResponse(result, (p0) {
      Navigator.maybePop(context);
    });
  }

  void xemBanDo(BuildContext context, WidgetRef ref) async {
    AppRoutes.push(
      context,
      ProviderScope(
        overrides: [
          detailDinhGiaItem.overrideWithValue(state.detail),
        ],
        child: DinhGiaNhanhMapPage(),
      ),
    );
  }

  void xemQuyHoach(BuildContext context, WidgetRef ref) async {
    AppRoutes.push(
      context,
      DinhGiaNhanhQuyHoachMapPage(
        lat: state.detail.latitude.toString(),
        lng: state.detail.longitude.toString(),
      ),
    );
  }
}
