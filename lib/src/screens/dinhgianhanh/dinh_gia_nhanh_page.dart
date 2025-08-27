import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/chcc_fast_valuation_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/screens/dinhgianhanh/controller/dinhgianhanh_chcc_list_item_controller.dart';
import 'package:sba/src/screens/home/controller/dinh_gia_nhanh_controller.dart';
import 'package:sba/src/screens/dinhgianhanh/controller/dinhgianhanh_list_item_controller.dart';
import 'package:sba/src/screens/home/states/dinh_gia_nhanh_state.dart';
import 'package:sba/src/screens/home/widgets/fast_value_item_widget.dart';
import 'package:sba/src/screens/home/widgets/menu_item_widget.dart';
import 'package:sba/src/utils/base_flutter_extensions.dart';
import 'package:sba/src/widgets/base/color_schemes.dart';
import 'package:sba/src/widgets/paged_value_list_view.dart';

class DinhGiaNhanhPage
    extends BasePage<DinhGiaNhanhController, DinhGiaNhanhState> {
  const DinhGiaNhanhPage({super.key});

  @override
  String get title => S.current.dinh_gia_nhanh;

  @override
  bool enableBack() => false;

  @override
  AutoDisposeStateNotifierProvider<DinhGiaNhanhController, DinhGiaNhanhState>
      provider(WidgetRef ref) => DinhGiaNhanhController.dinhGiaNhanhProvider;

  @override
  Widget bodyWidget(
      BuildContext context, WidgetRef ref, DinhGiaNhanhState state) {
    return Container(
      decoration: const BoxDecoration(
        gradient: defaultBGGradient,
      ),
      child: DefaultTabController(
        length: 1,
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 81 / 119,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  var item = state.lsMenuModel[index];
                  final isSelected = state.currentType == item.id;
                  return MemuItemWidget(
                    item: item,
                    isSelected: isSelected,
                    icon:
                        item.image?.svg(height: 50) ?? const SizedBox.shrink(),
                    onTap: () {
                      ref.read(provider(ref).notifier).changeType(item.id);
                    },
                  );
                },
                itemCount: state.lsMenuModel.length,
              ),
            ),
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: const SliverAppBar(
                pinned: true,
                elevation: 12.0,
                titleSpacing: 0.0,
                toolbarHeight: 1,
                expandedHeight: 1,
                scrolledUnderElevation: 0,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                bottom: TabBar(
                  isScrollable: false,
                  tabs: [
                    Tab(text: 'Lịch sử định giá nhanh'),
                  ],
                ),
              ),
            ),
          ],
          body: Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: kToolbarHeight - 10),
            child: TabBarView(
              children: [
                if (state.currentType == AssetsTypeEnum.dinhGiaNhanhBDS)
                  danhSachTaiSanBDS(context, ref, state)
                else if (state.currentType == AssetsTypeEnum.dinhGiaNhanhCHCC)
                  danhSachTaiSanCHCC(context, ref, state)
                else
                  danhSachTaiSanBDS(context, ref, state)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget danhSachTaiSanBDS(
      BuildContext context, WidgetRef ref, DinhGiaNhanhState state) {
    return PagedValueListView(
      provider: DinhGiaNhanhListController.dinhGiaNhanhListProvider,
      padding: const EdgeInsets.only(bottom: 24, top: 8),
      itemBuilder: (context, items, index, childRef) {
        final item = items[index];
        return Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: .2,
            children: [
              SlidableAction(
                icon: Icons.delete,
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                onPressed: (BuildContext context) async {
                  childRef
                      .read(DinhGiaNhanhListController
                          .dinhGiaNhanhListProvider.notifier)
                      .deleteAsset(item, index);
                },
              )
            ],
          ),
          child: ProviderScope(
            overrides: [fastValueItemProvider.overrideWithValue(item)],
            child: FastValueItemWidget(
              onTap: () async {
                await ref
                    .read(provider(ref).notifier)
                    .chiTietBDS(context, item);
                childRef
                    .read(DinhGiaNhanhListController
                        .dinhGiaNhanhListProvider.notifier)
                    .doInitialLoad();
              },
            ),
          ),
        );
      },
      separatorBuilder: (context, values, index, ref) => const Divider(
        height: 0,
      ),
    );
  }

  Widget danhSachTaiSanCHCC(
      BuildContext context, WidgetRef ref, DinhGiaNhanhState state) {
    return PagedValueListView(
      provider: DinhGiaNhanhCHCCListController.dinhGiaNhanhListProvider,
      padding: const EdgeInsets.only(bottom: 24, top: 8),
      itemBuilder: (context, items, index, childRef) {
        final item = items[index];
        return Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: .2,
            children: [
              SlidableAction(
                icon: Icons.delete,
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                onPressed: (BuildContext context) async {
                  childRef
                      .read(DinhGiaNhanhCHCCListController
                          .dinhGiaNhanhListProvider.notifier)
                      .deleteAsset(item, index);
                },
              )
            ],
          ),
          child: ProviderScope(
            overrides: [fastValueItemProvider.overrideWithValue(item)],
            child: FastValueItemWidget<CHCCFastValModel>(
              onTap: () async {
                await ref
                    .read(provider(ref).notifier)
                    .chiTietCHCC(context, item);
                childRef
                    .read(DinhGiaNhanhCHCCListController
                        .dinhGiaNhanhListProvider.notifier)
                    .doInitialLoad();
              },
            ),
          ),
        );
      },
      separatorBuilder: (context, values, index, ref) => const Divider(
        height: 0,
      ),
    );
  }

  @override
  Widget? getFloatingButton(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      mini: true,
      shape: const CircleBorder(),
      backgroundColor: context.colorScheme.primary,
      onPressed: () {
        ref.read(provider(ref).notifier).themTaiSanMoi(context);
      },
      heroTag: null,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
