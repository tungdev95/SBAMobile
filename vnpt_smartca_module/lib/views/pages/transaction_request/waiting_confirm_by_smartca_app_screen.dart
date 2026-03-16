// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/views/i18n/generated_locales/l10n.dart';

import '../../../configs/app_config.dart';
import '../../../core/models/response/transaction_model.dart';
import '../../../gen/assets.gen.dart';
import '../../utils/color.dart';
import '../../widgets/bottom_contact.dart';
import '../../widgets/circular_count_down_timer.dart';
import '../../widgets/widget.dart';
import 'widgets/transaction_clock_count_down.dart';

class WaitingConfirmBySmartCAAppScreen extends StatefulWidget {
  final String label;
  final TransactionModel? transactionModel;
  final Function onChangeDevice;
  final Function openSmartCAApp;
  final Function waitingConfirmOnApp;

  WaitingConfirmBySmartCAAppScreen({
    Key? key,
    required this.label,
    required this.onChangeDevice,
    required this.transactionModel,
    required this.openSmartCAApp,
    required this.waitingConfirmOnApp,
  }) : super(key: key) {
    waitingConfirmOnApp();
  }

  @override
  State<StatefulWidget> createState() {
    return _WaitingConfirmBySmartCAAppScreenState();
  }
}

class _WaitingConfirmBySmartCAAppScreenState
    extends State<WaitingConfirmBySmartCAAppScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hideAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.images.icDialogNotice.image(height: 70),
                      const SizedBox(height: 5),
                      BaseText(
                        widget.label,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.5,
                        color: Color.fromARGB(255, 39, 50, 68),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 2),
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: HexColor(AppConfig.colorPrimaryBtn),
                            ),
                          ),
                          margin: EdgeInsets.only(top: 6),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Text(
                            "${AppLocalizations.current.changeDevice} / ${AppLocalizations.current.reactivateCert}",
                            style: TextStyle(
                              color: HexColor(AppConfig.colorPrimaryBtn),
                              fontSize: 16.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        onTap: () => widget.onChangeDevice(),
                      ),
                      SizedBox(height: 15),
                      BaseText(
                        AppLocalizations
                            .current.waitingConfirmBySmartCAAppSubtitle,
                        color: const Color(0xff08285C),
                        textAlign: TextAlign.justify,
                        fontSize: 16.5,
                      ),
                      if (Platform.isIOS)
                        InkWell(
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: HexColor(AppConfig.colorPrimaryBtn),
                              ),
                            ),
                            margin: EdgeInsets.only(top: 6),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: Text(
                              AppLocalizations.current.openVNPTSmartApp,
                              style: TextStyle(
                                color: HexColor(AppConfig.colorPrimaryBtn),
                                fontSize: 16.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          onTap: () => widget.openSmartCAApp(),
                        ),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: BaseText(
                          AppLocalizations.current.doNotCloseApp,
                          color: const Color(0xff08285C),
                          textAlign: TextAlign.start,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (widget.transactionModel != null) ...[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: BaseText(
                            AppLocalizations.current.remainTimeToSign,
                            color: const Color(0xff08285C),
                            textAlign: TextAlign.left,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 130,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: HexColor("#FFF5EC"),
                            border:
                                Border.all(width: 1, color: Color(0xffFF9843)),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: TransactionClockCountDown(
                            key: UniqueKey(),
                            isShowResult: true,
                            model: widget.transactionModel!,
                            onComplete: (tran) =>
                                Get.until((route) => route.isFirst),
                            countDownController: CountDownController(),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ],
                  ),
                )),
                const BottomContact(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
