// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/models/app/exceptions.dart';
import '../../../../core/models/response/transaction_model.dart';
import '../../../controller/app_controller.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/home_controller.dart';
import '../../../i18n/generated_locales/l10n.dart';
import '../../../theme/styles.dart';
import '../../../utils/enums.dart';
import '../../../utils/exception_handler.dart';
import '../../../widgets/base_screen.dart';
import '../../../widgets/bottom_contact.dart';
import '../../../widgets/button_general.dart';
import '../../../widgets/dialog/common_dialog.dart';
import '../../../widgets/dialog/enter_pin_for_dialog.dart';
import '../../../widgets/loading_circle_widget.dart';

class SignAcceptanceView extends StatefulWidget {
  final String credentialId;

  const SignAcceptanceView({super.key, required this.credentialId});

  @override
  State<StatefulWidget> createState() => SignAcceptance();
}

class SignAcceptance extends State<SignAcceptanceView> {
  final transController = Get.find<HomeController>();
  final authenController = Get.find<AuthController>();
  final appController = Get.find<AppController>();

  @override
  void initState() {
    super.initState();

    // transController.transactionRequestController
    //     .waitingtransAcceptance(widget.credentialId);

    transController.transactionRequestController
        .getBbntTrans(widget.credentialId);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BaseScreen(
        title: transController
                    .transactionRequestController.transactionInfo.value !=
                null
            ? AppLocalizations.current.signBbnt
            : "",
        body: Column(
          children: [Expanded(child: renderBody()), const BottomContact()],
        ),
      );
    });
  }

  ///Todo:phucbv check
  renderBody() {
    if (transController.transactionRequestController.transactionInfo.value !=
        null) {
      return showTranInfor(
          transController.transactionRequestController.transactionInfo.value!);
    } else if (transController.isLoading.value) {
      return LoadingCircleWidget(
        title: AppLocalizations.current.signBbnt,
        subtitle: AppLocalizations.current.waitaMinute,
      );
    }
    return Container();
  }

  // ignore: long-method
  Widget showTranInfor(TransactionModel item) {
    var lstDocs = item.docs;
    if (lstDocs.isEmpty) {
      return Container();
    }
    var element = lstDocs.first;

    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PdfPreviewerWidget(
              fileName: element['name'] ?? "",
              fileData: element['data'] ?? "",
              fileUrl: '',
              showPagination: false,
            ),
          ),
          ButtonGeneral(
              backgroundColor: const Color(0xff0D75D6),
              borderColor: Colors.transparent,
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
              title: AppLocalizations.current.signConfirm,
              // ignore: prefer-extracting-callbacks
              onCallBack: () async {
                if (authenController.currentUser.value?.useBiometric == true) {
                  final authenticated = await transController
                      .transactionRequestController
                      .useBiometricWithTransaction(
                          TransactionType.confirm, item);

                  if (authenticated == false) _showPINDialog();
                } else {
                  _showPINDialog();
                }
              }),
        ],
      ),
    );
  }

  void _showPINDialog() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: EnterPINDialog(
              description:
                  AppLocalizations.current.pinDialogConfirmSignDigitalTitle,
              buttonText: AppLocalizations.current.pinDialogButton,
              buttonColor: Color(0xff0D75D6),
              callback: (pin) => transController.transactionRequestController
                  .confirmWaitingTransaction(
                      pin,
                      transController
                          .transactionRequestController.transactionInfo.value!),
            ),
          );
        });
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
  Uint8List? bytes;
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    // ignore: avoid-unnecessary-setstate
    bytes = null;

    _writeData2Pdf(widget.fileData);
  }

  _writeData2Pdf(String text) async {
    try {
      final _bytes = base64.decode(text);
      setState(() {
        bytes = _bytes;
      });
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(15)),
      child: bytes == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: SfPdfViewerTheme(
                    data: SfPdfViewerThemeData(backgroundColor: Colors.white),
                    child: SfPdfViewer.memory(
                      bytes!,
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
    );
  }
}
