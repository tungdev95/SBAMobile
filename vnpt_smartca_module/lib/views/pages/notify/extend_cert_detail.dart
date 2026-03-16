// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/views/controller/auth_controller.dart';
import 'package:vnpt_smartca_module/views/controller/home_controller.dart';

import '../../../configs/app_config.dart';
import '../../../core/models/response/certificate_model.dart';
import '../../../gen/assets.gen.dart';
import '../../controller/extend_certificate_controller.dart';
import '../../i18n/generated_locales/l10n.dart';
import '../../utils/common.dart';
import '../../utils/datetime_format.dart';
import '../../utils/enums.dart';
import '../../widgets/widget.dart';

class ExtendCertDetailNotify extends StatelessWidget {
  final CertificateModel certificateModel;

  ExtendCertDetailNotify({super.key, required this.certificateModel});
  final homeController = Get.find<HomeController>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final isIndividualCert = certificateModel.isPersonalCert();

    final datetimeStr = DatetimeFormat()
        .formatDateHour(certificateModel.validTo.toString())
        .split(" ");

    final message = isIndividualCert == true
        ? AppLocalizations.current.individualExtendCertMess
        : AppLocalizations.current.enterpriseExtendCertMess;

    return BaseScreen(
      colorBg: Colors.white,
      customAppBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.close,
            size: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.images.extendCert.path,
              alignment: Alignment.center,
              height: 120,
              package: AppConfig.package,
            ),
            SizedBox(height: 14),
            BaseText(
              certificateModel.typeStatus != StatusCertEnum.EXPIRED
                  ? AppLocalizations.current.extendCertDetailNotify1
                  : AppLocalizations.current.extendCertDetailNotify2,
              color: Color(0xff08285C),
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            SizedBox(height: 14),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 15,
                  height: 1.35,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(text: message.split("__")[0]),
                  TextSpan(
                      text: certificateModel.certProfile?.pricingName ?? "",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: message.split("__")[1]),
                  TextSpan(
                      text: certificateModel.subjectCN ?? "",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: message.split("__")[2]),
                  TextSpan(
                    text: certificateModel.typeStatus != StatusCertEnum.EXPIRED
                        ? AppLocalizations.current.sap
                        : AppLocalizations.current.da,
                  ),
                  TextSpan(text: message.split("__")[3]),
                ],
              ),
            ),
            SizedBox(height: 25),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                  color: Color(0xffFCE9E9),
                  border: Border.all(color: Color(0xffE51F1F), width: 1),
                  borderRadius: BorderRadius.circular(50)),
              child: BaseText(
                AppLocalizations.current.expire_in(
                    "${datetimeStr[1]} ${AppLocalizations.current.day} ${datetimeStr[0]}"),
                color: Color(0xffE51F1F),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 25),
            Align(
              alignment: Alignment.centerLeft,
              child: BaseText(
                AppLocalizations.current.titleCertInfo,
                textAlign: TextAlign.start,
                color: Color(0xff08285C),
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: Get.width - 14 * 2,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Color(0xffC9CED7).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 0),
                    child: Row(
                      children: [
                        BaseText(
                          "${AppLocalizations.current.citizenIdLabel}: ",
                          color: Color(0xff6079A0),
                          fontSize: 13.5,
                        ),
                        SizedBox(width: 6),
                        BaseText(
                          authController.currentUser.value?.uid
                                  .split("_")
                                  .first
                                  .toUpperCase() ??
                              "",
                          color: Color(0xff08285C),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText(
                        AppLocalizations.current.serialNumber,
                        color: Color(0xff6079A0),
                        fontSize: 13.5,
                      ),
                      InkWell(
                        enableFeedback: true,
                        onTap: () {
                          FlutterClipboard.copy(certificateModel.serial ?? "");
                        },
                        child: Image.asset(Assets.images.icCopy.path,
                            width: 18, package: AppConfig.package),
                      )
                    ],
                  ),
                  SizedBox(height: 4),
                  BaseText(
                    certificateModel.serial ?? "",
                    color: Color(0xff08285C),
                    fontWeight: FontWeight.w500,
                  ),
                  Divider(),
                  BaseText(
                    AppLocalizations.current.validity,
                    color: Color(0xff6079A0),
                    fontSize: 13.5,
                  ),
                  SizedBox(height: 4),
                  BaseText(
                    "${DatetimeFormat().formatDate(certificateModel.validFrom.toString())} - ${DatetimeFormat().formatDateHour(certificateModel.validTo.toString())}",
                    color: Color(0xff08285C),
                    fontWeight: FontWeight.w500,
                  ),
                  Divider(),
                  BaseText(
                    AppLocalizations.current.certDetail,
                    color: Color(0xff6079A0),
                    fontSize: 13.5,
                  ),
                  SizedBox(height: 6),
                  BaseText(
                    certificateModel.subjectDN ?? "",
                    color: Color(0xff08285C),
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            SizedBox(height: 75),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 75,
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
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
        child: AppButtonWidget(
          label: isIndividualCert == true
              ? AppLocalizations.current.extend
              : "${AppLocalizations.current.callNow} ${AppConfig.hotline}",
          doublePadding: 15,
          onTap: () {
            if (isIndividualCert == true) {
              final extendController = Get.put(ExtendCertificateController());
              // chuyen sang man chon goi cuoc luon
              extendController.handleCert(certificateModel);
            } else {
              Common.callHotline();
            }
          },
        ),
      ),
    );
  }
}
