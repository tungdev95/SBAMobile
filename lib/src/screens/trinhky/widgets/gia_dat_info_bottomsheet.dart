import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/submission_detail_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/widgets/bottomsheet/base_bottomsheet_body.dart';
import 'package:sba/src/widgets/buttons/stadium_button.dart';
import 'package:sba/src/widgets/custom_input_widget.dart';

class KetQuaChiTietGiaDat extends ConsumerWidget {
  final KQDatModel item;
  final List<InputFieldModel> lsItem;

  const KetQuaChiTietGiaDat({
    super.key,
    required this.item,
    required this.lsItem,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseBottomSheetBodyWidget(
      title: S.current.ket_qua_chi_tiet_gia_dat,
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: CustomInputWidget(
                inputFieldModel: lsItem[0],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: CustomInputWidget(
                inputFieldModel: InputFieldModel<String>(
                  label: S.current.phan_loai,
                  data: item.typeString,
                  enable: false,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: CustomInputWidget(
                inputFieldModel: lsItem[1],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: CustomInputWidget(
                inputFieldModel: lsItem[2],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: CustomInputWidget(
                inputFieldModel: lsItem[3],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        CustomButton.primary(
          context,
          title: S.current.hoan_tat,
          onPressed: () {
            Navigator.pop(context, item);
          },
        ),
      ],
    );
  }
}
