// ignore_for_file: prefer_const_constructors

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../core/models/response/certificate_model.dart';
import '../../controller/app_controller.dart';
import '../../i18n/generated_locales/l10n.dart';
import '../../widgets/base_text.dart';
import '../../../views/controller/certificate_controller.dart';

class CustomListViewCert extends StatelessWidget {
  final List<CertificateModel> data;
  final Widget Function(CertificateModel) itemBuilder;

  final appController = Get.find<AppController>();
  late List<CertificateModel> notActivated = [];
  late List<CertificateModel> currentDevice = [];
  late List<CertificateModel> anotherDevice = [];
  final certController = Get.find<CertificateController>();

  CustomListViewCert(
      {super.key, required this.data, required this.itemBuilder}) {
    final deviceInfor = appController.deviceInfo.value;
    notActivated.addAll(data.where((element) =>
        element.device?.deviceID == null || element.device?.deviceID == ""));

    currentDevice.addAll(data
        .where((element) => element.device?.deviceID == deviceInfor?.deviceId));

    anotherDevice.addAll(data.where((element) =>
        element.device?.deviceID != null &&
        element.device?.deviceID != "" &&
        element.device?.deviceID != deviceInfor?.deviceId));
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   certController.isCheckCertHide();
    // });
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (notActivated.isNotEmpty) SizedBox(height: 14),
          ...notActivated.map((e) => itemBuilder(e).marginOnly(bottom: 14)),
          if (currentDevice.isNotEmpty) ...[
            if (anotherDevice.isNotEmpty)
              Container(
                width: Get.width,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                margin: EdgeInsets.only(top: 16, bottom: 10),
                decoration: BoxDecoration(
                  color: Color(0x1A414141),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  AppLocalizations.current.activateOnThisDevice,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color(0xff1F70F2)),
                ),
              ),
            ...currentDevice.map((e) => itemBuilder(e).marginOnly(bottom: 14)),
          ],
          if (anotherDevice.isNotEmpty) ...[
            Container(
              width: Get.width,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              margin: EdgeInsets.only(top: 16, bottom: 10),
              decoration: BoxDecoration(
                color: Color(0x1A414141),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                AppLocalizations.current.activateOnAnotherDevice,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color(0xff1F70F2)),
              ),
            ),
            ...anotherDevice.map((e) => itemBuilder(e).marginOnly(bottom: 14)),
          ],
          if (certController.isHaveCertHide.value)
            InkWell(
              onTap: () {
                certController.isHideShowCert();
              },
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BaseText(
                      certController.isShowViewMore.value
                          ? AppLocalizations.current.viewMoreCertHide
                          : AppLocalizations.current.hideCertHide,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: const Color(0xff0D75D6),
                    ),
                    Icon(
                        !certController.isShowViewMore.value
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Color(0xff1F70F2))
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
