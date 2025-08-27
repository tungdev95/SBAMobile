import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/duan_model.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/assets/controller/duan/thuadat_duan_detail_page_controller.dart';
import 'package:sba/src/screens/assets/state/detail_thuadat_duan_state.dart';

final chiTietThuaDatData = Provider.autoDispose<AssetProjectInfo>((ref) {
  throw UnimplementedError();
});

class ChiTietThuaDatDuAnPage extends BaseDetailInfoPage<DetailThuaDatState,
    ThuaDatDuAnDetailPageController> {
  const ChiTietThuaDatDuAnPage({super.key});

  @override
  String get title => S.current.thong_tin_thua_dat;

  @override
  AutoDisposeStateNotifierProvider<ThuaDatDuAnDetailPageController,
      DetailThuaDatState> provider(WidgetRef ref) {
    return ThuaDatDuAnDetailPageController.detailLandInfoProvider(
      ref.watch(chiTietThuaDatData),
    );
  }
}
