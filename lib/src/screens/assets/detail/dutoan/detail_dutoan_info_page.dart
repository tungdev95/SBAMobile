import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/assets/controller/dutoan/detail_dutoan_controller.dart';
import 'package:sba/src/utils/utils.dart';

final detailDuToanLandProvider = Provider.autoDispose<DetailData>((ref) {
  throw UnimplementedError();
});

class DetailDuToanInfoPage
    extends BaseDetailInfoPage<DetailLandState, DetailDuToanPageController> {
  const DetailDuToanInfoPage({super.key});

  @override
  String get title => S.current.thong_tin_thua_dat;

  @override
  AutoDisposeStateNotifierProvider<DetailDuToanPageController, DetailLandState>
      provider(WidgetRef ref) {
    return DetailDuToanPageController.detailLandInfoProvider(
        ref.watch(detailDuToanLandProvider));
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
          enabled: isEnableMDHH,
          onChanged: (onChanged) {
            ref.read(provider(ref).notifier).updateMucDichHonHop(onChanged);
          },
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
