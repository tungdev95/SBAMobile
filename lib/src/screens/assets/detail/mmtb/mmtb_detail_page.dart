import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/src/models/assets/mmtb_model.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/assets/controller/mmtb/mmtb_detail_page_controller.dart';

class MMTBDetailPage
    extends BaseAssetDetailPage<MMTBModel, MMTBDetailPageController> {
  const MMTBDetailPage({super.key, super.allowComplete});

  @override
  AutoDisposeStateNotifierProvider<MMTBDetailPageController,
      AssetsDetailState<MMTBModel>> provider(WidgetRef ref) {
    return MMTBDetailPageController.detailPageControllerProvider(
      AssetDetailProviderElement(
        assetsModel: ref.watch(assetsDetailProvider),
      ),
    );
  }
}
