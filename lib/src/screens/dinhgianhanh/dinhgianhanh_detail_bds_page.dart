import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:riverpod/src/state_notifier_provider.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/fast_valuation_model.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/dinhgianhanh/controller/dinhgianhanh_bds_page_controller.dart';
import 'package:sba/src/screens/dinhgianhanh/state/dinhgianhanh_page_state.dart';
import 'package:sba/src/widgets/buttons/stadium_button.dart';

final fastBDSItemProvider = Provider<FastValuationModel>((ref) {
  throw UnimplementedError();
});

class DinhGiaNhanhBDSPage extends BaseDetailInfoPage<DinhGiaNhanhPageState,
    DinhGiaNhanhBDSPageController> {
  const DinhGiaNhanhBDSPage({super.key});

  @override
  String get title => S.current.dinh_gia_nhanh_nha_pho;

  @override
  AutoDisposeStateNotifierProvider<DinhGiaNhanhBDSPageController,
      DinhGiaNhanhPageState> provider(WidgetRef ref) {
    return DinhGiaNhanhBDSPageController.dinhGiaNhanhController(
        ref.read(fastBDSItemProvider));
  }

  @override
  List<Widget>? persistentFooterButtons(BuildContext context, WidgetRef ref) {
    return [
      Row(
        children: [
          Expanded(
            child: CustomButton.primary(
              context,
              title: S.current.dinh_gia,
              onPressed: () {
                ref.read(provider(ref).notifier).chiTietDinhGia(context);
              },
            ),
          )
        ],
      ),
    ];
  }
}
