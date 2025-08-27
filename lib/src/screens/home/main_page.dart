import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/base/home_menu_model.dart';
import 'package:sba/src/models/home_model.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/screens/home/controller/main_controller.dart';
import 'package:sba/src/screens/dinhgianhanh/dinh_gia_nhanh_page.dart';
import 'package:sba/src/screens/home/home_page.dart';
import 'package:sba/src/screens/home/setting_page.dart';
import 'package:sba/src/screens/home/taisan_page.dart';
import 'package:sba/src/utils/base_flutter_extensions.dart';
import 'package:sba/src/widgets/base/color_schemes.dart';
import '../../../src/utils/styles.dart';

final homePageDataProvider =
    StateNotifierProvider.autoDispose<MainController, HomeData>((ref) {
  final tabListData = [
    HomeMenuModel(name: S.current.tai_san, image: Assets.images.icMenuTaisan),
    HomeMenuModel(
        name: S.current.dinh_gia_nhanh, image: Assets.images.icMenuDinhgia),
    HomeMenuModel(
        name: S.current.dinh_gia_nhanh, image: Assets.images.icMenuDinhgia),
    HomeMenuModel(name: S.current.ban_do, image: Assets.images.icMenuBando),
    HomeMenuModel(name: S.current.cai_dat, image: Assets.images.icMenuCaidat),
  ];
  return MainController(
    HomeData(tabListData: tabListData),
    ref,
  );
});

final tabIndexProvider = StateProvider.autoDispose(((ref) => 2));

// ignore: must_be_immutable
class MainPage extends BasePage<MainController, HomeData> {
  const MainPage({Key? key}) : super(key: key);

  @override
  bool enableBack() => false;

  @override
  Color backgroundColor(BuildContext context) => Colors.transparent;

  @override
  Widget bodyWidget(
    BuildContext context,
    WidgetRef ref,
    HomeData state,
  ) {
    return Container(
      decoration: const BoxDecoration(
        gradient: defaultBGGradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (page) {},
              controller: ref.read(provider(ref).notifier).pageController,
              children: [
                const TaiSanPage(),
                const DinhGiaNhanhPage(),
                const HomePage(),
                emptyBody(context, S.current.ban_do),
                const SettingPage(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget emptyBody(BuildContext context, String title) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: context.textTitleBold.copyWith(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: defaultBGGradient,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: defaultBGGradient,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.images.icNodata.svg(),
              const SizedBox(
                height: 8,
              ),
              Text(
                S.current.khong_co_du_lieu,
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  AutoDisposeStateNotifierProvider<MainController, HomeData> provider(ref) =>
      homePageDataProvider;

  @override
  Widget? bottomNavigationBar(
    BuildContext context,
    WidgetRef ref,
  ) {
    final lsMenu = ref.read(provider(ref)).tabListData;
    final bottomPadding = context.padding.bottom;
    return Consumer(
      builder: (context, ref, child) {
        final tabIndex = ref.watch(tabIndexProvider);
        var activeIndex = tabIndex;

        return BottomNavigationBar(
          currentIndex: tabIndex,
          backgroundColor: const Color(0xFF1D5AD4),
          selectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: AppColor.colorBlackTypoSub,
          unselectedLabelStyle:
              const TextStyle(color: AppColor.colorBlackTypoSub),
          showUnselectedLabels: true,
          onTap: (index) {
            _onItemTapped(index, ref);
          },
          items: lsMenu
              .mapIndexed(
                (index, e) => BottomNavigationBarItem(
                  icon: index == 2
                      ? const SizedBox.shrink()
                      : e.image.svg(
                          colorFilter: ColorFilter.mode(
                            index == activeIndex
                                ? const Color(0xFFFFFFFF)
                                : AppColor.colorBlackTypoSub,
                            BlendMode.srcIn,
                          ),
                        ),
                  label: index == 2 ? '' : e.name,
                  backgroundColor: const Color(0xFF1D5AD4),
                ),
              )
              .toList(),
        );
      },
    );
  }

  @override
  Widget? getFloatingButton(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        _onItemTapped(
          2,
          ref,
        );
      },
      heroTag: null,
      shape: const CircleBorder(),
      elevation: 2.0,
      child: Assets.images.icSbaFloating.svg(),
    );
  }

  @override
  FloatingActionButtonLocation get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerDocked;

  void _onItemTapped(int value, WidgetRef ref) {
    final realValue = value < 0 ? 2 : value;
    ref.read(tabIndexProvider.notifier).update((state) => value);
    ref.read(provider(ref).notifier).pageController.jumpToPage(realValue);
  }
}
