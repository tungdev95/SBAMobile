import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/src/state_notifier_provider.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/src/models/assets/approval_submission_model.dart';
import 'package:sba/src/models/assets/submission_detail_model.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/screens/trinhky/states/ketqua_chitiet_state.dart';
import 'package:sba/src/screens/trinhky/widgets/ket_qua_chi_tiet_expand_widget.dart';
import 'package:sba/src/utils/base_flutter_extensions.dart';

import 'controller/ketqua_chitiet_controller.dart';

final history = Provider<ApprovalHistory>((ref) {
  throw UnimplementedError();
});

class KetQuaChiTietPage
    extends BasePage<KetQuaChiTietPageController, KetQuaChiTietState> {
  const KetQuaChiTietPage({super.key});

  @override
  String get title => 'Kết quả chi tiết';

  @override
  Widget bodyWidget(
      BuildContext context, WidgetRef ref, KetQuaChiTietState state) {
    final isExpandList = useState([true, true, true]);
    final contructionValue = state.history.constructionFutureValue ?? 0.0;
    return SingleChildScrollView(
      child: KetQuaChiTietExpandWidget(
        assetType: state.history.assetType,
        allowEdit: false,
        submissionDetail: SubmissionDetailModel(
          tablePP: [],
          tableKQDat: state.history.approvalHistoryValueDtos
              .map((e) => KQDatModel.fromJson(e.toJson()))
              .toList(),
          tableKQCTXD: state.history.approvalHistoryConstructionDtos.map(
            (e) {
              try {
                final jsonData = e.toJson();
                if (jsonData['constructionName'] is String) {
                  jsonData['constructionName'] = {
                    'constructionName': jsonData['constructionName']
                  };
                }
                if (jsonData['constructionTypeName'] != null &&
                    jsonData['constructionType'] == null) {
                  jsonData['constructionType'] = {
                    'constructionTypeName': jsonData['constructionTypeName']
                  };
                }
                return KQCTXDModel.fromJson(
                  jsonData,
                );
              } catch (e) {
                return KQCTXDModel();
              }
            },
          ).toList(),
          tableKQ: state.history.approvalHistoryValueDtos
              .map((e) => KQDatModel.fromJson(e.toJson()))
              .toList(),
          tableTong: TongModel(
            constructionFutureValue: contructionValue.toInt(),
          ),
        ),
        chiTietDat: (context, e) {
          ref.read(provider(ref).notifier).chiTietInfo(context, e);
        },
        chiTietCTXD: (context, e) {
          ref.read(provider(ref).notifier).chiTietCTXD(context, e);
        },
        chiTietMMTB: (context, e) {
          ref.read(provider(ref).notifier).chiTietMMTB(context, e);
        },
        reloadCount: () {},
      ),
    );
  }

  @override
  AutoDisposeStateNotifierProvider<KetQuaChiTietPageController,
      KetQuaChiTietState> provider(WidgetRef ref) {
    return KetQuaChiTietPageController.controller(ref.read(history));
  }

  Widget getTitleWidget(
    BuildContext context,
    String title, {
    bool boldTitle = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: boldTitle ? context.textMediumBold : context.textMedium,
        ),
      ),
    );
  }

  Widget detailItemWidget(
    BuildContext context,
    WidgetRef ref,
    String title,
    String subTitle,
    Function() onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      margin: const EdgeInsets.all(8),
      child: ListTile(
        onTap: onTap,
        leading: Assets.images.icLeadingBuilding.svg(),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          subTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
