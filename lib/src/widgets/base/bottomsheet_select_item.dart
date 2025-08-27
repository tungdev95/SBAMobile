import 'package:flutter/material.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/base/bottom_sheet_action_model.dart';
import 'package:sba/src/utils/base_flutter_extensions.dart';

class BottomSheetSelectItem extends StatelessWidget {
  String? title;
  final List<BottomSheetActionModel> lsItem;

  BottomSheetSelectItem({Key? key, this.title, required this.lsItem})
      : super(key: key) {
    title ??= S.current.chon;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              title ?? '',
              style: context.textNormal,//.copyWith(color: colorBlackTypoSub),
            ),
          ),
        ),
        const Divider(
          height: 0,
        ),
        ListView.separated(
          itemCount: lsItem.length,
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 0,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            var item = lsItem[index];
            return TextButton(
              onPressed: () {
                Navigator.of(context).pop(item);
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith(
                      (states) => const EdgeInsets.symmetric(vertical: 16))),
              child: Text(
                item.title ?? '',
                style: context.textNormal.copyWith(
                  // color: item.isNegative == true ? colorRed : colorPrimary,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
