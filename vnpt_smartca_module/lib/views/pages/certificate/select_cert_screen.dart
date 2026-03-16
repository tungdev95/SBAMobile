// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/method_channel_handler.dart';
import 'package:vnpt_smartca_module/views/controller/app_controller.dart';
import 'package:vnpt_smartca_module/views/widgets/widget.dart';
import '../../../configs/app_config.dart';
import '../../../core/models/app/smartca_message_result.dart';
import '../../../core/models/response/certificate_model.dart';
import '../../../core/models/response/token_model.dart';
import '../../../gen/assets.gen.dart';
import '../../controller/auth_controller.dart';
import '../../controller/home_controller.dart';
import '../../i18n/generated_locales/l10n.dart';
import '../../utils/color.dart';
import '../../utils/datetime_format.dart';
import '../../utils/enums.dart';
import '../../widgets/app_refresh.dart';

import '../../../configs/injector/injector.dart';
import '../../../core/services/secure_local_storage.dart';
import '../../../core/services/user_info_on_device.dart';
import '../../../core/utils/constants.dart';
import '../../widgets/button_general.dart';
import '../../widgets/navigator_helper.dart';
import 'common_action.dart';
import 'detail.dart';
import 'setup_pin_code/index.dart';

class SelectCertScreen extends StatelessWidget {
  final bool isSystemLink;
  final bool isFromOverTime;
  final Function(String id, String? serial)? onCertSelected;

  SelectCertScreen(
      {super.key,
      this.isSystemLink = false,
      this.onCertSelected,
      this.isFromOverTime = false});

