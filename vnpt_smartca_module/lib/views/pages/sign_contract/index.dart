// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vnpt_smartca_module/views/controller/auth_controller.dart';
import 'package:vnpt_smartca_module/views/controller/econtract_controller.dart';
import 'package:vnpt_smartca_module/views/controller/home_controller.dart';

import '../../../gen/assets.gen.dart';
import '../../i18n/generated_locales/l10n.dart';
import '../../theme/styles.dart';
import '../../widgets/widget.dart';

class SignContractView extends StatefulWidget {
  final String contractId;
  final String contractUrl;

  const SignContractView(
      {super.key, required this.contractId, required this.contractUrl});

  @override
  State<StatefulWidget> createState() => _SignContractViewState();
}

class _SignContractViewState extends State<SignContractView> {
  final transController = Get.find<HomeController>();
  final authenController = Get.find<AuthController>();
  // final eContractController = Get.find<BuyCertificateController>();
  final eContractController = Get.put(ContractController());

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.current.serviceRequestForm,
      body: Padding(
        padding: EdgeInsets.only(bottom: Platform.isIOS ? Get.height * 0.21 : Get.height * 0.21 + 35),
        child: PdfPreviewerWidget(
          fileName: widget.contractId,
          fileData: '',
          fileUrl: widget.contractUrl,
          showPagination: false,
        ),
      ),
      bottomSheet: Container(
          height: Platform.isIOS ? Get.height * 0.21 : Get.height * 0.21 + 35,
          padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 4,
                blurRadius: 6,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Obx(
            () => Column(
              children: [
                InkWell(
                    onTap: () {
                      eContractController.checkIRead1.value =
                          !eContractController.checkIRead1.value;
                    },
                    child: Row(
                      children: [
                        (eContractController.checkIRead1.value
                                ? Assets.images.icCheckbox
                                : Assets.images.icUncheck)
                            .image(
                          width: 25,
                          height: 25,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              children: [
                                TextSpan(
                                    text: AppLocalizations.current
                                        .desc_check1_serviceRequestForm),
                                TextSpan(
                                  text: AppLocalizations.current
                                      .subDesc_check1_serviceRequestForm,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      await launchUrl(
                                          mode: LaunchMode.externalApplication,
                                          Uri.parse("https://smartca.vnpt.vn/"));
                                    },
                                ),
                              ],
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        )
                      ],
                    )),
                SizedBox(height: 20),
                InkWell(
                    onTap: () {
                      eContractController.checkIRead2.value =
                          !eContractController.checkIRead2.value;
                    },
                    child: Row(
                      children: [
                        (eContractController.checkIRead2.value
                                ? Assets.images.icCheckbox
                                : Assets.images.icUncheck)
                            .image(
                          width: 25,
                          height: 25,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              children: [
                                TextSpan(
                                    text: AppLocalizations.current
                                        .desc_check2_serviceRequestForm),
                                TextSpan(
                                  text: AppLocalizations
                                      .current.desc_Electronic_Contract,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(
                                    text: AppLocalizations.current.of_VNPT),
                              ],
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        )
                      ],
                    )),
                SizedBox(height: 12),
                AppButtonWidget(
                  label: AppLocalizations.current.Continue,
                  backgroundColor: (eContractController.checkIRead1.value &&
                          eContractController.checkIRead2.value)
                      ? Color(0xff0D75D6)
                      : Colors.grey,
                  onTap: () async {
                    if (eContractController.checkIRead1.value &&
                        eContractController.checkIRead2.value) {
                      await eContractController
                          .signedWithoutOTP(widget.contractId);
                      Get.back();
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}

class PdfPreviewerWidget extends StatefulWidget {
  final String fileName;
  final String fileData;
  final String fileUrl;
  final bool showPagination;

  const PdfPreviewerWidget({
    Key? key,
    required this.fileName,
    required this.fileData,
    required this.fileUrl,
    this.showPagination = true,
  }) : super(key: key);

  @override
  _PdfPreviewerWidgetState createState() => _PdfPreviewerWidgetState();
}

class _PdfPreviewerWidgetState extends State<PdfPreviewerWidget> {
  late PdfViewerController _pdfViewerController;
  final eContractController = Get.find<ContractController>();

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    eContractController.writeData2Pdf(widget.fileUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(15)),
          child: eContractController.bytes.value == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      child: SfPdfViewerTheme(
                        data:
                            SfPdfViewerThemeData(backgroundColor: Colors.white),
                        child: SfPdfViewer.memory(
                          eContractController.bytes.value!,
                          controller: _pdfViewerController,
                        ),
                      ),
                    ),
                    widget.showPagination
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                constraints: BoxConstraints(maxHeight: 36),
                                icon: Icon(Icons.keyboard_arrow_left),
                                onPressed: _pdfViewerController.previousPage,
                              ),
                              AppStyles.pdl10,
                              Text(
                                  '${_pdfViewerController.pageNumber}/${_pdfViewerController.pageCount}'),
                              AppStyles.pdl10,
                              IconButton(
                                constraints: BoxConstraints(maxHeight: 36),
                                icon: Icon(Icons.keyboard_arrow_right),
                                onPressed: _pdfViewerController.nextPage,
                              )
                            ],
                          )
                        : Container(),
                  ],
                ),
        ));
  }
}
