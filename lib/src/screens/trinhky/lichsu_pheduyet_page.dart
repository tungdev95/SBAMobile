import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:riverpod/src/state_notifier_provider.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/screens/trinhky/controller/lichsu_pheduyet_controller.dart';
import 'package:sba/src/screens/trinhky/states/lichsu_pheduyet_page_state.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/widgets/keyvalule_widget.dart';

final assetInfo = Provider<AssetsModel>((ref) {
  throw UnimplementedError();
});

class LichSuPheDuyetPage
    extends BasePage<LichSuPheDuyetPageController, LichSuPheDuyetState> {
  const LichSuPheDuyetPage({super.key});

  @override
  Color backgroundColor(BuildContext context) => Colors.white;

  @override
  String get title => S.current.lich_su_phe_duyet_to_trinh;

  @override
  Widget bodyWidget(
      BuildContext context, WidgetRef ref, LichSuPheDuyetState state) {
    final lsItem = state.item?.approvalHistoryDtos ?? [];
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final item = lsItem[index];
        return GestureDetector(
          onTap: () {
            ref.read(provider(ref).notifier).chiTiet(context, item);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
            ),
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                KeyValueWidget(
                  title: S.current.thoi_gian,
                  value: item.createdDate
                          ?.toLocal()
                          .toStringFormat(showInfoDateFormat) ??
                      '',
                ),
                KeyValueWidget(
                  title: S.current.nguoi_phe_duyet_gan_nhat,
                  value: item.tenNguoiPheDuyet,
                ),
                KeyValueWidget(
                  title: S.current.nguoi_phe_duyet_tiep_theo,
                  value: item.tenNguoiPheDuyetTiepTheo,
                ),
                KeyValueWidget(
                  title: S.current.trang_thai_phe_duyet,
                  value: item.trangThaiPheDuyet,
                ),
                KeyValueWidget(
                  title: S.current.so_cap_da_duyet,
                  value: '${item.level}/${item.totalLevel}',
                ),
                KeyValueWidget(
                  title: S.current.noi_dung_y_kien,
                  value: item.approvalComment ?? '',
                ),
              ],
            ),
          ),
        );
      },
      itemCount: lsItem.length,
    );
  }

  @override
  AutoDisposeStateNotifierProvider<LichSuPheDuyetPageController,
      LichSuPheDuyetState> provider(
          WidgetRef ref) =>
      LichSuPheDuyetPageController.controller(ref.read(assetInfo));
}
