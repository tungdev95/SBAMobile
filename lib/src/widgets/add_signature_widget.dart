// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

class AddSignatureDialogWidget extends HookConsumerWidget {
  final String title;
  const AddSignatureDialogWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    var chuKy = useState(GlobalKey<SfSignaturePadState>());
    // var width = MediaQuery.of(context).size.width * .7;
    var height = 300.0; //width * 3 / 2;
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        height: height,
        width: double.infinity,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  title,
                  // maxLines: 1,
                  textAlign: TextAlign.center,
                  style: context.textNormalBold,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: DottedBorder(
                color: Colors.black,
                borderType: BorderType.RRect,
                radius: const Radius.circular(16),
                strokeWidth: 1,
                child: SfSignaturePad(
                  key: chuKy.value,
                  minimumStrokeWidth: 1,
                  maximumStrokeWidth: 3,
                  strokeColor: Theme.of(context).primaryColor,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    ui.Image? image = (await chuKy.value.currentState
                        ?.toImage(pixelRatio: 3));
                    var resultImage = await image?.toByteData(
                      format: ui.ImageByteFormat.png,
                    );
                    Navigator.of(context)
                        .pop(resultImage?.buffer.asUint8List());
                  },
                  child: const Text('OK'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
