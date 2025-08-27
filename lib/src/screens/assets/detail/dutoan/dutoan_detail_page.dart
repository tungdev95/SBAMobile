import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/models/assets/real_estate_model.dart';
import 'package:sba/src/screens/assets/controller/dutoan/dutoan_detail_page_controller.dart';
import 'package:sba/src/screens/assets/detail/base_asset_detail_page.dart';
import 'package:sba/src/screens/assets/state/assets_detail_state.dart';

class DuToanDetailPage
    extends BaseAssetDetailPage<RealEstateModel, DuToanDetailPageController> {
  const DuToanDetailPage({super.key, super.allowComplete});

  @override
  AutoDisposeStateNotifierProvider<DuToanDetailPageController,
      AssetsDetailState<RealEstateModel>> provider(WidgetRef ref) {
    return DuToanDetailPageController.detailPageControllerProvider(
      AssetDetailProviderElement(
        assetsModel: ref.watch(assetsDetailProvider),
      ),
    );
  }
}
