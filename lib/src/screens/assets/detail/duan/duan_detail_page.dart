import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/models/assets/duan_model.dart';
import 'package:sba/src/screens/assets/controller/duan/duan_detail_page_controller.dart';
import 'package:sba/src/screens/assets/detail/base_asset_detail_page.dart';
import 'package:sba/src/screens/assets/state/assets_detail_state.dart';

class DuAnDetailPage
    extends BaseAssetDetailPage<DuAnModel, DuAnDetailPageController> {
  const DuAnDetailPage({super.key, super.allowComplete});

  @override
  AutoDisposeStateNotifierProvider<DuAnDetailPageController,
      AssetsDetailState<DuAnModel>> provider(WidgetRef ref) {
    return DuAnDetailPageController.detailPageControllerProvider(
      AssetDetailProviderElement(
        assetsModel: ref.watch(assetsDetailProvider),
      ),
    );
  }
}
