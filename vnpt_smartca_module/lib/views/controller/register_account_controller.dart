import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/core/utils/enums.dart';
import 'package:vnpt_smartca_module/views/controller/buy_certificate_controller.dart';
import 'package:vnpt_smartca_module/views/pages/register_account/confirm_information/index.dart';
import '../../../configs/injector/injector.dart';
import '../../../core/models/app/exceptions.dart';
import '../../../data/repository/check_uid_repository.dart';
import '../../../views/controller/base_controler.dart';
import '../../../views/utils/exception_handler.dart';
import '../../../views/widgets/dialog/common_dialog.dart';

import '../../configs/app_config.dart';
import '../../core/models/request/ekyc_result_model.dart';
import '../../core/models/response/check_uid_response.dart';
import '../../core/models/response/token_model.dart';
import '../../core/services/device_info.dart';
import '../../core/services/secure_local_storage.dart';
import '../../core/utils/constants.dart';
import '../../data/network/auth_api.dart';
import '../../data/repository/authen_repository.dart';
import '../../gen/assets.gen.dart';
import '../i18n/generated_locales/l10n.dart';
import '../pages/register_account/otp_verify/index.dart';
import '../utils/common.dart';
import '../widgets/dialog_notification.dart';

enum TypeDocument { cccd, hc, mst }

class RegisterAccountController extends BaseController {
  AuthRemoteApi authenService = getIt<AuthRemoteApi>();
  final formKey = GlobalKey<FormBuilderState>();
  final checkUidRepository = getIt<CheckUidRepository>();
  final checkUidResponse = Rx<CheckUidResponse?>(null);
  final typeDocumentSelected = Rx<TypeDocument>(TypeDocument.cccd);
  final _deviceInfoService = getIt<DeviceInfoService>();
  final _authenRepository = getIt<AuthenRepository>();
  final _secureLocalDataSource = getIt<SecureLocalStorageService>();

  RxBool obscureTextPassword = true.obs;
  RxBool obscureTextRePassword = true.obs;
  String? token;

  final identifierTEC = Rx<TextEditingController>(TextEditingController());
  final passwordTEC = TextEditingController();
  final phoneTEC = TextEditingController();

  final controllerEkyc = Get.put(BuyCertificateController());

  List<String> listStrTypeCard = [
    AppLocalizations.current.citizenIdentification,
    AppLocalizations.current.passport,
    AppLocalizations.current.businessRegistrationCertificate,
  ];

  final continueEnable = Rx<bool?>(null);

  TextEditingController txtTypeCardController = TextEditingController();

  @override
  void onReady() {
    super.onReady();

    if (AppConfig.customerId != "") {
      identifierTEC.value.text = AppConfig.customerId;
    }
    if (AppConfig.customerPhone != "") {
      phoneTEC.text = AppConfig.customerPhone;
    }

    if (AppConfig.customerId != "" && AppConfig.customerPhone != "") {
      onFormSubmit();
    }
  }

  onFormSubmit() async {
    if (formKey.currentState!.saveAndValidate()) {
      final values = formKey.currentState!.value;
      final failureOrTokenModel = await _authenRepository.getAppAccessToken();
      TokenModel? token;
      failureOrTokenModel.fold(
        (failure) => {
          showErrorModal(exceptionHandler(failure)),
        },
        (result) async {
          token = result;
          if (token == null) {
            return false;
          }
          await _secureLocalDataSource.saveData(
              LOCAL_ACCESS_TOKEN_AUTH, token!.toJson());
          checkUid(values["identifier"], values["phone"],
              typeDocumentSelected.value.name);
        },
      );
    }
  }

  String? validateTypeCard(String? value) {
    if (GetUtils.isBlank(value) == true) {
      return AppLocalizations.current.certificate_package_validate_input_error;
    } else if (!listStrTypeCard.contains(value)) {
      return AppLocalizations.current.pleaseSelectDataInList;
    }
    return null;
  }

