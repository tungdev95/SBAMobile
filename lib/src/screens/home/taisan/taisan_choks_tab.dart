import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/screens/base/controller/base_paging_controller.dart';
import 'package:sba/src/screens/home/controller/taisan/taisan_cho_khaosat_list_controller.dart';
import 'package:sba/src/screens/home/widgets/assets_item_widget.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/widgets/paged_value_list_view.dart';
import 'package:shimmer/shimmer.dart';

//Tab tài sản chờ khảo sát
class TaiSanChoKSTab extends ConsumerWidget {
  const TaiSanChoKSTab({super.key, required this.provider});

  final AutoDisposeStateNotifierProvider<TaiSanChoKhaoSatListController,
      PagingValue<int?, AssetsModel>> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PagedValueListView(
      provider: provider,
      padding: const EdgeInsets.only(bottom: 24, top: 8),
      itemBuilder: (context, items, index, childRef) {
        final item = items[index];
        return ProviderScope(
          overrides: [assetsItemprovider.overrideWithValue(item)],
          child: AssetsItemWidget(
            onTap: () {
              return ref.read(provider.notifier).goToDetailPage(context, item);
            },
            reloadOnClose: () {
              ref.read(provider.notifier).doInitialLoad();
            },
          ),
        );
      },
      loadingBuilder: (context) {
        return Shimmer.fromColors(
          baseColor: AppColor.backgroundColor,
          highlightColor: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  5,
                  (index) => Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        // height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              margin: const EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 14,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    height: 14,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    height: 14,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, values, index, childRef) => const Divider(
        height: 0,
      ),
    );
  }
}
