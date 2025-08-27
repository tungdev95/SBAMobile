import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/src/models/assets/ptdt_model.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/assets/controller/ptdt/ptdt_detail_page_controller.dart';

class PTDTDetailPage
    extends BaseAssetDetailPage<PTDTModel, PTDTPageController> {
  const PTDTDetailPage({super.key, super.allowComplete});

  @override
  AutoDisposeStateNotifierProvider<PTDTPageController,
      AssetsDetailState<PTDTModel>> provider(WidgetRef ref) {
    return PTDTPageController.detailPageControllerProvider(
      AssetDetailProviderElement(
        assetsModel: ref.watch(assetsDetailProvider),
      ),
    );
  }
}
