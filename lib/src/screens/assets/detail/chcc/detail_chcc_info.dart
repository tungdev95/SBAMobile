import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/assets/controller/chcc/detail_chcc_page_controller.dart';

final chccInfoProvider = Provider.autoDispose<DetailCHCCData>((ref) {
  throw UnimplementedError();
});

class DetailCHCCInfoPage
    extends BaseDetailInfoPage<DetailCHCCState, DetailCHCCPageController> {
  const DetailCHCCInfoPage({super.key});

  @override
  String get title => S.current.thong_tin_can_ho;

  @override
  AutoDisposeStateNotifierProvider<DetailCHCCPageController, DetailCHCCState>
      provider(WidgetRef ref) {
    return DetailCHCCPageController.chccInfoProvider(
        ref.watch(chccInfoProvider));
  }
}