  void checkUid(String identifier, String phone, String typeDocument) async {
    showLoading();
    try {
      final failureOrVerified =
          await checkUidRepository.checkUid(identifier, phone, typeDocument);
      hideLoading();
      failureOrVerified.fold(
        (failure) => {
          showErrorModal(exceptionHandler(failure)),
        },
        (result) async {
          if (result.code == 60000) {
            // TAI KHOAN DA TON TAI
            Get.dialog(DialogNotification(
              content: AppLocalizations.current.accountRegisteredSuccessfully,
              titleBtnAccept: AppLocalizations.current.signIn,
              actionAccept: () {
                Get.back();
              },
            ));
          } else {
            var deviceInfo = await _deviceInfoService.getDeviceInfo();
            var checkUidModel = result.content;
            OcrResult ocrResult = OcrResult(
              id: checkUidModel?.uid ?? identifierTEC.value.text,
              name: checkUidModel?.fullName ?? "",
              originLocation: "",
              recentlyLocation: checkUidModel?.address?.streetName ?? "",
              issuePlace: checkUidModel?.noiCap ?? "",
              issueDate: checkUidModel?.ngayCap ?? "",
              gender: "",
              validDate: "",
              city: checkUidModel?.provinceName ?? "",
              district: checkUidModel?.districtName ?? "",
              ward: checkUidModel?.wardName ?? "",
              street: checkUidModel?.address?.streetName ?? "",
              cardType: "",
              cityId: checkUidModel?.address?.provinceId ?? "",
              districtId: checkUidModel?.address?.districtId ?? "",
              wardId: checkUidModel?.address?.wardId ?? "",
            );
            EkycResponseModel ekycResponseModel = EkycResponseModel(
              ekycCode: checkUidModel?.ekycCode ?? "",
              ekycExpiredTime: "",
              ocrResult: ocrResult,
              loaiGiayTo: txtTypeCardController.text ==
                      AppLocalizations.current.businessRegistrationCertificate
                  ? "mst"
                  : (txtTypeCardController.text ==
                          AppLocalizations.current.passport
                      ? "hc"
                      : "cccd"),
              password: passwordTEC.text,
              phone: AppConfig.customerPhone != ""
                  ? AppConfig.customerPhone
                  : phoneTEC.text,
              deviceId: deviceInfo.deviceId,
              email: checkUidModel?.email,
            );

            ekycResponseModel.uid =
                checkUidModel?.uid ?? identifierTEC.value.text;

            if (result.code == 0) {
              // TAI KHOAN MOI
              if (txtTypeCardController.text !=
                  AppLocalizations.current.citizenIdentification) {
                // SHOW POPUP HOTLINE
                Get.dialog(DialogNotification(
                  image: Assets.images.icDialogFail,
                  content: AppLocalizations.current
                      .registerAccountContactHotline(AppConfig.hotline),
                  titleBtnAccept: AppLocalizations.current.support,
                  actionAccept: () {
                    Common.callHotline;
                  },
                ));
              } else {
                try {
                  // token = await getAppAccessToken();
                  // if (token == null) {
                  //   return;
                  // }
                  final failureOrVerified =
                      await checkUidRepository.checkClientPermission();
                  failureOrVerified.fold(
                    (failure) => {
                      showErrorModal(exceptionHandler(failure)),
                    },
                    (resultPermission) async {
                      // => VERIFY OTP
                      if (resultPermission.content?.requireOTP ?? true) {
                        Get.to(
                          () => OTPVerifyPage(
                            ekycResponseModel: ekycResponseModel,
                            requiredEKYC:
                                resultPermission.content?.requireEkyc ?? true,
                          ),
                        );
                      } else {
                        if (resultPermission.content?.requireEkyc ?? true) {
                          controllerEkyc.isFlowRegister = true;
                          controllerEkyc.uid = ekycResponseModel.ocrResult.id;
                          controllerEkyc.eKycUserEnroll().then((value) {
                            debugPrint("result ekyc >>>>: $value");

                            if (value == VerifyInfoType.error3times) {
                              // back to login
                              Get.until((route) => route.isFirst);
                            } else if (value is EkycResponseModel) {
                              // ekyc success
                              value.password = ekycResponseModel.password;
                              value.loaiGiayTo = ekycResponseModel.loaiGiayTo;
                              value.phone = ekycResponseModel.phone;
                              value.deviceId = ekycResponseModel.deviceId;
                              // value.otp = "";
                              value.email = ekycResponseModel.email;
                              value.uid = ekycResponseModel.uid;
                              Get.to(() => ConfirmInformationPage(
                                    ekycResponseModel: value,
                                    fromEKYC: true,
                                  ));
                            } else if (value == null) {
                              Get.back();
                            }
                          });
                        } else {
                          Get.to(() => ConfirmInformationPage(
                              ekycResponseModel: ekycResponseModel));
                        }
                      }
                    },
                  );
                } catch (e, s) {
                  showErrorModal(
                      exceptionHandler(GenericException(error: e, stack: s)));
                }
              }
            } else {
              if (result.code == 60013) {
                // ERROR EKYC
                Get.dialog(DialogNotification(
                  image: Assets.images.icDialogFail,
                  content: AppLocalizations.current
                      .ekycErrorContactHotline(AppConfig.hotline),
                  titleBtnAccept: AppLocalizations.current.support,
                  actionAccept: () {
                    Common.callHotline;
                  },
                ));
              } else if (result.code == 60001) {
                // ERROR PHONE NUMBER NOT MATCH
                Get.dialog(DialogNotification(
                  image: Assets.images.icDialogFail,
                  title: AppLocalizations.current.phoneNumberIncorrect,
                  content: AppLocalizations.current.enterPhoneNumberForRegister,
                  titleBtnAccept: AppLocalizations.current.support,
                  actionAccept: () {
                    Common.callHotline;
                  },
                ));
              } else if (result.code == 60002 || result.code == 60003) {
                ekycResponseModel.registered3rd = true;
                if (result.content?.requiredOtp ?? true) {
                  Get.to(
                    () => OTPVerifyPage(
                      ekycResponseModel: ekycResponseModel,
                      requiredEKYC: result.content?.requiredEkyc ?? true,
                    ),
                  );
                } else {
                  if (result.content?.requiredEkyc ?? true) {
                    controllerEkyc.isFlowRegister = true;
                    controllerEkyc.uid = ekycResponseModel.ocrResult.id;
                    controllerEkyc.eKycUserEnroll().then((value) {
                      debugPrint("result ekyc >>>>: $value");

                      if (value == VerifyInfoType.error3times) {
                        // back to login
                        Get.until((route) => route.isFirst);
                      } else if (value is EkycResponseModel) {
                        // ekyc success
                        value.password = ekycResponseModel.password;
                        value.loaiGiayTo = ekycResponseModel.loaiGiayTo;
                        value.phone = ekycResponseModel.phone;
                        value.deviceId = ekycResponseModel.deviceId;
                        value.otp = "";
                        value.email = ekycResponseModel.email;
                        value.uid = ekycResponseModel.uid;
                        // value.ocrResult.cityId = ekycResponseModel.ocrResult.cityId;
                        // value.ocrResult.city = ekycResponseModel.ocrResult.city;
                        // value.ocrResult.district = ekycResponseModel.ocrResult.district;
                        // // value.ocrResult.districtId = ekycResponseModel.ocrResult.districtId;
                        // value.ocrResult.wardId = ekycResponseModel.ocrResult.wardId;
                        // value.ocrResult.ward = ekycResponseModel.ocrResult.ward;
                        // value.ocrResult.recentlyLocation = ekycResponseModel.ocrResult.recentlyLocation;
                        
                        Get.to(() => ConfirmInformationPage(
                              ekycResponseModel: value,
                              fromEKYC: true,
                            ));
                      } else if (value == null) {
                        Get.back();
                      }
                    });
                  } else {
                    Get.to(() => ConfirmInformationPage(
                        ekycResponseModel: ekycResponseModel));
                  }
                }
              }
            }
          }
        },
      );
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  Future<String> getAppAccessToken() async {
    var token = await authenService.getAppAccessToken();
    return token.accessToken;
  }

  checkEnableContinueButton() {
    continueEnable.value =
        formKey.currentState?.saveAndValidate(focusOnInvalid: false);
  }
}
