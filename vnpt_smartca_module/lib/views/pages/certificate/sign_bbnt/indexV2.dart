// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/core/models/response/certificate_model.dart';
import 'package:vnpt_smartca_module/views/controller/auth_controller.dart';
import 'package:vnpt_smartca_module/views/controller/home_controller.dart';
import 'package:vnpt_smartca_module/views/controller/transaction_controller.dart';

import '../../../../configs/app_config.dart';
import '../../../../gen/assets.gen.dart';
import '../../../i18n/generated_locales/l10n.dart';
import '../../../utils/datetime_format.dart';
import '../../../widgets/widget.dart';

class ConfirmProvideCertView extends StatelessWidget {
  final CertificateModel certificateModel;

  ConfirmProvideCertView({super.key, required this.certificateModel});
  final homeController = Get.find<HomeController>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      loadingWidget: BaseLoading<TransactionController>(),
      colorBg: Colors.white,
      hiddenIconBack: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.images.extendCert.path,
              alignment: Alignment.center,
              height: 130,
              package: AppConfig.package,
            ),
            SizedBox(height: 14),
            BaseText(
              AppLocalizations.current.generateCertificateSuccess,
              color: Color(0xff0D75D6),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            SizedBox(height: 18),
            Align(
              alignment: Alignment.centerLeft,
              child: BaseText(
                AppLocalizations.current.titleCertInfo,
                textAlign: TextAlign.start,
                color: Color(0xff08285C),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: Get.width - 14 * 2,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Color(0xffC9CED7).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CertInfoItem(
                    label: AppLocalizations.current.serialNumber,
                    value: certificateModel.serial ?? "",
                    isActionImage: true,
                    actionData: Assets.images.icCopy.path,
                    actionOnTap: () {
                      FlutterClipboard.copy(certificateModel.serial ?? "");
                    },
                  ),
                  _CertInfoItem(
                    label: AppLocalizations.current.subject,
                    value: certificateModel.identity?.name ??
                        (authController.currentUser.value?.displayName ?? ""),
                    horizontalDisplay: false,
                  ),
                  Visibility(
                      visible: certificateModel.isPersonalInOrgCert(),
                      child: Column(
                        children: [
                          _CertInfoItem(
                            label: AppLocalizations.current.nameBusiness,
                            value: certificateModel.getOrgName(),
                            horizontalDisplay: false,
                          ),
                          _CertInfoItem(
                            label: AppLocalizations.current.positionInOrg,
                            value: certificateModel.getPositionInOrgName(),
                            horizontalDisplay: false,
                          ),
                          _CertInfoItem(
                            label: AppLocalizations.current.unitInOrg,
                            value: certificateModel.getUnitInOrgName(),
                            horizontalDisplay: false,
                          )
                        ],
                      )),
                  _CertInfoItem(
                    label: AppLocalizations.current.citizenIdLabel,
                    value: authController.currentUser.value?.uid
                            .split("_")
                            .first
                            .toUpperCase() ??
                        "",
                    horizontalDisplay: false,
                  ),
                  _CertInfoItem(
                    label: AppLocalizations.current.address,
                    value: certificateModel.getTenTinh(),
                    horizontalDisplay: false,
                  ),
                  _CertInfoItem(
                    label: AppLocalizations.current.validity,
                    value: (certificateModel.validFrom == null ||
                            certificateModel.validTo == null)
                        ? ""
                        : "${DatetimeFormat().formatDate(certificateModel.validFrom ?? "")} - ${DatetimeFormat().formatDateHour(certificateModel.validTo ?? "")}",
                    horizontalDisplay: false,
                  ),
                ],
              ),
            ),
            SizedBox(height: 140),
          ],
        ),
      ),
      bottomSheet: Container(
          height: 140,
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
                      homeController.transactionRequestController
                              .checkConfirmAcceptance.value =
                          !homeController.transactionRequestController
                              .checkConfirmAcceptance.value;
                    },
                    child: Row(
                      children: [
                        (homeController.transactionRequestController
                                    .checkConfirmAcceptance.value
                                ? Assets.images.icCheckbox
                                : Assets.images.icUncheck)
                            .image(
                          width: 25,
                          height: 25,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: BaseText(
                            AppLocalizations.current.ConfirmGenCert_Content,
                            color: Color(0xff0D75D6),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )),
                SizedBox(height: 18),
                AppButtonWidget(
                  label: AppLocalizations.current.confirm,
                  backgroundColor: homeController.transactionRequestController
                          .checkConfirmAcceptance.value
                      ? Color(0xff0D75D6)
                      : Colors.grey,
                  onTap: () async {
                    if (homeController.transactionRequestController
                        .checkConfirmAcceptance.value) {
                      homeController.transactionRequestController
                          .confirmApproveCert(certificateModel.serial ?? "");
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}

class _CertInfoItem extends StatelessWidget {
  final String label;
  final String value;
  final String actionData;
  final Color valueColor;
  final bool isActionImage;
  final bool horizontalDisplay;
  final Function? actionOnTap;
  final TextAlign? textAlign;

  const _CertInfoItem({
    required this.label,
    this.value = "",
    this.actionData = "",
    this.isActionImage = true,
    this.actionOnTap,
    this.horizontalDisplay = false,
    this.valueColor = const Color(0xff08285C),
    this.textAlign,
  });

  renderContent() {
    return [
      Text(
        label,
        style: const TextStyle(
          color: Color.fromARGB(255, 95, 120, 161),
          fontSize: 14.5,
          height: 22 / 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      const SizedBox(width: 8),
      actionData.isEmpty
          ? horizontalDisplay == true
              ? Expanded(
                  child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: valueColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    height: 22 / 14,
                  ),
                ))
              : Text(
                  value,
                  textAlign: textAlign ?? TextAlign.right,
                  style: TextStyle(
                    color: valueColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    height: 22 / 14,
                  ),
                )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      color: valueColor,
                      fontWeight: FontWeight.w600,
                      height: 22 / 14,
                      fontSize: 15,
                    ),
                  ),
                ),
                actionData.isEmpty
                    ? const SizedBox()
                    : InkWell(
                        onTap: () {
                          actionOnTap?.call();
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 12),
                          child: isActionImage
                              ? Image.asset(
                                  actionData,
                                  width: 22,
                                  height: 22,
                                  fit: BoxFit.fill,
                                  package: AppConfig.package,
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    actionData,
                                    style: const TextStyle(
                                      color: Color(0xff0D75D6),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                        ),
                      )
              ],
            ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return horizontalDisplay
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [...renderContent()],
                ),
              ),
              Divider(height: 1, color: const Color(0xffEBEBF0)),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 6),
              ...renderContent(),
              Container(
                height: 1,
                color: const Color(0xffEBEBF0),
                margin: const EdgeInsets.only(top: 8, bottom: 8),
              ),
            ],
          );
  }
}
