// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/core/models/response/certificate_model.dart';
import 'package:vnpt_smartca_module/views/controller/buy_certificate_controller.dart';
import 'package:vnpt_smartca_module/views/controller/home_controller.dart';
import 'package:vnpt_smartca_module/views/pages/certificate/setup_pin_code/index.dart';
import '../../../widgets/base_screen.dart';

import '../../../../core/models/response/order_cert_model.dart';
import '../../../../gen/assets.gen.dart';
import '../../../controller/app_controller.dart';
import '../../../i18n/generated_locales/l10n.dart';
import '../../../widgets/app_button_widget.dart';
import '../../../widgets/base_text.dart';
import '../../../widgets/bottom_contact.dart';

class WaitingForAcceptCertScreen extends StatelessWidget {
  // final EkycResponseModel ekycResponseModel;

  final OrderCertModel orderCertModel;
  final String? title;

  const WaitingForAcceptCertScreen(
      {super.key, required this.orderCertModel, this.title});

  // final buyCertificateController = Get.put(BuyCertificateController());
  // final authController = Get.find<AuthController>();

  _backToHome(BuildContext context) async {
    final appController = Get.find<AppController>();
    final homeController = Get.find<HomeController>();

    await homeController.getCertificateListWaitingActive();
    final cert = homeController.listCertificate.value
        ?.firstWhere((element) => element.id == orderCertModel.credentialId);

    if (cert?.status == 2) {
      Get.to(() => SetupPinCodePage(
            certificateModel: CertificateModel(
              id: orderCertModel.credentialId!,
              status: 2,
              certProfile: cert != null
                  ? CertProfile(serviceType: cert.certProfile?.serviceType)
                  : null,
            ),
          ));
    } else {
      final controller = Get.find<BuyCertificateController>();
      controller.cancelLoop = false;
      appController.backToMainPage();
    }

    // Navigator.popUntil(context, (route) => route.isFirst);
  }

  _getTitle() {
    if (orderCertModel.getTypeEnum() == OrderType.newCert) {
      return AppLocalizations.current.waitingForAcceptCertTitle;
    } else if (orderCertModel.getTypeEnum() == OrderType.changeDevice) {
      return AppLocalizations.current.waitingForAcceptChangeDeviceTitle;
    } else if (orderCertModel.getTypeEnum() == OrderType.renewCert) {
      return AppLocalizations.current.waitingForAcceptExtendTitle;
    } else if (orderCertModel.getTypeEnum() == OrderType.changeInfo) {
      return AppLocalizations.current.waitingForAcceptChangeInfoTitle;
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _backToHome(context);
        return true;
      },
      child: BaseScreen(
        // loadingWidget: BaseLoading<BuyCertificateController>(),
        hideAppBar: false,
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 100, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Assets.images.icChoduyet.image(
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 10),
                    BaseText(
                      _getTitle(),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff08285C),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    BaseText(
                      AppLocalizations.current.waitingForAcceptCertDescription,
                      color: Color(0xff08285C),
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                    Spacer(),
                    AppButtonWidget(
                      label: AppLocalizations.current.iUnderstand,
                      doublePadding: 15,
                      onTap: () async {
                        await _backToHome(context);
                      },
                    ),
                    // SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            BottomContact(),
          ],
        ),
      ),
    );
  }
}
