import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:riverpod/src/state_notifier_provider.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/screens/home/states/setting_state.dart';
import 'package:sba/src/screens/home/widgets/caidat_item_widget.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/widgets/widget_network_image.dart';

import 'controller/setting_page_controller.dart';

class SettingPage extends BasePage<SettingPageController, SettingState> {
  const SettingPage({super.key});

  @override
  Color backgroundColor(BuildContext context) => Colors.transparent;

  @override
  String get title => S.current.cai_dat;

  @override
  bool enableBack() => false;

  @override
  AutoDisposeStateNotifierProvider<SettingPageController, SettingState>
      provider(WidgetRef ref) {
    return SettingPageController.settingController;
  }

  @override
  Widget bodyWidget(BuildContext context, WidgetRef ref, SettingState state) {
    var widgetWidth = MediaQuery.of(context).size.width;
    var avatarSize = widgetWidth * .25;
    var user = ref.read(appController).userLogin;
    final iconColor = Theme.of(context).iconTheme.color;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            Container(
              width: widgetWidth,
              padding: EdgeInsets.only(top: context.padding.top + 24),
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      // cubit.changeAvatar(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFCACFEE).withOpacity(.15),
                        borderRadius: BorderRadius.circular(avatarSize + 40),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9BE6C8),
                          borderRadius:
                              BorderRadius.circular((avatarSize / 2) + 6),
                        ),
                        child: RoundedImage(
                          width: avatarSize,
                          height: avatarSize,
                          fit: BoxFit.cover,
                          url: user?.userAvatar ?? '',
                          radius: avatarSize / 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    user?.fullName ?? '',
                    style: context.textTitleBold.copyWith(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  // Text(
                  //   S.current.ten_dang_nhap(user?.username ?? ''),
                  //   style: context.textNormal.copyWith(
                  //     color: (isTet ? Colors.black : Colors.white)
                  //         .withOpacity(.7),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CaiDatItemWidget(
                  icon: Assets.images.icKichhoatChukyso.svg(),
                  title: S.current.quan_ly_tai_khoan_ky_so,
                  onClicked: () {
                    ref.read(provider(ref).notifier).getMainInfo(context);
                  },
                ),
                const Divider(),
                CaiDatItemWidget(
                  icon: Assets.images.icLogout.svg(),
                  title: S.current.dang_xuat,
                  onClicked: () {
                    ref.read(appController.notifier).logOut();
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
