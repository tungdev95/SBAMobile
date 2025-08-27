import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/src/models/assets/ptdb_model.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/assets/controller/ptdb/ptdb_detail_page_controller.dart';

class PTDBDetailPage
    extends BaseAssetDetailPage<PTDBModel, PTDBPageController> {
  const PTDBDetailPage({super.key, super.allowComplete});

  @override
  AutoDisposeStateNotifierProvider<PTDBPageController,
      AssetsDetailState<PTDBModel>> provider(WidgetRef ref) {
    return PTDBPageController.detailPageControllerProvider(
      AssetDetailProviderElement(
        assetsModel: ref.watch(assetsDetailProvider),
      ),
    );
  }
}
