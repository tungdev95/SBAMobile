import 'package:flutter/material.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/src/widgets/widget_common.dart';

import '../models/base/base.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  double? _topPadding;
  AssetsTypeEnum? selectedMenu;
  Function(AssetsTypeEnum) menuClick;
  final double maxHeightExtent;
  List<AssetMenuModel<SvgGenImage>> lsMenu;

  MySliverAppBar({
    required this.menuClick,
    required this.lsMenu,
    required this.maxHeightExtent,
    this.selectedMenu,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    _topPadding ??= MediaQuery.of(context).padding.top;

    double percent = shrinkOffset / (maxExtent - minExtent);
    percent = percent > 1 ? 1 : percent;

    if (maxExtent < 200) {
      percent = 0;
    }

    // final double stretchOpacity = 1 -
    //           (((constraints.maxHeight - settings.maxExtent) / 100).clamp(0.0, 1.0));

    return Container(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          _buildListMenu(context, percent, lsMenu),
          _buildGridMenu(context, percent, selectedMenu, lsMenu)
        ],
      ),
    );
  }

  Widget _buildGridMenu(context, double percent, AssetsTypeEnum? selectedMenu,
      List<AssetMenuModel<SvgGenImage>>? data) {
    double opacity =
        1 - percent; //(1 - percent * 1.5) < 0 ? 0 : (1 - percent * 1.5);
    return IgnorePointer(
      ignoring: opacity < .3,
      child: SizedBox(
        height: maxExtent,
        child: Opacity(
          opacity: opacity,
          child: _menuWidget(context, selectedMenu, data),
        ),
      ),
    );
  }

  Widget _buildListMenu(context, double percent, List<AssetMenuModel>? data) {
    double opacity = percent;
    return IgnorePointer(
      ignoring: opacity < .3,
      child: SizedBox(
        height: maxExtent,
        child: Opacity(
          opacity: percent,
          child: _listMenuWidget(context, selectedMenu, data),
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxHeightExtent;

  @override
  double get minExtent => maxHeightExtent > 200 ? 100 : maxHeightExtent;

  @override
  bool shouldRebuild(covariant MySliverAppBar oldDelegate) =>
      oldDelegate.lsMenu != lsMenu;

  MediaQuery _menuWidget(BuildContext context, AssetsTypeEnum? selectedMenu,
      List<AssetMenuModel<SvgGenImage>>? data) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: Container(
        margin: const EdgeInsets.only(top: 32, bottom: 0),
        color: Colors.transparent,
        child: topMenuWidget(
          context,
          data ?? [],
          selectedMenu,
          onMenuClick: (AssetsTypeEnum menuId) {
            menuClick(menuId);
          },
        ),
      ),
    );
  }

  Widget _listMenuWidget(
      BuildContext context, AssetsTypeEnum? selectedMenu, List<AssetMenuModel>? data) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 8),
      child: horizontalMenuWidget(
        context,
        data ?? [],
        selectedMenu,
        onMenuClick: (AssetsTypeEnum menuId) {
          menuClick(menuId);
        },
      ),
    );
  }
}
