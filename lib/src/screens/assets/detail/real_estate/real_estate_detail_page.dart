import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/models/assets/real_estate_model.dart';
import 'package:sba/src/screens/assets/controller/bds/bds_detail_page_controller.dart';
import 'package:sba/src/screens/assets/detail/base_asset_detail_page.dart';
import 'package:sba/src/screens/assets/state/assets_detail_state.dart';

class RealEstateDetailPage
    extends BaseAssetDetailPage<RealEstateModel, BDSDetailPageController> {
  const RealEstateDetailPage({super.key, super.allowComplete});

  @override
  AutoDisposeStateNotifierProvider<BDSDetailPageController,
      AssetsDetailState<RealEstateModel>> provider(WidgetRef ref) {
    return BDSDetailPageController.detailPageControllerProvider(
      AssetDetailProviderElement(
        assetsModel: ref.watch(assetsDetailProvider),
      ),
    );
  }
}
