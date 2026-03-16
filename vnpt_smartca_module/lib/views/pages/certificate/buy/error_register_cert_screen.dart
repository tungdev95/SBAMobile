// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/app_config.dart';
import '../../../../gen/assets.gen.dart';
import '../../../controller/app_controller.dart';
import '../../../controller/buy_certificate_controller.dart';
import '../../../i18n/generated_locales/l10n.dart';
import '../../../utils/common.dart';
import '../../../widgets/widget.dart';

class ErrorRegisterCertScreen extends StatelessWidget {
  String title;
  ErrorRegisterCertScreen({super.key, required this.title});

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
      child: BaseScreen(
        hiddenIconBack: false,
        hideAppBar: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Assets.images.icErrorCert.image(width: 220),
                  SizedBox(height: 6),
                  BaseText(
                    title,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    color: const Color(0xff08285C),
                  ),
                  SizedBox(height: 6),
                  BaseText(
                    AppLocalizations.current.contactHotline,
                    textAlign: TextAlign.center,
                    color: const Color(0xff5768A5),
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AppButtonWidget(
                      onTap: Common.callHotline,
                      label:
                          "${AppLocalizations.current.callNow} ${AppConfig.hotline}",
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
