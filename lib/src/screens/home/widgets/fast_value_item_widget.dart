import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/src/models/assets/fast_valuation_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/utils/utils.dart';

final AutoDisposeProvider fastValueItemProvider = Provider.autoDispose((ref) {
  throw UnimplementedError();
});

class FastValueItemWidget<T extends FastValuationModel> extends ConsumerWidget {
  final String? type;
  final void Function()? onTap;

  const FastValueItemWidget({
    Key? key,
    this.type,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var item = ref.watch(fastValueItemProvider) as T;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
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
                        ],
                      ),
                      Text(item.address ?? ''),
                      Text(
                        item.customerName ?? '',
                        style: context.textNormal.copyWith(
                          color: AppColor.colorBlackTextSub,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SvgGenImage _getPlaceHolderName(FastValuationModel item) {
    final type = T.toString();
    if (type == 'FastValuationModel') {
      return AssetsTypeEnum.dinhGiaNhanhBDS.image;
    } else if (type == 'CHCCFastValModel') {
      return AssetsTypeEnum.dinhGiaNhanhCHCC.image;
    }
    return AssetsTypeEnum.dinhGiaNhanhBDS.image;
  }
}
