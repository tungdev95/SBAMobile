import 'package:flutter/material.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/src/screens/home/widgets/menu_item_widget.dart';
// import 'package:sba/models/base/main_menu_model.dart';
// import 'package:sba/pages/asset/page_asset.dart';
import 'package:sba/src/utils/base_flutter_extensions.dart';
import 'package:sba/src/utils/utils.dart';

import '../models/base/base.dart';

Widget topMenuWidget(BuildContext context,
    List<AssetMenuModel<SvgGenImage>> lsMenu, AssetsTypeEnum? selectedMenu,
    {Function(AssetsTypeEnum)? onMenuClick}) {
  var crossExtend = lsMenu.length % 4 == 0 ? 4 : 3;
  var childAspectRatio = crossExtend == 4 ? 1.2 : 1.4;
  var maxCrossAxisExtent =
      context.screenSize.width / (lsMenu.length == 1 ? 1 : crossExtend);
  if (maxCrossAxisExtent < 0) return const SizedBox.shrink();

  return GridView.builder(
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
      var item = lsMenu[index];
      return MemuItemWidget(
        item: item,
        icon: item.image?.svg(height: 75) ?? const SizedBox.shrink(),
      );
    },
    itemCount: lsMenu.length,
  );
  // return GridView.builder(
  //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //   physics: const NeverScrollableScrollPhysics(),
  //   shrinkWrap: true,
  //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
  //     maxCrossAxisExtent:
  //         context.screenSize.width / (lsMenu.length == 1 ? 1 : crossExtend),
  //     mainAxisSpacing: 0.0,
  //     crossAxisSpacing: 0.0,
  //     childAspectRatio: lsMenu.length == 1 ? 4.5 : childAspectRatio,
  //   ),
  //   itemBuilder: (context, index) {
  //     var item = lsMenu[index];
  //     return Material(
  //       color: Colors.transparent,
  //       child: InkWell(
  //         borderRadius: BorderRadius.circular(16),
  //         onTap: () {
  //           if (onMenuClick == null) return;
  //           onMenuClick(item.id);
  //         },
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Stack(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(top: 4, right: 4),
  //                   child: ClipRRect(
  //                     borderRadius: BorderRadius.circular(16.0),
  //                     child: Image(
  //                       width: context.screenSize.width * 0.14,
  //                       height: context.screenSize.width * 0.14,
  //                       image: AssetImage(item.imageName),
  //                     ),
  //                   ),
  //                 ),
  //                 Positioned(
  //                   top: 0,
  //                   right: 0,
  //                   child: Visibility(
  //                     visible: item.notiCount > 0,
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                           color: Colors.red,
  //                           borderRadius: BorderRadius.circular(9),
  //                           border: Border.all(color: Colors.white, width: 1)),
  //                       constraints: const BoxConstraints(
  //                           minWidth: 18, maxHeight: 18, minHeight: 18),
  //                       child: Center(
  //                         child: Text(
  //                           '${item.notiCount}',
  //                           style: const TextStyle(
  //                             color: Colors.white,
  //                             fontSize: 8,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                           textAlign: TextAlign.center,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //             const SizedBox(
  //               height: 6.0,
  //             ),
  //             Text(
  //               item.title,
  //               textAlign: TextAlign.center,
  //               maxLines: 1,
  //               style: context.textMediumMedium.copyWith(
  //                 fontSize: 12,
  //                 fontWeight: selectedMenu == item.id
  //                     ? FontWeight.bold
  //                     : FontWeight.normal,
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     );
  //   },
  //   itemCount: lsMenu.length,
  // );
}

Widget horizontalMenuWidget(
    BuildContext context, List<AssetMenuModel> lsMenu, AssetsTypeEnum? selectedMenu,
    {Function(AssetsTypeEnum)? onMenuClick}) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    itemCount: lsMenu.length,
    itemBuilder: (context, index) {
      var item = lsMenu[index];
      return InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          if (item.id == MenuEnum.TAI_SAN) {
            // AppRoutes.push(context, AssetPage());
          } else {
            if (onMenuClick == null) return;
            onMenuClick(item.id);
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image(
                        width: context.screenSize.width * 0.14,
                        height: context.screenSize.width * 0.14,
                        image: AssetImage(item.imageName),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Visibility(
                      visible: item.notiCount > 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        constraints: const BoxConstraints(
                            minWidth: 18, maxHeight: 18, minHeight: 18),
                        child: Center(
                          child: Text(
                            '${item.notiCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                item.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: context.textMediumMedium.copyWith(
                  fontSize: 12,
                  fontWeight: selectedMenu == item.id
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
