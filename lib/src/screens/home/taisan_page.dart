import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/screens/home/controller/taisan/taisan_cho_khaosat_list_controller.dart';
import 'package:sba/src/screens/home/controller/taisan_page_controller.dart';
import 'package:sba/src/screens/home/states/taisan_page_state.dart';
import 'package:sba/src/screens/home/taisan/taisan_choks_tab.dart';
import 'package:sba/src/screens/home/widgets/menu_item_widget.dart';
import 'package:sba/src/widgets/base/color_schemes.dart';

//Tab tài sản
class TaiSanPage extends BasePage<TaiSanPageController, TaiSanPageState> {
  const TaiSanPage({super.key});

  @override
  String get title => S.current.tai_san;

  @override
  bool enableBack() => false;

  @override
  AutoDisposeStateNotifierProvider<TaiSanPageController, TaiSanPageState>
      provider(WidgetRef ref) => TaiSanPageController.taiSanPageProvider;

  @override
  Widget bodyWidget(
      BuildContext context, WidgetRef ref, TaiSanPageState state) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(tabs: [
            Tab(text: 'Hồ sơ đến'),
            Tab(text: 'Hồ sơ đi'),
          ]),
          Expanded(
            child: TabBarView(
              children: [
                _hoSoDen(ref, state),
                _hoSoDi(ref, state),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hoSoDen(WidgetRef ref, TaiSanPageState state) {
    final lsTrangThai = [
      FileStatus.taoHoSoThuCong,
      FileStatus.daBoSungHSPL,
      FileStatus.chuaCoLichKhaoSat,
      FileStatus.choBaoLaiLichKS,
      FileStatus.daCoLichKhaoSat,
      FileStatus.hoanThanhBBKS,
      FileStatus.daTuChoiDuyetVaChoDieuChinh,
      FileStatus.choDuyet,
      FileStatus.dangDuyet,
      FileStatus.daDuyet,
      FileStatus.daKySo,
      FileStatus.daGuiThongBao,
      FileStatus.daGuiKQThamDinh,
    ];
    return Container(
      decoration: const BoxDecoration(
        gradient: defaultBGGradient,
      ),
      child: DefaultTabController(
        length: lsTrangThai.length,
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
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
              sliver: SliverAppBar(
                pinned: true,
                elevation: 12.0,
                titleSpacing: 0.0,
                toolbarHeight: 1,
                expandedHeight: 1,
                scrolledUnderElevation: 0,
                shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                bottom: TabBar(
                  isScrollable: true,
                  tabs: lsTrangThai.map((e) => Tab(text: e.title)).toList(),
                ),
              ),
            ),
          ],
          body: Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: kToolbarHeight - 10),
            child: TabBarView(
              children: lsTrangThai
                  .map(
                    (e) => TaiSanChoKSTab(
                      provider:
                          TaiSanChoKhaoSatListController.listTaiSanProvider(e),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _hoSoDi(WidgetRef ref, TaiSanPageState state) {
    final lsTrangThai = [
      FileStatus.choDuyet,
      FileStatus.dangDuyet,
      FileStatus.daDuyet,
    ];
    return Container(
      decoration: const BoxDecoration(
        gradient: defaultBGGradient,
      ),
      child: DefaultTabController(
        length: lsTrangThai.length,
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 81 / 119,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  var item = state.lsMenuModel[index];
                  final isSelected = state.currentTypeDi == item.id;
                  return MemuItemWidget(
                    item: item,
                    isSelected: isSelected,
                    icon:
                        item.image?.svg(height: 50) ?? const SizedBox.shrink(),
                    onTap: () {
                      ref.read(provider(ref).notifier).changeTypeDi(item.id);
                    },
                  );
                },
                itemCount: state.lsMenuModel.length,
              ),
            ),
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                pinned: true,
                elevation: 12.0,
                titleSpacing: 0.0,
                toolbarHeight: 1,
                expandedHeight: 1,
                scrolledUnderElevation: 0,
                shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                bottom: TabBar(
                  isScrollable: true,
                  tabs: lsTrangThai.map((e) => Tab(text: e.title)).toList(),
                ),
              ),
            ),
          ],
          body: Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: kToolbarHeight - 10),
            child: TabBarView(
              children: lsTrangThai
                  .map(
                    (e) => TaiSanChoKSTab(
                      provider:
                          TaiSanChoKhaoSatListController.listTaiSanDiProvider(
                              e),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
