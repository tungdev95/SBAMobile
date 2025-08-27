import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/assets/controller/bds/bds.dart';
import 'package:sba/src/utils/utils.dart';

final detailLandProvider = Provider.autoDispose<DetailData>((ref) {
  throw UnimplementedError();
});

class DetailLandInfoPage
    extends BaseDetailInfoPage<DetailLandState, DetailLandInfoPageController> {
  const DetailLandInfoPage({super.key});

  @override
  String get title => S.current.thong_tin_thua_dat;

  @override
  AutoDisposeStateNotifierProvider<DetailLandInfoPageController,
      DetailLandState> provider(WidgetRef ref) {
    return DetailLandInfoPageController.detailLandInfoProvider(
        ref.watch(detailLandProvider));
  }

  @override
  Widget headerWidget(
      BuildContext context, WidgetRef ref, DetailLandState state) {
    final landInfo = state.landInfo;
    bool isEnableMDHH =
        landInfo.assetLandUsingPurposes.length > 1 && !landInfo.isConsolidation;
    if (!isEnableMDHH) {
      state.landInfo.isConsolidationPurpose = false;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CheckboxListTile(
          value: state.landInfo.isConsolidationPurpose,
          tileColor: Colors.white,
          onChanged: (onChanged) {
            ref.read(provider(ref).notifier).updateMucDichHonHop(onChanged);
          },
          enabled: isEnableMDHH,
          title: Text(
            S.current.muc_dich_hon_hop,
            style: context.textMediumBold,
          ),
        ),
        const Divider(
          height: 0,
        ),
      ],
    );
  }
}
