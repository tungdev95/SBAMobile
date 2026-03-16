// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../gen/assets.gen.dart';
import '../../../controller/home_controller.dart';
import '../../../i18n/generated_locales/l10n.dart';
import '../../register_account/certificate_pack_screen.dart';
import '../../../widgets/app_button_widget.dart';
import '../../../widgets/base_text.dart';

class BuyCertWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Assets.images.imgRegisterAcocuntSuccess.image(
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 40),
          BaseText(
            AppLocalizations.current.successfulAccountRegistration,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xff08285C),
            height: 24 / 14,
          ),
          SizedBox(height: 10),
          BaseText(
            "${AppLocalizations.current.youDontHaveCert}. ${AppLocalizations.current.pleaseChooseRegisterCert}!",
            color: Color(0xff08285C),
            height: 24 / 14,
            textAlign: TextAlign.center,
          ),
          // Spacer(),
          SizedBox(height: 30),
          AppButtonWidget(
            label: AppLocalizations.current.registerCert,
            doublePadding: 15,
            onTap: () async {
              final homeController = Get.find<HomeController>();

              Get.to(() => CertificatePackScreen())?.then((value) {
                homeController.getCertificateListWaitingActive();
              });
            },
          ),
          // SizedBox(height: 20),
        ],
      ),
    );
  }
}
