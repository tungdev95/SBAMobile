import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/app_controller.dart';
import '../../../controller/buy_certificate_controller.dart';
import '../../../widgets/base_screen.dart';

import '../../../widgets/base_text.dart';
import '../../../widgets/bottom_contact.dart';
import '../../../widgets/loading_circle_widget.dart';

class OrderProcessingScreen extends StatelessWidget {
  final String label;
  final String content;
  final bool hiddenIconBack;

  OrderProcessingScreen(
      {Key? key,
      required this.label,
      required this.content,
      this.hiddenIconBack = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final controller = Get.find<BuyCertificateController>();
        controller.cancelLoop = false;
        final appcontroller = Get.find<AppController>();
        await appcontroller.backToMainPage();

        return true;
      },
      // PopScope(
      // canPop: false,
      // onPopInvoked: (bool didPop) async {
      //   try {
      //     final controller = Get.find<BuyCertificateController>();
      //     controller.cancelLoop = false;
      //     final appcontroller = Get.find<AppController>();
      //     await appcontroller.backToMainPage();
      //   } catch (e) {
      //     print("PopScope");
      //     print(e);
      //     Get.until((route) => route.isFirst);
      //   }
      // },
      child: BaseScreen(
        hideAppBar: false,
        hiddenIconBack: hiddenIconBack,
        // title: AppLocalizations.current.verifyInformationAccount,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LoadingCircleWidget(sizeLoading: 120),
                    const SizedBox(height: 16),
                    BaseText(
                      label,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: const Color(0xff08285C),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    BaseText(
                      content,
                      color: const Color(0xff5768A5),
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            const BottomContact(),
          ],
        ),
      ),
    );
  }
}
