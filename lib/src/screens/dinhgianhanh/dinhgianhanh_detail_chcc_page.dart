import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:riverpod/src/state_notifier_provider.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/chcc_fast_valuation_model.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/dinhgianhanh/controller/dinhgianhanh_chcc_page_controller.dart';
import 'package:sba/src/screens/dinhgianhanh/state/dinhgianhanh_chcc_page_state.dart';
import 'package:sba/src/widgets/buttons/stadium_button.dart';

final fastCHCCItemProvider = Provider<CHCCFastValModel>((ref) {
  throw UnimplementedError();
});

class DinhGiaNhanhCHCCPage extends BaseDetailInfoPage<DinhGiaNhanhCHCCPageState,
    DinhGiaNhanhCHCCPageController> {
  const DinhGiaNhanhCHCCPage({super.key});

  @override
  String get title => S.current.dinh_gia_nhanh_chung_cu;

  @override
  AutoDisposeStateNotifierProvider<DinhGiaNhanhCHCCPageController,
      DinhGiaNhanhCHCCPageState> provider(WidgetRef ref) {
    return DinhGiaNhanhCHCCPageController.dinhGiaNhanhController(
        ref.read(fastCHCCItemProvider));
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
