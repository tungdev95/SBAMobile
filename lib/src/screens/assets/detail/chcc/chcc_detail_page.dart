import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/models/assets/chcc_model.dart';
import 'package:sba/src/screens/assets/controller/chcc/chcc_detail_page_controller.dart';
import 'package:sba/src/screens/assets/detail/base_asset_detail_page.dart';
import 'package:sba/src/screens/assets/state/assets_detail_state.dart';

class CHCCDetailPage
    extends BaseAssetDetailPage<CHCCModel, CHCCDetailPageController> {
  const CHCCDetailPage({super.key, super.allowComplete});

  @override
  AutoDisposeStateNotifierProvider<CHCCDetailPageController,
      AssetsDetailState<CHCCModel>> provider(WidgetRef ref) {
    return CHCCDetailPageController.detailPageControllerProvider(
      AssetDetailProviderElement(
        assetsModel: ref.watch(assetsDetailProvider),
      ),
    );
  }
}