  final AppRefreshController appRefreshController = AppRefreshController();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.current.selectCertificate,
      hiddenIconBack: Get.find<AppController>().currentHostAppMethod.value ==
          MethodChannelNames.getAuthentication,
      body: Column(
        children: [
          isSystemLink ||
                  Get.find<AppController>().currentHostAppMethod.value ==
                      MethodChannelNames.getAuthentication
              ? SizedBox(height: 15)
              : isFromOverTime != true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 8),
                          child: BaseText(
                            AppLocalizations.current.changeDevicePurpose,
                            color: Color(0xff08285C),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: BaseText(
                            AppLocalizations.current.changeDeviceDescription,
                            color: const Color(0xff08285C),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(16),
                      child: BaseText(
                        AppLocalizations.current.timeExtensionDescription,
                        height: 24 / 14,
                        color: const Color(0xff08285C),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
          if (isFromOverTime == true)
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 14.5, fontWeight: FontWeight.bold, height: 1.5),
                  children: [
                    TextSpan(
                      text: "${AppLocalizations.current.certPackNoteLabel}: ",
                      style: TextStyle(color: const Color(0xff08285C)),
                    ),
                    TextSpan(
                      text: AppLocalizations.current.timeExtensionNote,
                      style: TextStyle(color: const Color(0xffD80027)),
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: AppRefresh<CertificateModel>(
              path: "/certcms/cert/list",
              getListData: (data) async {},
              fromMap: CertificateModel.fromMap,
              emptyWidget: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BaseText(
                      AppLocalizations.current.no_exist_cert_valid,
                      fontSize: 16,
                      textAlign: TextAlign.justify,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 10),
                    BaseText(
                      AppLocalizations.current.newOrExtend,
                      fontSize: 16,
                      textAlign: TextAlign.justify,
                      fontWeight: FontWeight.w500,
                    ),
                    ButtonGeneral(
                      borderColor: Colors.transparent,
                      backgroundColor: HexColor(AppConfig.colorPrimaryBtn),
                      title: AppLocalizations.current.Continue,
                      onCallBack: () {
                        try {
                          Get.back();

                          final homeController = Get.find<HomeController>();

                          var listCertWaitActive = homeController
                              .listCertificate.value
                              ?.where((element) {
                            return (element.typeStatus ==
                                    StatusCertEnum.WAITING_ASSIGNED_TO_SIGNER ||
                                element.typeStatus ==
                                    StatusCertEnum.WAITING_SIGN_ACCEPTANCE);
                          }).toList();

                          if (listCertWaitActive?.length == 1) {
                            final certificateModel = listCertWaitActive!.first;
                            if (certificateModel.isNeedAssignKey) {
                              final page = SetupPinCodePage(
                                  certificateModel: certificateModel);
                              Future.delayed(Duration(milliseconds: 500),
                                  () => Get.to(page));
                            } else {
                              CommonActionCertificate.goActiveCer(
                                  certificateModel,
                                  callBackGetTo: () {});
                            }
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    )
                  ],
                ),
              ),
              itemWidgetBuilder: (value, index) {
                if (isFromOverTime == true) {
                  if ((isSystemLink && value.certProfile?.isEseal() == true) ||
                      (!isSystemLink &&
                          value.identity?.source != 8 &&
                          (value.typeStatus == StatusCertEnum.VALID ||
                              value.typeStatus == StatusCertEnum.EXPIRED) &&
                          ((value.overTime ?? 0) > 0))) {
                    return _CertificateItemWidget(
                      certificateModel: value,
                      appRefreshController: appRefreshController,
                      onCertSelected: onCertSelected,
                    );
                  } else {
                    return const SizedBox();
                  }
                } else {
                  if ((isSystemLink && value.certProfile?.isEseal() == true) ||
                      (!isSystemLink &&
                          value.identity?.source != 8 &&
                          value.typeStatus == StatusCertEnum.VALID)) {
                    return _CertificateItemWidget(
                      certificateModel: value,
                      appRefreshController: appRefreshController,
                      onCertSelected: onCertSelected,
                    );
                  } else {
                    return const SizedBox();
                  }
                }
              },
              filter: (value) {
                return value.typeStatus == StatusCertEnum.VALID;
              },
              params: {"FieldName": "createdDate", "IsDesc": true},
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
  final Function(String id, String? serial)? onCertSelected;

  _CertificateItemWidget(
      {required this.certificateModel,
      required this.appRefreshController,
      this.onCertSelected});

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

  _getTextStatus() {
    // if (status == _CertificateStatus.active) {
    //   return AppLocalizations.current.active;
    // } else if (status == _CertificateStatus.waiting) {
    //   return AppLocalizations.current.waitingForActivation;
    // } else {
    //   return AppLocalizations.current.expired;
    // }
    return certificateModel.statusDesc;
  }

  _getTextStatusColor() {
    if (certificateModel.status == 0) {
      return const Color(0xff4870BA);
    } else if (certificateModel.status == 1 ||
        certificateModel.status == 2 ||
        certificateModel.status == 3 ||
        certificateModel.status == 7) {
      return const Color(0xffFF9900);
    } else if (certificateModel.status == 4) {
      return const Color(0xffE51F1F);
    } else {
      return const Color(0xffFF9900);
    }

    // if (status == _CertificateStatus.active) {
    //   return const Color(0xff4870BA);
    // } else if (status == _CertificateStatus.waiting) {
    //   return const Color(0xffFF9900);
    // } else {
    //   return const Color(0xffE51F1F);
    // }
  }

  _refreshListCert() async {
    appRefreshController.listHide =
        await secureLocalDataSource.getLastData(HIDE_CERT_LIST);
    appRefreshController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return InkWell(
      onTap: () async {
        //sửa đây
        if (onCertSelected == null) {
          var appController = Get.find<AppController>();
          if (appController.currentHostAppMethod.value ==
              MethodChannelNames.getAuthentication) {
            final methodChannelHandler = getIt<MethodChannelHandler>();
            final tokenString = await getIt<SecureLocalStorageService>()
                .getLastData(LOCAL_ACCESS_TOKEN_AUTH);
            if (tokenString != null && tokenString.isNotEmpty) {
              TokenModel token = TokenModel.fromJson(tokenString);
              SmartCaResult data = SmartCaResult(
                  ResultCode.SUCCESS_CODE,
                  ResultCodeDesc.SUCCESS,
                  jsonEncode({
                    'accessToken': token.accessToken,
                    'credentialId': certificateModel.id,
                    'serial': certificateModel.serial,
                  }));

              methodChannelHandler.send(
                method: MethodChannelNames.getAuthenticationResult,
                data: data,
              );
              NavigatorHandler.closeSDK();
            }
            return;
          }

          Get.to(
            () => CertificateDetail(
              title: AppLocalizations.current.certDetail,
              certificateModel: certificateModel,
            ),
          )?.then((value) async {
            _refreshListCert();
          });
        } else {
          onCertSelected!(certificateModel.id, certificateModel.serial);
        }
        // if (certificateModel.isWaitingActive) {
        //   CommonActionCertificate.goActiveCer(certificateModel);
        // } else {
        //   Get.to(
        //         () => CertificateDetail(
        //       title: controller.fullName.value,
        //       certificateModel: certificateModel,
        //     ),
        //   )?.then((value) async {
        //     appRefreshController.listHide = await secureLocalDataSource.getLastData(HIDE_CERT_LIST);
        //     appRefreshController.refresh();
        //   });
        // }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          image: DecorationImage(
              image:
                  AssetImage(_getBackgroundImage(), package: AppConfig.package),
              fit: BoxFit.cover),
          // borderRadius: BorderRadius.circular(radius)
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.images.icSignatureBackground.path),
                fit: BoxFit.cover),
            // borderRadius: BorderRadius.circular(radius)
          ),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
                    fontWeight: FontWeight.w600,
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                  )),
                  Container(
                    width: 100,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: BaseText(
                      _getTextStatus(),
                      color: _getTextStatusColor(),
                      fontSize: 11,
                      // height: 20 / 11,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(children: [
                BaseText(
                  AppLocalizations.current.validity,
                  color: Colors.white,
                  fontSize: 12.5,
                  height: 24 / 12,
                ),
                SizedBox(width: 14),
                BaseText(
                  (certificateModel.validFrom == null ||
                          certificateModel.validTo == null)
                      ? ""
                      : "${DatetimeFormat().formatDate(certificateModel.validFrom.toString())} - ${DatetimeFormat().formatDate(certificateModel.validTo.toString())}",
                  color: Colors.white,
                  height: 24 / 14,
                  fontWeight: FontWeight.w700,
                )
              ]),
              SizedBox(height: 4),
              BaseText(
                AppLocalizations.current.serialNumber,
                color: Colors.white,
                fontSize: 12.5,
                height: 24 / 12,
              ),
              BaseText(
                "${certificateModel.serial}",
                color: Colors.white,
                height: 24 / 14,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 4),
              Row(children: [
                SizedBox(
                  width: 52,
                  child: BaseText(
                    AppLocalizations.current.package,
                    color: Colors.white,
                    fontSize: 12.5,
                  ),
                ),
                Expanded(
                    child: BaseText(
                  certificateModel.certProfile?.pricingName ??
                      certificateModel.orderInfo?.pricingName ??
                      "",
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.5,
                  textOverflow: TextOverflow.visible,
                  maxLines: 2,
                  textAlign: TextAlign.justify,
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
