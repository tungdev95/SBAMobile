import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/widgets/bottomsheet/base_bottomsheet_body.dart';
import 'package:sba/src/widgets/buttons/stadium_button.dart';
import 'package:sba/src/widgets/custom_input_widget.dart';

class KetQuaChiTietBottomSheet extends StatelessWidget {
  final List<InputFieldModel> lsItem;

  const KetQuaChiTietBottomSheet({
    super.key,
    required this.lsItem,
  });

  @override
  Widget build(BuildContext context) {
    final labelItem = lsItem[0];
    var remainItem =
        splitArrayIntoChunksOfTwo(lsItem.sublist(1, lsItem.length));
    return BaseBottomSheetBodyWidget(
      title: S.current.ket_qua_chi_tiet,
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: CustomInputWidget(
                inputFieldModel: labelItem,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        ...remainItem.map(
          (e) {
            if (e.length == 1) {
              return CustomInputWidget(
                margin: const EdgeInsets.only(top: 8),
                inputFieldModel: e[0],
              );
            } else {
              return Row(
                children: [
                  Expanded(
                    child: CustomInputWidget(
                      inputFieldModel: e[0],
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: CustomInputWidget(
                      inputFieldModel: e[1],
                    ),
                  ),
                ],
              );
            }
          },
        ).toList(),
        const SizedBox(
          height: 8,
        ),
        CustomButton.primary(
          context,
          title: S.current.hoan_tat,
          onPressed: () {
            bool isContainRequired = lsItem.any((element) {
              return element.isRequired == true &&
                  (element.value == null || element.value?.isEmpty == true);
            });
            if (isContainRequired) {
              BotToast.showText(text: S.current.vui_nhap_ten_tai_san);
              return;
            } else {
              Navigator.pop(
                context,
              );
            }
          },
        ),
      ],
    );
  }

  List<List<T>> splitArrayIntoChunksOfTwo<T>(List<T> originalList) {
    List<List<T>> chunks = [];
    for (int i = 0; i < originalList.length; i += 2) {
      int end = (i + 2 < originalList.length) ? i + 2 : originalList.length;
      chunks.add(originalList.sublist(i, end));
    }
    return chunks;
  }
}
