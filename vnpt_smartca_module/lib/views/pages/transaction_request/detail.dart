// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/views/widgets/base_screen.dart';
import '../../../method_channel_handler.dart';
import '../../../views/controller/transaction_controller.dart';
import '../../../views/i18n/generated_locales/l10n.dart';
import '../../../views/pages/transaction_request/widgets/preview_item_tran_body.dart';
import '../../../views/pages/transaction_request/widgets/transaction_actions_buttons.dart';
import '../../controller/app_controller.dart';
import '../../utils/enums.dart';

class TransactionDetail extends StatelessWidget {
  static String routeName = "/TransactionDetail";
  final controller = Get.find<TransactionController>();
  TransactionDetail({Key? key}) : super(key: key) {
    try {
      Future.delayed(
        Duration(milliseconds: 500),
        () {
          controller.onPressCommand(
              controller.transactionInfo.value!, TransactionType.confirm,
              needGetDetail: false);
        },
      );
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final hiddenIconBack =
        Get.find<AppController>().currentHostAppMethod.value ==
            MethodChannelNames.getWaitingTransaction;

    return BaseScreen(
      hiddenIconBack: hiddenIconBack,
      title: AppLocalizations.current.transactionDetail,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: PreviewItemTransactionBody(
                      model: controller.transactionInfo.value!),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 10.0, bottom: 20.0),
            child: TransactionActionsButtons(
                transactionModel: controller.transactionInfo.value!,
                needGetDetail: false),
          )
        ],
      ),
    );
  }
}
