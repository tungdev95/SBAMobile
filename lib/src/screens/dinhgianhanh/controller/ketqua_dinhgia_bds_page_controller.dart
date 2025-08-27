import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/models/assets/fast_valuation_model.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/screens/dinhgianhanh/dinhgianhanh_detail_bds_page.dart';
import 'package:sba/src/screens/dinhgianhanh/dinhgianhanh_map_page.dart';
import 'package:sba/src/screens/dinhgianhanh/dinhgianhanh_quyhoach_map_page.dart';
import 'package:sba/src/screens/dinhgianhanh/state/ketqua_dinhgia_state.dart';
import 'package:sba/src/services/api/fast_valuation_api.dart';
import 'package:sba/src/utils/utils.dart';

class KetQuaDinhGiaNhanhPageController
    extends BaseController<KetQuaDinhGiaNhanhState> {
  KetQuaDinhGiaNhanhPageController(super.state, super.ref);

  static final ketQuaDinhGiaPageController = StateNotifierProvider.autoDispose
      .family<KetQuaDinhGiaNhanhPageController, KetQuaDinhGiaNhanhState,
          FastValuationModel>(
    (ref, args) {
      return KetQuaDinhGiaNhanhPageController(
        KetQuaDinhGiaNhanhState(detail: args),
        ref,
      );
    },
  );

  @override
  Future<void> initialLoad() async {
    bool isNew = state.detail.isNew;

    if (isNew) {
      layDanhSachTSSS();
    }
  }

  void layDanhSachTSSS() async {
    // final result = await ref.read(fastApiProvider).dinhGiaTaiSan(body: body)
  }

  void editValuation(BuildContext context) {
    AppRoutes.pushReplacement(
      context,
      ProviderScope(
        overrides: [fastBDSItemProvider.overrideWithValue(state.detail)],
        child: const DinhGiaNhanhBDSPage(),
      ),
    );
  }

  void newFastValuation(BuildContext context) {
    AppRoutes.pushReplacement(
      context,
      ProviderScope(
        overrides: [
          fastBDSItemProvider.overrideWithValue(
              FastValuationModel(valuations: [], constructions: [], logs: []))
        ],
        child: const DinhGiaNhanhBDSPage(),
      ),
    );
  }

  void save(BuildContext context) async {
    showLoading();
    final result =
        await ref.read(fastApiProvider).dinhGiaTaiSan(body: state.detail);
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
