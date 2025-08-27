import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/mmtb_model.dart';
import 'package:sba/src/utils/dialog_utils.dart';
import 'package:sba/src/widgets/bottomsheet/base_bottomsheet_body.dart';
import 'package:sba/src/widgets/buttons/stadium_button.dart';
import 'package:sba/src/widgets/custom_input_widget.dart';

typedef UploadFile = Future<bool> Function(BuildContext, RepairHistory);

class LichSuSuaChuaPage extends ConsumerWidget {
  final RepairHistory item;
  final UploadFile uploadFile;
  var lsItem = [];

  LichSuSuaChuaPage({
    super.key,
    required this.item,
    required this.lsItem,
    required this.uploadFile,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseBottomSheetBodyWidget(
      title: S.current.thong_tin_sua_chua_va_bao_hanh,
      children: [
        const SizedBox(
          height: 8,
        ),
        ...lsItem
            .map(
              (e) => CustomInputWidget(
                inputFieldModel: e,
                margin: const EdgeInsets.only(bottom: 16),
              ),
            )
            .toList(),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: CustomButton.danger(
                context,
                title: S.current.huy,
                onPressed: () {
                  Navigator.pop(context, null);
                },
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: CustomButton.primary(
                context,
                title: S.current.hoan_tat,
                onPressed: () async {
                  if (item.repairStatusId == null ||
                      item.dateRepair == null ||
                      item.note == null ||
                      item.tenTaiLieu.isEmpty) {
                    DialogUtils.showMessageDialog(
                        context, S.current.vui_long_nhap_thong_tin);
                    return;
                  }

                  if (item.fileAttach == null) {
                    Navigator.of(context).pop(item);
                    return;
                  }
                  final uploadResult = await uploadFile.call(context, item);
                  if (uploadResult) {
                    Navigator.of(context).pop(item);
                    return;
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
