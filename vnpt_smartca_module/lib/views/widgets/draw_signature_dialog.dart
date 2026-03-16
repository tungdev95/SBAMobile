// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:typed_data';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:vnpt_smartca_module/configs/app_config.dart';
import 'package:vnpt_smartca_module/views/utils/color.dart';

import '../i18n/generated_locales/l10n.dart';
import 'app_button_widget.dart';
import 'base_text.dart';

class DrawSignatureWidget extends StatefulWidget {
  final ValueChanged<Uint8List> callBack;

  const DrawSignatureWidget({super.key, required this.callBack});

  @override
  State<StatefulWidget> createState() => _DrawSignatureState();
}

class _DrawSignatureState extends State<DrawSignatureWidget> {
  late Uint8List _signatureData;
  bool _isDrawed = false;
  bool _hasError = false;

  final SignatureController _controller = SignatureController(
    disabled: false,
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.black,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Align(
        //   alignment: Alignment.topRight,
        //   child: IconButton(
        //     icon: Icon(
        //       Icons.close,
        //       color: Colors.grey,
        //       size: 25,
        //     ),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        SizedBox(height: 20),
        BaseText(
          AppLocalizations.current.drawYourSignature,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.white),
            //   color: Colors.white,
            // ),
            alignment: Alignment.center,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(16),
              dashPattern: [7, 10],
              color: Color(0xffB0B0B0),
              strokeWidth: 1,
              // child: Card(
              //   color: Colors.amber,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              child: Signature(
                controller: _controller,
                width: Get.width - 30,
                height: 260,
                backgroundColor: Colors.white,
              ),
              // SfSignaturePad(
              //   key: _signaturePadKey,
              //   // backgroundColor: Colors.grey[200],
              //   onDrawEnd: onDrawEnd,
              // ),
              // ),
            )
            // child: Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(16),
            //     border: Border.all(color: Color(0xffB0B0B0)),
            //   ),
            //   child: SfSignaturePad(
            //     key: _signaturePadKey,
            //     // backgroundColor: Colors.grey[200],
            //     onDrawEnd: onDrawEnd,
            //   ),
            // ),
            ),
        Visibility(
          visible: _hasError,
          child: Center(
            child: BaseText(
              AppLocalizations.current.pleaseAddYourSignature,
              color: Color(0xffE51F1F),
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(width: 20),
            Expanded(
              flex: 1,
              child: AppButtonWidget(
                label: AppLocalizations.current.clear,
                // labelColor: Color(0xff0D75D6),
                // backgroundColor: Color(0xffE0F0FF),
                labelColor: HexColor(AppConfig.colorPrimaryBtn),
                backgroundColor: HexColor(AppConfig.colorSecondBtn),
                border: AppConfig.colorPrimaryBtn == "#0D75D6"
                    ? null
                    : Border.all(
                        width: 1.5, color: HexColor(AppConfig.colorPrimaryBtn)),
                onTap: () {
                  setState(() {
                    _isDrawed = false;
                  });
                  _controller.clear();
                },
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 1,
              child: AppButtonWidget(
                label: AppLocalizations.current.confirm,
                backgroundColor: HexColor(AppConfig.colorPrimaryBtn),
                onTap: () {
                  handleSaveButtonPressed();
                },
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  void onDrawEnd() {
    print('end draw');
    setState(() {
      _isDrawed = true;
    });
  }

  Future handleSaveButtonPressed() async {
    _isDrawed = false;

    final bytes = await _controller.toPngBytes();
    if (bytes != null) {
      // data = bytes.buffer.asUint8List();
      _isDrawed = true;

      setState(
        () {
          _signatureData = bytes;
        },
      );
    }

    if (_isDrawed) {
      Get.back();
      widget.callBack(_signatureData);
    } else {
      setState(() {
        _hasError = true;
      });
    }
  }
}
