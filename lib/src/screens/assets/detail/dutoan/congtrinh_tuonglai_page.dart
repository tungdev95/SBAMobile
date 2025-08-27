import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/assets/controller/dutoan/congtrinh_tuonglai_controller.dart';

final detailDuToanLandProvider = Provider.autoDispose<DetailData>((ref) {
  throw UnimplementedError();
});

class CongTrinhTuongLaiPage
    extends BaseDetailInfoPage<DetailLandState, CongTrinhTuongLaiController> {
  const CongTrinhTuongLaiPage({super.key});

  @override
  String get title => 'Công trình tương lai';

  @override
  AutoDisposeStateNotifierProvider<CongTrinhTuongLaiController, DetailLandState>
      provider(WidgetRef ref) {
    return CongTrinhTuongLaiController.detailLandInfoProvider(
        ref.watch(detailDuToanLandProvider));
  }
}
