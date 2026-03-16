import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/configs/app_config.dart';
import 'package:vnpt_smartca_module/views/pages/notify/extend_cert_detail.dart';
import '../../../controller/extend_certificate_controller.dart';
import '../../../widgets/app_refresh.dart';
import '../../../widgets/base_loading.dart';

import '../../../../configs/injector/injector.dart';
import '../../../utils/datetime_format.dart';
import '../../../../core/models/response/certificate_model.dart';
import '../../../../core/services/secure_local_storage.dart';
import '../../../../core/services/user_info_on_device.dart';
import '../../../../gen/assets.gen.dart';
import '../../../controller/auth_controller.dart';
import '../../../i18n/generated_locales/l10n.dart';
import '../../../utils/enums.dart';
import '../../../widgets/base_screen.dart';
import '../../../widgets/base_text.dart';
import '../../../widgets/dialog_notification.dart';

class SelectCertToExtendScreen extends StatelessWidget {
  final AppRefreshController appRefreshController = AppRefreshController();

  // final ExtendCertificateController extendCertificateController = Get.put(ExtendCertificateController());

  SelectCertToExtendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.current.selectCertificate,
      loadingWidget: const BaseLoading<ExtendCertificateController>(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: BaseText(
              AppLocalizations.current.select_cert_to_extend,
              color: const Color(0xff08285C),
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: AppRefresh<CertificateModel>(
              path: "/certcms/cert/list",
              keyController: "/ssa/sic/list_certificate_select_to_extend",
              fromMap: CertificateModel.fromMap,
              itemWidgetBuilder: (value, index) {
                if (value.identity?.source != 8 &&
                    (value.typeStatus == StatusCertEnum.VALID ||
                        value.typeStatus == StatusCertEnum.EXPIRED)) {
                  return _CertificateItemWidget(
                    certificateModel: value,
                    appRefreshController: appRefreshController,
                  );
                } else {
                  return const SizedBox();
                }
              },
              sort: (CertificateModel c1, CertificateModel c2) {
                return c1.getExpiresDay().compareTo(c2.getExpiresDay());
              },
              filter: (value) {
                return (value.typeStatus == StatusCertEnum.VALID ||
                    value.typeStatus == StatusCertEnum.EXPIRED);
              },
              params: const {"FieldName": "createdDate", "IsDesc": true},
              // appRefreshController: appRefreshController,
              // isShowViewMore: true,
              isLoadMore: false,
              itemSpace: 20,
              listPadding:
                  const EdgeInsets.only(bottom: 16, left: 16, right: 16),
              // wrapMargin: const EdgeInsets.only(top: 16),
            ),
          )
        ],
      ),
    );
  }
}

class _CertificateItemWidget extends StatelessWidget {
  // final _CertificateStatus status;
  // final String name;
  // final String dueDate;
  // final String serialNumber;

  final CertificateModel certificateModel;
  final AppRefreshController appRefreshController;

  _CertificateItemWidget(
      {required this.certificateModel, required this.appRefreshController});

  final secureLocalDataSource = getIt<SecureLocalStorageService>();
  final userInfoOnDeviceService = getIt<UserInfoOnDeviceService>();

  _getBackgroundImage() {
    if (certificateModel.status == 0) {
      return Assets.images.icCertificateBackgroundBlue.path;
    } else if (certificateModel.status == 1 ||
        certificateModel.status == 2 ||
        certificateModel.status == 3 ||
        certificateModel.status == 7) {
      return Assets.images.icCertificateBackgroundYellow.path;
    } else if (certificateModel.status == 4) {
      return Assets.images.icCertificateBackgroundRed.path;
    } else {
      return Assets.images.icCertificateBackgroundYellow.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return InkWell(
      onTap: () async {
        //nếu subjectDN có O, OU thì cert đó là loại CN trong DN
        // if (certificateModel.subjectDN?.contains("O=") == true ||
        //     certificateModel.subjectDN?.contains("OU=") == true) {
        //   Get.dialog(
        //     DialogNotification(
        //       content: AppLocalizations.current
        //           .notice_cert_action_for_business_account(AppLocalizations
        //               .current.extend
        //               .toLowerCase()
        //               .replaceAll("\n", " ")),
        //       onlyActionAccept: false,
        //       contentAlign: TextAlign.justify,
        //       titleBtnAccept: AppLocalizations.current.send,
        //       titleBtnCancel: AppLocalizations.current.close,
        //       actionCancel: () {
        //         // todo
        //       },
        //       actionAccept: () {
        //         // todo
        //       },
        //     ),
        //   );
        //   return;
        // }
        if (!certificateModel.isPersonalCert()) {
          Get.to(
              () => ExtendCertDetailNotify(certificateModel: certificateModel));
          return;
        }
        ExtendCertificateController extendCertificateController =
            Get.find<ExtendCertificateController>();
        extendCertificateController.handleCert(certificateModel);
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image:
                  AssetImage(_getBackgroundImage(), package: AppConfig.package),
              fit: BoxFit.fill),
          // borderRadius: BorderRadius.circular(radius)
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.images.icSignatureBackground.path,
                    package: AppConfig.package),
                fit: BoxFit.fill),
            // borderRadius: BorderRadius.circular(radius)
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: BaseText(
                    certificateModel.refName ??
                        (certificateModel.identity?.name ??
                            controller.currentUser.value?.displayName),
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                  )),
                  Container(
                    // width: 100,
                    margin: const EdgeInsets.only(left: 4),
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                    decoration: BoxDecoration(
                        color: const Color(0xffFCE9E9),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xffE51F1F))),
                    alignment: Alignment.center,
                    child: BaseText(
                      certificateModel.typeStatus == StatusCertEnum.EXPIRED
                          ? AppLocalizations.current.expired
                          : AppLocalizations.current.expire_in_day(
                              certificateModel.getExpiresDay() ?? 0),
                      color: const Color(0xffE51F1F),
                      fontSize: 11.5,
                      // height: 20 / 11,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  BaseText(
                    AppLocalizations.current.validity,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: BaseText(
                      (certificateModel.validFrom == null ||
                              certificateModel.validTo == null)
                          ? ""
                          : "${DatetimeFormat().formatDate(certificateModel.validFrom.toString())} - ${DatetimeFormat().formatDate(certificateModel.validTo.toString())}",
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              BaseText(
                AppLocalizations.current.serialNumber,
                color: Colors.white,
                fontSize: 12,
              ),
              BaseText(
                certificateModel.serial ?? "",
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 6),
              Row(children: [
                BaseText(
                  AppLocalizations.current.package,
                  color: Colors.white,
                  fontSize: 12.5,
                ),
                SizedBox(width: 10),
                Expanded(
                    child: BaseText(
                  certificateModel.certProfile?.pricingName ??
                      certificateModel.orderInfo?.pricingName ??
                      "",
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                  textOverflow: TextOverflow.ellipsis,
                ))
              ]),
              Row(
                children: [
                  Expanded(child: Container()),
                  Assets.images.icArrowRight.image(
                      width: 16,
                      height: 16,
                      fit: BoxFit.fill,
                      color: Colors.white)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
