import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/screens/home/controller/home_controller.dart';
import 'package:sba/src/screens/home/controller/taisan/taisan_cho_khaosat_list_controller.dart';
import 'package:sba/src/screens/home/states/home_state.dart';
import 'package:sba/src/screens/home/widgets/menu_item_widget.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/widgets/widget_network_image.dart';
import 'package:riverpod/src/state_notifier_provider.dart';

import 'taisan/taisan_choks_tab.dart';

class HomePage extends BasePage<HomePageController, HomeState> {
  const HomePage({super.key});

  @override
  Color backgroundColor(BuildContext context) => Colors.transparent;

  @override
  Widget bodyWidget(BuildContext context, WidgetRef ref, HomeState state) {
    final app = ref.watch(appController);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ///User Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                RoundedImage(
                  url: ref.read(appController).userLogin?.userAvatar,
                  width: 44,
                  height: 44,
                  radius: 22,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        app.userLogin?.fullName ?? '',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        app.userLogin?.subTitle ?? '',
                        style: context.textTheme.titleSmall?.copyWith(
                          color: Colors.white.withOpacity(.7),
                          // fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ref.read(appController.notifier).logOut();
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),

          ///Menu
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 81 / 119,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = state.listMenuData[index];
              // final isSelected = state.listMenuData
              return MemuItemWidget(
                item: item,
                icon: item.image?.image(height: 75) ?? const SizedBox.shrink(),
                onTap: () {
                  ref.read(provider(ref).notifier).onMenuClicked(item.id);
                },
              );
            },
            itemCount: state.listMenuData.length,
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: DefaultTabController(
                length: 1,
                child: Column(
                  children: [
                    TabBar.secondary(
                      labelColor: Theme.of(context).primaryColor,
                      tabs: [
                        Tab(text: S.current.dang_khao_sat),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          TaiSanChoKSTab(
                            provider: TaiSanChoKhaoSatListController
                                .tatCaTaiSanChoKSProvider,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  AutoDisposeStateNotifierProvider<HomePageController, HomeState> provider(
          WidgetRef ref) =>
      HomePageController.assetWaitingCompleteProvider;
}
