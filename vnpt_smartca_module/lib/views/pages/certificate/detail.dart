// ignore_for_file: prefer_const_constructors

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../configs/app_config.dart';
import '../../../core/models/response/certificate_model.dart';
import '../../../gen/assets.gen.dart';
import '../../controller/certificate_controller.dart';
import '../../i18n/generated_locales/l10n.dart';
import '../../utils/datetime_format.dart';
import '../../utils/enums.dart';
import '../../widgets/base_screen.dart';

import '../../controller/auth_controller.dart';
import '../../widgets/base_loading.dart';
import '../../widgets/base_text.dart';
import '../system_link/list/index.dart';
import 'buy/order_detail_screen.dart';
import 'change_name.dart';

class CertificateDetail extends StatelessWidget {
  final String title;
  final CertificateModel certificateModel;
  final CertificateController controller = Get.put(CertificateController());
  final authController = Get.find<AuthController>();

  CertificateDetail(
      {super.key, required this.title, required this.certificateModel});

  @override
  Widget build(BuildContext context) {
    controller.currentName.value = (certificateModel.refName ??
            authController.currentUser.value!.displayName) ??
        "";
    controller.orderCertModel.listen((model) async {
      if (model != null) {
        Get.to(() => OrderDetailScreen(
              orderCertModel: model,
              // isCompleted: model.statusIsDone,
            ));
      }
    });
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: BaseScreen(
        loadingWidget: BaseLoading<CertificateController>(),
        title: title,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BaseHeader(title: title),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    top: 14, left: 8, right: 8, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Text(
                        authController.currentUser.value?.accType == 1
                            ? AppLocalizations.current.businessOrganization
                            : AppLocalizations.current.ctsPersonal,
                        style: const TextStyle(
                            color: Color(0xff08285C),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.only(top: 9),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            return _CertInfoItem(
                              label: AppLocalizations.current.nameForCTS,
                              value: controller.currentName.value,
                              isActionImage: true,
                              actionData: Assets.images.icEdit.path,
                              actionOnTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => ChangeNameWidget(
                                          currentName:
                                              controller.currentName.value,
                                          certId: certificateModel.id,
                                        ));
                              },
                            );
                          }),
                          _CertInfoItem(
                            label: AppLocalizations.current.subject,
                            value:
                                authController.currentUser.value!.displayName ??
                                    "",
                            horizontalDisplay: true,
                          ),
                          _CertInfoItem(
                            label: AppLocalizations.current.citizenIdLabel,
                            value: authController.currentUser.value!.uid,
                            horizontalDisplay: true,
                          ),
                          _CertInfoItem(
                            label: AppLocalizations.current.issuer,
                            value: "VNPT SmartCA",
                            horizontalDisplay: true,
                          ),
                          _CertInfoItem(
                            label: AppLocalizations.current.validity,
                            value: (certificateModel.validFrom == null ||
                                    certificateModel.validTo == null)
                                ? ""
                                : "${DatetimeFormat().formatDate(certificateModel.validFrom.toString())} - ${DatetimeFormat().formatDate(certificateModel.validTo.toString())}",
                            horizontalDisplay: true,
                          ),
                          _CertInfoItem(
                            label: AppLocalizations.current.status,
                            value: certificateModel.statusDesc,
                            valueColor: const Color(0xff17A514),
                            horizontalDisplay: true,
                          ),
                          _CertInfoItem(
                            label: AppLocalizations.current.package_information,
                            value: certificateModel.certProfile?.pricingName ??
                                certificateModel.orderInfo?.pricingName ??
                                "",
                            horizontalDisplay: false,
                            // valueColor: Color(0xff0D75D6),
                          ),
                          _CertInfoItem(
                            label: AppLocalizations.current.serialNumber,
                            value: certificateModel.serial ?? "",
                            isActionImage: true,
                            actionData: Assets.images.icCopy.path,
                            actionOnTap: () {
                              FlutterClipboard.copy(
                                  certificateModel.serial ?? "");
                            },
                          ),
                          Visibility(
                            visible: certificateModel.getSignTypeEnum() ==
                                SignType.turn,
                            child: _CertInfoItem(
                              label:
                                  AppLocalizations.current.numberOfUnusedTurns,
                              value:
                                  certificateModel.getSignNumber().toString(),
                              isActionImage: false,
                              // actionData: Assets.images.icCopy.path,
                              actionOnTap: () {
                                // FlutterClipboard.copy(
                                //     certificateModel.serial ?? "");
                              },
                            ),
                          ),
                          if (certificateModel.device?.deviceID != null)
                            _CertInfoItem(
                                label: AppLocalizations
                                    .current.deviceUsingThisCert,
                                value:
                                    "${certificateModel.device!.branch?.capitalizeFirst}: ${certificateModel.device!.deviceName}"
                                    "\n${certificateModel.device!.osName?.capitalizeFirst} ${certificateModel.device!.osVersion}"
                                    "\n${AppLocalizations.current.deviceId}: ${certificateModel.device!.deviceID}",
                                isActionImage: false,
                                textAlign: TextAlign.left),
                          if (certificateModel.typeStatus ==
                                  StatusCertEnum.VALID ||
                              certificateModel.typeStatus ==
                                  StatusCertEnum.WAITING_SIGN_ACCEPTANCE ||
                              certificateModel.typeStatus ==
                                  StatusCertEnum.WAITING_SYNC_ACCEPTANCE)
                            Container(
                              margin: EdgeInsets.only(top: 14),
                              width: Get.width - 24,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6)),
                              child: InkWell(
                                onTap: () {
                                  if (certificateModel.serial != null) {
                                    controller.requestChangeDevice(
                                        id: certificateModel.id,
                                        serial: certificateModel.serial!);
                                  }
                                },
                                child: BaseText(
                                  "${AppLocalizations.current.changeDevice}/PIN/${AppLocalizations.current.reactivateCert}",
                                  textAlign: TextAlign.center,
                                  // height: 22/ 14,
                                  color: Color(0xff0D75D6),
                                  fontWeight: FontWeight.w500,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          SizedBox(height: 10),
                          Visibility(
                            visible:
                                certificateModel.certProfile?.isEseal() == true,
                            child: Container(
                              width: Get.width - 24,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6)),
                              child: InkWell(
                                onTap: () {
                                  Get.to(ListSystemLinkPage(
                                      idCert: certificateModel.id));
                                },
                                child: BaseText(
                                  AppLocalizations.current.listLinkSystem,
                                  // height: 22/ 14,
                                  color: Color(0xff0D75D6),
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      // Container(
                      //   margin: const EdgeInsets.only(top: 14),
                      //   // color: Colors.red,
                      //   child: Row(
                      //     children: [
                      //       InkWell(
                      //         onTap: () {
                      //           controller.hideCert(certificateModel.id);
                      //         },
                      //         child: Obx(() => controller.isTick.value
                      //             ? Assets.images.icTicked.image(
                      //                 width: 24, height: 24, fit: BoxFit.fill)
                      //             : Assets.images.icTick.image(
                      //                 width: 24, height: 24, fit: BoxFit.fill)),
                      //       ),
                      //       const SizedBox(
                      //         width: 10,
                      //       ),
                      //       Expanded(
                      //           child: Text(
                      //         AppLocalizations.current.hideCTSInListScreen,
                      //         style: const TextStyle(
                      //             color: Color(0xff08285C),
                      //             fontSize: 14,
                      //             fontStyle: FontStyle.italic,
                      //             // height: 22/ 14,
                      //             fontWeight: FontWeight.w400),
                      //       ))
                      //     ],
                      //   ),
                      // ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
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
                padding: EdgeInsets.symmetric(vertical: 12),
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
