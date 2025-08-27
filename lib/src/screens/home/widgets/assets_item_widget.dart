import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sba/gen/assets.gen.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/assets/detail/duan/duan_detail_page.dart';
import 'package:sba/src/screens/assets/detail/dutoan/dutoan_detail_page.dart';
import 'package:sba/src/screens/assets/detail/mmtb/mmtb_detail_page.dart';
import 'package:sba/src/screens/assets/detail/ptdb/ptdb_detail_page.dart';
import 'package:sba/src/screens/assets/detail/ptdt/ptdt_detail_page.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/utils/utils.dart';

final assetsItemprovider = Provider.autoDispose<AssetsModel>((ref) {
  throw UnimplementedError();
});
typedef HandleCompleteItem = Function(AssetsModel);

class AssetsItemWidget extends ConsumerWidget {
  final String? type;
  final HandleCompleteItem? handleCompleteItem;
  final void Function()? onTap;
  final VoidCallback? reloadOnClose;

  const AssetsItemWidget({
    Key? key,
    this.type,
    this.handleCompleteItem,
    this.onTap,
    this.reloadOnClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var item = ref.watch(assetsItemprovider);
    final isSaved =
        ref.watch(assetSavedProvider).get(item.appraisalFileId ?? '');
    bool isDangKhaoSat =
        (item.fileStatus?.id ?? 100) <= FileStatus.dangKhaoSat.id;
    final child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Assets.images.bgItem
                        .image(
                          fit: BoxFit.cover,
                        )
                        .image,
                  ),
                ),
                child: _getPlaceHolderName(item).svg(),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.titleItem(),
                          style: context.textNormal.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (isSaved != null) Assets.images.icSaved.svg()
                    ],
                  ),
                  Text(
                    item.reportCode ?? '',
                    style: context.textNormal.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(item.addressCustomDetail ?? item.address ?? ''),
                  Text(
                    item.branch?.branchName ?? '',
                    style: context.textNormal.copyWith(
                      color: AppColor.colorBlackTextSub,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: item.customerName,
                      children: (item.customer?.phoneNumber) != null
                          ? [
                              const TextSpan(
                                text: ' - ',
                              ),
                              TextSpan(
                                text: item.customer?.phoneNumber ?? '',
                                style: const TextStyle(
                                  color: Color(0xFF2862AF),
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            ]
                          : [],
                    ),
                  ),
                  if (item.pricingNumber > 0) ...[
                    const SizedBox(
                      height: 4,
                    ),
                    Text(S.current.so_lan_dinh_gia(item.rePricingNumber ?? 0)),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return Material(
      color: Colors.transparent,
      child: isDangKhaoSat
          ? OpenContainer(
              transitionDuration: const Duration(milliseconds: 350),
              transitionType: ContainerTransitionType.fade,
              onClosed: (data) {
                if (isDangKhaoSat) {
                  reloadOnClose?.call();
                }
              },
              openBuilder: (context, openContainer) {
                Widget? detailWidget;
                final allowComplete =
                    item.fileStatus == FileStatus.daCoLichKhaoSat;
                if (item.assetType == AssetsTypeEnum.bds) {
                  detailWidget =
                      RealEstateDetailPage(allowComplete: allowComplete);
                } else if (item.assetType == AssetsTypeEnum.chcc) {
                  detailWidget = CHCCDetailPage(allowComplete: allowComplete);
                } else if (item.assetType == AssetsTypeEnum.duToan) {
                  detailWidget = DuToanDetailPage(allowComplete: allowComplete);
                } else if (item.assetType == AssetsTypeEnum.ptdb) {
                  detailWidget = PTDBDetailPage(allowComplete: allowComplete);
                } else if (item.assetType == AssetsTypeEnum.mmtb) {
                  detailWidget = MMTBDetailPage(allowComplete: allowComplete);
                } else if (item.assetType == AssetsTypeEnum.ptdt) {
                  detailWidget = PTDTDetailPage(allowComplete: allowComplete);
                } else if (item.assetType == AssetsTypeEnum.duAn) {
                  detailWidget = DuAnDetailPage(allowComplete: allowComplete);
                }

                if (detailWidget == null) return const SizedBox.shrink();

                return ProviderScope(
                  overrides: [assetsDetailProvider.overrideWithValue(item)],
                  child: detailWidget,
                );
              },
              openColor: AppColor.backgroundColor,
              closedColor: Colors.white,
              closedElevation: 0,
              tappable: tappable(item),
              closedBuilder: (context, openContainer) {
                return child;
              },
            )
          : InkWell(
              onTap: onTap,
              child: child,
            ),
    );
  }

  void handleCompletedPage(BuildContext context, item) {
    handleCompleteItem?.call(item);
  }

  bool tappable(AssetsModel item) {
    final assetType = item.assetType;
    if (assetType == AssetsTypeEnum.bds ||
        assetType == AssetsTypeEnum.chcc ||
        assetType == AssetsTypeEnum.duToan ||
        assetType == AssetsTypeEnum.ptdb ||
        assetType == AssetsTypeEnum.mmtb ||
        assetType == AssetsTypeEnum.ptdt ||
        assetType == AssetsTypeEnum.duAn) {
      return true;
    }

    return false;
  }

  SvgGenImage _getPlaceHolderName(AssetsModel item) {
    return item.assetType.image;
  }
}
