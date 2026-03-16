// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/core/models/response/service_response.dart';
import 'package:vnpt_smartca_module/views/controller/app_controller.dart';
import 'package:vnpt_smartca_module/views/pages/account_information/verify_otp_update.dart';
import 'package:vnpt_smartca_module/views/pages/certificate/update_address.dart';
import 'package:vnpt_smartca_module/views/widgets/dialog_notification.dart';
import '../../../configs/injector/injector.dart';
import '../../../core/models/app/device_info.dart';
import '../../../core/models/app/exceptions.dart';
import '../../../core/models/app/purchase_cert_order_item_model.dart';
import '../../../core/models/request/ekyc_customer.dart';
import '../../../core/models/request/ekyc_result_model.dart';
import '../../../core/models/response/certificate_model.dart';
import '../../../core/models/response/order_cert_model.dart';
import '../../../core/models/response/profile_model.dart';
import '../../../core/services/device_info.dart';
import '../../../core/services/ekyc_service.dart';
import '../../../core/services/secure_local_storage.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/enums.dart';
import '../../../data/repository/order_cert_repository.dart';
import '../../../data/repository/user_repository.dart';
import '../../../gen/assets.gen.dart';
import '../../../views/controller/auth_controller.dart';
import '../../../views/controller/base_controler.dart';
import '../../../views/controller/econtract_controller.dart';
import '../../../views/i18n/generated_locales/l10n.dart';
import '../../../views/pages/certificate/buy/order_list_screen.dart';
import '../../../views/pages/certificate/buy/verify_info_error_screen.dart';
import '../../../views/pages/certificate/buy/verify_info_screen.dart';
import '../../../views/pages/certificate/extend/confirm_cert_pack_extend_screen.dart';
import '../../../views/pages/change_device/sign_bill.dart';
import '../pages/certificate/buy/error_register_cert_screen.dart';
import '../pages/certificate/generate_cer_key/index.dart';
import '../pages/certificate/setup_pin_code/index.dart';
import '../pages/register_account/certificate_pack_screen.dart';
import '../../../views/utils/enums.dart';
import '../../../views/utils/exception_handler.dart';
import '../../../views/widgets/dialog/common_dialog.dart';

import '../../core/models/response/user_address.dart';
import '../../core/services/user_info_on_device.dart';
import '../pages/certificate/buy/order_processing_screen.dart';
import '../pages/certificate/buy/verify_address_screen.dart';
import '../pages/certificate/buy/verify_otp_screen.dart';
import '../pages/certificate/buy/waiting_for_accept_cert_screen.dart';
import '../pages/register_account/confirm_cert_pack_screen.dart';
import 'home_controller.dart';

class BuyCertificateController extends BaseController {
  final orderCertRepository = getIt<OrderCertRepository>();
  final userRepository = getIt<UserRepository>();

  final secureStorage = getIt<SecureLocalStorageService>();
  final _deviceInfoService = getIt<DeviceInfoService>();

  // eContractController
  final eContractController = Get.put(ContractController(), permanent: true);
  final authController = Get.find<AuthController>();
  final appController = Get.find<AppController>();

  final userInfoOnDeviceService = getIt<UserInfoOnDeviceService>();

  var orderCertItems = List<OrderCertModel>.empty().obs;
  // final checkSuccessUpdate = Rx<SmartCAApiResponse?>(null);

  int ekycErrorCount = 0;
  String uid = "";
  bool isFlowRegister = false;

  bool cancelLoop = true;
  
  int loopCount = 1;

  Rx<UserAddress?> userAddress = Rx(null);
  final ekycService = EKYCService();

  final checkSuccessUpdate = Rx<SmartCAApiResponse?>(null);

  // Rx<OrderCertModel?> currentOrderCertModel = Rx(null);

  void getListOrder(List<CertificateModel> listCerts) async {
    showProgress();
    try {
      final failureOrVerified = await orderCertRepository.getOrderList();
      hideProgress();
      failureOrVerified.fold(
        (failure) => {
          showErrorModal(exceptionHandler(failure)),
        },
        (result) async {
          try {
            OrderCertListModel orderCertListModel =
                OrderCertListModel.fromMap(result.content);
            orderCertItems.value = orderCertListModel.items;

            // final authController = Get.find<AuthController>();

            // final accountFromVNeID =
            //     await secureStorage.getLastData(ACCOUNT_OPEN_FROM_VNEID);
            // final uid = authController.currentUser.value?.uid;

            if (orderCertListModel.items.isEmpty) {
              Get.to(() => CertificatePackScreen());
            } else {
              // thong bao
              showNotifyModal(
                AppLocalizations.current.certOrderIsExistingNotice,
                onlyActionCancel: false,
                titleBtnAccept: AppLocalizations.current.newRegistration,
                titleBtnCancel: AppLocalizations.current.continueProcessing,
                showFaq: false,
                actionCancel: () {
                  // todo chuyen sang man hinh danh sach don hang
                  Get.to(() => const OrderListScreen());
                },
                actionAccept: () {
                  // dang ky moi
                  // if (accountFromVNeID != null && accountFromVNeID == uid) {
                  Get.to(() => CertificatePackScreen());
                  // } else {
                  //   Get.to(ChooseMethodRegisterPage(listCert: listCerts));
                  // }
                },
              );
            }
          } catch (e) {
            e.printError();
          }
          // userStatusModel.value = result;
        },
      );
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  void getUserAddress(
      TextEditingController addressController,
      TextEditingController detailAddressController,
      OrderCertModel orderCertModel) async {
    showLoading();
    try {
      if (orderCertModel.address != null) {
        hideLoading();
        UserAddress userAddress =
            UserAddress.fromJson(orderCertModel.address!.toJson());
        userAddress.diaChi = orderCertModel.address!.address;
        // userAddress.updateName();
        localUpdateUserAddress(
            userAddress, addressController, detailAddressController);
      } else {
        final failureOrVerified = await orderCertRepository.getUserAddress();
        hideLoading();
        failureOrVerified.fold(
          (failure) => {
            showErrorModal(exceptionHandler(failure), callback: () {
              Get.back();
            }),
          },
          (result) async {
            debugPrint(result.toString());
            UserAddress userAddress = UserAddress.fromJson(result.content);
            localUpdateUserAddress(
                userAddress, addressController, detailAddressController);
          },
        );
      }
    } catch (e, s) {
      hideLoading();
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)),
          callback: () {
        Get.back();
      });
    }
  }

  void localUpdateUserAddress(
      UserAddress userAddress,
      TextEditingController addressController,
      TextEditingController detailAddressController) {
    this.userAddress.value = userAddress;
    String provinceStr = userAddress.provinceName;
    String wardsStr = userAddress.wardName;
    addressController.text = "$provinceStr, $wardsStr";

    String addressDetailStr = userAddress.streetName ?? "";
    detailAddressController.text = addressDetailStr;
  }

  void updateUserAddress(OrderCertModel orderCertModel, UserAddress userAddress,
      String email, String phone) async {
    showLoading();
    try {
      final failureOrVerified =
          await orderCertRepository.updateUserAddress(userAddress);
      hideLoading();
      failureOrVerified.fold(
        (failure) => {
          showErrorModal(exceptionHandler(failure)),
        },
        (result) async {
          debugPrint(result.toString());
          showLoading();
          try {
            // remove after server update
            final failureOrVerified2 = await userRepository.getProfile();
            hideLoading();
            failureOrVerified2.fold((l) => showErrorModal(exceptionHandler(l)),
                (r) {
              Get.back(
                  result: {"email": email, "phone": phone, "userAddress": userAddress});
            });
          } catch (e, s) {
            hideLoading();
            showErrorModal(
                exceptionHandler(GenericException(error: e, stack: s)));
          }
        },
      );
    } catch (e, s) {
      hideLoading();
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  void updateInfoUserAddress(UserAddress userAddress,
      {Function()? actionAccept}) async {
    showLoading();
    try {
      final failureOrVerified =
          await orderCertRepository.updateUserAddress(userAddress);
      hideLoading();
      failureOrVerified.fold(
        (failure) => {
          showErrorModal(exceptionHandler(failure)),
        },
        (result) async {
          debugPrint(result.toString());
          showLoading();
          try {
            // remove after server update
            final failureOrVerified2 = await userRepository.getProfile();
            hideLoading();
            failureOrVerified2.fold((l) => showErrorModal(exceptionHandler(l)),
                (r) {
              showSuccessModal(
                message: AppLocalizations.current.update_info_success,
                actionAccept: actionAccept ?? appController.backToMainPage,
                titleBtnAccept: AppLocalizations.current.goHomeTC,
              );
            });
          } catch (e, s) {
            hideLoading();
            showErrorModal(
                exceptionHandler(GenericException(error: e, stack: s)));
          }
        },
      );
    } catch (e, s) {
      hideLoading();
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  createOrder(String? pricingCode) async {
    showProgress();
    try {
      final accountFromVNeID =
          await secureStorage.getLastData(ACCOUNT_OPEN_FROM_VNEID);
      int source = AccountSources.sdksmartca;

      if (accountFromVNeID != null) {
        final authController = Get.find<AuthController>();
        source = accountFromVNeID == authController.currentUser.value?.uid
            ? AccountSources.vneid
            : AccountSources.sdksmartca;
      }

      final failureOrVerified = await orderCertRepository
          .createPersonalCertificateOrder(
              {"pricingCode": pricingCode, "source": source}, "");

      hideProgress();

      failureOrVerified.fold(
        (failure) {
          final error = failure.error;
          if (error is ServerException &&
              error.codeDesc == "ADDRESSV2_INVALID") {
            Get.to(() => UpdateAdressPage());
          } else {
            showErrorModal(exceptionHandler(failure));
          }
        },
        (result) async {
          OrderCertModel orderCertModel = OrderCertModel.fromJson(result);

          appController.backToMainPage();

          Get.to(
            () => OrderProcessingScreen(
              label: AppLocalizations.current.processing,
              content: AppLocalizations.current.waitaMinute,
              hiddenIconBack: true,
            ),
          );

          handleOrderModelByStatus(orderCertModel, isFromListOrder: false);

          secureStorage.removeData(ACCOUNT_OPEN_FROM_VNEID);
        },
      );
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  Future phoneVerification(
      String pin, bool useBiometrics, CertificateModel certificateModel) async {
    showLoading();
    try {
      // showProgress();
      hideLoading();

      // call API to send OTP
      sendOTP(
          sendAgain: false,
          useBiometrics: useBiometrics,
          certificateModel: certificateModel,
          pin: pin);

      // activeAccount(genkeySuccess);
      //emit(GenkeySuccess(  userPIN: pinDef,keyChallengeSig: base64.encode(challengeSig),kakPub: pubKey));
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  sendOTP(
      {bool sendAgain = false,
      bool? useBiometrics,
      required CertificateModel certificateModel,
      required String pin}) async {
    showLoading();
    try {
      final authController = Get.find<AuthController>();
      // Tránh trường hợp đổi SĐT trên oneBSS
      final uid = await secureStorage.getLastData(USERNAME_KEY) ?? "";
      final password = await secureStorage.getLastData(PASSWORD_KEY) ?? "";

      await authController.getProfile(uid, password);
      final currentUser = authController.currentUser.value;

      DeviceInfoModel deviceInfo = await _deviceInfoService.getDeviceInfo();
      showLoading();
      final failureOrVerified = await orderCertRepository.getOrderOTP({
        "Uid": currentUser?.uid ?? "",
        "Phone": currentUser?.phone ?? "",
        "DeviceId": deviceInfo.deviceId
      });
      hideLoading();
      failureOrVerified.fold((l) => showErrorModal(exceptionHandler(l)), (r) {
        if (sendAgain) {
          // nothing todo
        } else {
          // goto verify OTP screen
          Get.to(() =>
              VerifyOTPScreen(certificateModel: certificateModel, pin: pin));
        }
      });
    } catch (e, s) {
      hideLoading();
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  sendOTPUpdateInfo(
      {bool sendAgain = false,
      String? phone, //phone input on text
      String? email}) async {
    showLoading();
    try {
      final authController = Get.find<AuthController>();
      final currentUser = authController.currentUser.value;

      DeviceInfoModel deviceInfo = await _deviceInfoService.getDeviceInfo();
      showLoading();
      final failureOrVerified2 = await orderCertRepository.getOrderOTP({
        "Uid": currentUser?.uid ?? "",
        "Phone": currentUser?.phone,
        "DeviceId": deviceInfo.deviceId
      });
      hideLoading();
      Map<String, dynamic> map = {};
      map['DeviceId'] = deviceInfo.deviceId;
      map['Phone'] = phone;
      map['Email'] = email;
      failureOrVerified2.fold((l) => showErrorModal(exceptionHandler(l)), (r) {
        if (sendAgain) {
          // nothing todo
        } else {
          // goto verify OTP screen
          authController.currentUser.value?.phone = currentUser?.phone;

          Get.to(() => VerifyOTPUpdateScreen(map: map));
        }
      });
    } catch (e, s) {
      hideLoading();
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  void updateInfoEmailAndPhone(Map<String, dynamic> dataUpdate) async {
    showLoading();
    try {
      final failureOrVerified =
          await orderCertRepository.updateMailPhone(dataUpdate);
      hideLoading();
      failureOrVerified.fold(
        (failure) => {
          showErrorModal(exceptionHandler(failure)),
        },
        (result) async {
          checkSuccessUpdate.value = result;
          debugPrint(result.toString());
          showLoading();
          try {
            // remove after server update
            final failureOrVerified2 = await userRepository.getProfile();
            hideLoading();
            failureOrVerified2.fold((l) => showErrorModal(exceptionHandler(l)),
                (r) {
              authController.currentUser.value?.phone = dataUpdate['Phone'];
              Get.dialog(DialogNotification(
                content: AppLocalizations.current.update_info_success,
                titleBtnAccept: AppLocalizations.current.goHomeTC,
                onlyActionAccept: true,
                actionAccept: () async {
                  appController.backToMainPage();
                  await userRepository.getProfile();
                },
              ));
            });
          } catch (e, s) {
            hideLoading();
            showErrorModal(
                exceptionHandler(GenericException(error: e, stack: s)));
          }
        },
      );
    } catch (e, s) {
      hideLoading();
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  loopCheckOrderStatus(String orderId, int status) async {
    // vong lap check trang thai cua order
    await Future.delayed(const Duration(seconds: 3));
    if (!cancelLoop) {
      return;
    }
    try {
      final failureOrVerified =
          await orderCertRepository.getOrderInfo({"OrderId": orderId});
      if (!cancelLoop) {
        return;
      }
      failureOrVerified.fold(
        (failure) {
          if (!cancelLoop) {
            return;
          }
          loopCheckOrderStatus(orderId, status);
        },
        (result) async {
          if (!cancelLoop) {
            return;
          }
          OrderCertModel orderCertModel = OrderCertModel.fromJson(result);
          debugPrint("phucbvLogCASE : ${orderCertModel.statusDesc}");
          if (orderCertModel.status == status) {
            // van o trang thai cho sinh hop dong, tiep tuc loop
            if (orderCertModel.status ==
                OrderCertModel.APPROVE_REQUEST_CERT_WAITING) {
              if (loopCount <= 10) {
                loopCount++;
                print("Loop count : $loopCount");
                loopCheckOrderStatus(orderId, status);
              } else {
                handleOrderModelByStatus(orderCertModel,
                    isFromListOrder: false);
              }
            } else {
              loopCheckOrderStatus(orderId, status);
            }
          } else {
            orderCertModel.orderItemController?.currentOrderCertModel.value =
                orderCertModel;
            handleOrderModelByStatus(orderCertModel, isFromListOrder: false);
          }
        },
      );
    } catch (e, s) {
      if (!cancelLoop) {
        return;
      }
      loopCheckOrderStatus(orderId, status);
      // showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  verifyOrderEkycCert(String orderId, String ekycCode, String email,
      String phone, UserAddress? userAddress) async {
    showLoading();
    try {
      userAddress?.districtId = "99999";

      final failureOrVerified =
          await orderCertRepository.verifyEkycWithOrderId({
        "OrderId": orderId,
        "ekycCode": ekycCode,
        "email": email,
        "phone": phone,
        "address": userAddress,
      });
      hideLoading();
      failureOrVerified.fold(
        (failure) => {
          showErrorModal(exceptionHandler(failure)),
        },
        (result) async {
          showLoading();
          try {
            final failureOrVerified2 = await userRepository.getProfile();
            hideLoading();
            failureOrVerified2.fold((l) => showErrorModal(exceptionHandler(l)),
                (r) {
              OrderCertModel orderCertModel = OrderCertModel.fromJson(result);
              orderCertModel.orderItemController?.currentOrderCertModel.value =
                  orderCertModel;
              // todo by order status
              // orderCertModel.status;
              handleOrderModelByStatus(orderCertModel, isFromListOrder: false);
            });
          } catch (e, s) {
            hideLoading();
            showErrorModal(
                exceptionHandler(GenericException(error: e, stack: s)));
          }
        },
      );
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  handleOrderModelByStatus(OrderCertModel orderCertModel,
      {bool isFromListOrder = true}) async {
    debugPrint("status: ${orderCertModel.statusDesc}");

    if (orderCertModel.status == OrderCertModel.EKYC_WAITING) {
      // open ekyc
      try {
        eKycUserEnroll(
                newCTSName: orderCertModel.getTypeEnum() == OrderType.changeInfo
                    ? orderCertModel.fullName
                    : null)
            .then((value) async {
          debugPrint("result ekyc >>>>: $value");

          if (value == VerifyInfoType.error3times) {
            // back to danh sach chung thu so
            Get.until((route) => route.isFirst);
          } else if (value is EkycResponseModel) {
            if (orderCertModel.getTypeEnum() == OrderType.changeInfo) {
              // xac nhan ekyc voi don hang luon
              verifyOrderEkycCert(
                  orderCertModel.id, value.ekycCode ?? "", "", "", null);
            } else {
              // todo xac nhan thong tin
              String? profileString =
                  await secureStorage.getLastData(LOCAL_USER_PROFILE);
              ProfileModel profileModel =
                  ProfileModel.fromJson(jsonDecode(profileString!));
              Get.to(() => VerifyAddressScreen(
                    profileModel: profileModel,
                    orderCertModel: orderCertModel,
                  ))?.then((result) {
                if (result == true) {
                  // ekyc again
                  handleOrderModelByStatus(orderCertModel,
                      isFromListOrder: isFromListOrder);
                } else if (result is Map<String, dynamic>) {
                  String email = result["email"] ?? "";
                  String phone = result["phone"] ?? "";
                  UserAddress? userAddress = result["userAddress"];

                  debugPrint("email: $email");
                  debugPrint("phone: $phone");

                  // xac thuc ekyc voi don hang
                  verifyOrderEkycCert(
                    orderCertModel.id,
                    value.ekycCode ?? "",
                    profileModel.email == email ? "" : email,
                    profileModel.phone == phone ? "" : phone,
                    userAddress,
                  );
                }
              });
            }
          } else {
            if (!isFromListOrder) appController.backToMainPage();
          }
        });
      } catch (e) {}
    } else if (orderCertModel.status == OrderCertModel.OTP_WAITING) {
    } else if (orderCertModel.status == OrderCertModel.PAYMENT_WATING) {
      // thanh toán
      String? profileString =
          await secureStorage.getLastData(LOCAL_USER_PROFILE);
      ProfileModel profileModel =
          ProfileModel.fromJson(jsonDecode(profileString!));
      if (orderCertModel.getTypeEnum() == OrderType.newCert) {
        Get.to(() => ConfirmCertPackScreen(
              orderCertModel: orderCertModel,
              profileModel: profileModel,
            ))?.then((value) {
          if (value == true) {
            Get.to(
              () => OrderProcessingScreen(
                  label: AppLocalizations.current.paymentSuccess,
                  content: AppLocalizations.current.waitaMinute),
              preventDuplicates: false,
            );

            cancelLoop = true;
            loopCheckOrderStatus(orderCertModel.id, orderCertModel.status);
          } else if (value is OrderCertModel) {
            handleOrderModelByStatus(value, isFromListOrder: isFromListOrder);
          } else {
            if (!isFromListOrder) {
              appController.backToMainPage();
            }
          }
        });
      } else if (orderCertModel.getTypeEnum() == OrderType.renewCert) {
        Get.to(() => ConfirmCertPackExtendScreen(
              orderCertModel: orderCertModel,
              profileModel: profileModel,
            ))?.then((value) {
          if (value == true) {
            Get.to(
              () => OrderProcessingScreen(
                  label: AppLocalizations.current.creating_extend_ticket_label,
                  content: AppLocalizations.current.waitaMinute),
              preventDuplicates: false,
            );
            cancelLoop = true;
            loopCheckOrderStatus(orderCertModel.id, orderCertModel.status);
          } else if (value is OrderCertModel) {
            handleOrderModelByStatus(value, isFromListOrder: isFromListOrder);
          } else {
            if (!isFromListOrder) {
              appController.backToMainPage();
            }
          }
        });
      }
    } else if (orderCertModel.status ==
        OrderCertModel.CONTRACT_CREATE_WAITING) {
      if (orderCertModel.getTypeEnum() == OrderType.newCert) {
        Get.to(
          () => OrderProcessingScreen(
              label: AppLocalizations.current.creatingContract,
              content: AppLocalizations.current.waitaMinute),
          preventDuplicates: false,
        );
      } else if (orderCertModel.getTypeEnum() == OrderType.renewCert) {
        Get.to(
          () => OrderProcessingScreen(
              label: AppLocalizations.current.creating_extend_ticket_label,
              content: AppLocalizations.current.waitaMinute),
          preventDuplicates: false,
        );
      }
      // vong lap check trang thai cua order
      cancelLoop = true;
      loopCheckOrderStatus(orderCertModel.id, orderCertModel.status);
    } else if (orderCertModel.status == OrderCertModel.CONTRACT_SIGN_WAITING) {
      if (orderCertModel.getTypeEnum() == OrderType.changeDevice ||
          orderCertModel.getTypeEnum() == OrderType.changeInfo) {
        Get.to(() => SignBillPage(
              serial: orderCertModel.previousSerial,
              orderId: orderCertModel.id,
              orderCertModel: orderCertModel,
            ));
      } else {
        await eContractController.signedContract(
          orderId: orderCertModel.dhsxkdCustomerInfo.maGd,
          isFromListOrder: isFromListOrder,
        );

        if (eContractController.isContractSuccess.value) {
          Get.to(
            () => OrderProcessingScreen(
                hiddenIconBack: true,
                label: AppLocalizations.current.await_approve_cert,
                content: AppLocalizations.current.waitaMinute),
            preventDuplicates: false,
          );

          cancelLoop = true;
          loopCheckOrderStatus(orderCertModel.id, orderCertModel.status);
        } else {
          if (!isFromListOrder) {
            Get.until((route) => route.isFirst);
          }
        }
      }
    } else if (orderCertModel.status == OrderCertModel.REQUESTCERT_WATING) {
      // delay để đợi quá trình back xong
      Get.to(
        () => OrderProcessingScreen(
          label: AppLocalizations.current.orderREQUESTCERT_WATING,
          content: AppLocalizations.current.waitaMinute,
        ),
        preventDuplicates: false,
      );
      cancelLoop = true;
      loopCheckOrderStatus(orderCertModel.id, orderCertModel.status);
    } else if (orderCertModel.status == OrderCertModel.KEY_ASSIGN_WATING) {
      //sau khi chay ngam buoc cho duyet xong thi cho bo dem ve 1
      loopCount = 1;
      // todo pin code
      if (orderCertModel.getTypeEnum() == OrderType.changeDevice) {
        // todo pin code
        // 2 la trang thai cho kich hoat
        try {
          final homeController = Get.find<HomeController>();
          final cert = homeController.listCertificate.value?.firstWhere(
              (element) => element.id == orderCertModel.credentialId);

          appController.backToMainPage();

          Get.to(() => SetupPinCodePage(
                certificateModel: CertificateModel(
                  id: orderCertModel.credentialId!,
                  status: 2,
                  certProfile: cert != null
                      ? CertProfile(serviceType: cert.certProfile?.serviceType)
                      : null,
                ),
              ));
        } catch (e) {}
      } else if (orderCertModel.getTypeEnum() == OrderType.newCert ||
          orderCertModel.getTypeEnum() == OrderType.renewCert) {
        final homeController = Get.find<HomeController>();
        await homeController.getCertificateListWaitingActive();
        final cert = homeController.listCertificate.value?.firstWhere(
            (element) => element.id == orderCertModel.credentialId);

        appController.backToMainPage();

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
        }
      }
    } else if (orderCertModel.status == OrderCertModel.ONEBSS_SUBMIT_WAITING) {
      cancelLoop = true;
      loopCheckOrderStatus(orderCertModel.id, orderCertModel.status);
    } else if (orderCertModel.status ==
        OrderCertModel.APPROVE_REQUEST_CERT_WAITING) {
      if (!isFromListOrder) {
        if (loopCount <= 10 && orderCertModel.version == 2) {
          cancelLoop = true;
          loopCheckOrderStatus(orderCertModel.id, orderCertModel.status);
        } else {
          appController.backToMainPage();
          loopCount = 1;
          Get.to(
              () => WaitingForAcceptCertScreen(orderCertModel: orderCertModel));
        }
      }
    } else if (orderCertModel.status == OrderCertModel.EKYC_ERROR) {
    } else if (orderCertModel.status == OrderCertModel.OTP_ERROR) {
    } else if (orderCertModel.status == OrderCertModel.PAYMENT_ERROR) {
      if (isFromListOrder) {
        // thanh toán ko thành công cho thanh toán lại
        String? profileString =
            await secureStorage.getLastData(LOCAL_USER_PROFILE);
        ProfileModel profileModel =
            ProfileModel.fromJson(jsonDecode(profileString!));
        if (orderCertModel.getTypeEnum() == OrderType.newCert) {
          Get.to(() => ConfirmCertPackScreen(
                orderCertModel: orderCertModel,
                profileModel: profileModel,
              ))?.then((value) {
            if (value == true) {
              Get.to(
                () => OrderProcessingScreen(
                    label: AppLocalizations.current.paymentFailed,
                    content: AppLocalizations.current.contactHotline),
                preventDuplicates: false,
              );
              cancelLoop = true;
              loopCheckOrderStatus(orderCertModel.id, orderCertModel.status);
            } else if (value is OrderCertModel) {
              handleOrderModelByStatus(value, isFromListOrder: isFromListOrder);
            }
          });
        } else if (orderCertModel.getTypeEnum() == OrderType.renewCert) {
          Get.to(() => ConfirmCertPackExtendScreen(
                orderCertModel: orderCertModel,
                profileModel: profileModel,
              ))?.then((value) {
            if (value == true) {
              Get.to(
                () => OrderProcessingScreen(
                    label:
                        AppLocalizations.current.creating_extend_ticket_label,
                    content: AppLocalizations.current.waitaMinute),
                preventDuplicates: false,
              );
              cancelLoop = true;
              loopCheckOrderStatus(orderCertModel.id, orderCertModel.status);
            } else if (value is OrderCertModel) {
              handleOrderModelByStatus(value, isFromListOrder: isFromListOrder);
            }
          });
        }
      }
    } else if (orderCertModel.status == OrderCertModel.CONTRACT_CREATE_ERROR) {
      if (!isFromListOrder) {
        Get.until((route) => route.isFirst);
      }

      Get.to(() => ErrorRegisterCertScreen(
            title: orderCertModel.getTypeEnum() == OrderType.renewCert
                ? AppLocalizations.current.create_ticket_extension_error_label
                : AppLocalizations.current.orderNoteContentState1,
          ));
    } else if (orderCertModel.status == OrderCertModel.CONTRACT_SIGN_ERROR) {
      if (!isFromListOrder) {
        Get.until((route) => route.isFirst);
      }
      Get.to(() => ErrorRegisterCertScreen(
            title: AppLocalizations.current.orderCONTRACT_SIGN_ERROR,
          ));
    } else if (orderCertModel.status == OrderCertModel.REQUESTCERT_ERROR) {
      if (!isFromListOrder) {
        Get.until((route) => route.isFirst);
      }
      Get.to(() => ErrorRegisterCertScreen(
          title: AppLocalizations.current.tao_yeu_cau_chungthu_loi));
    } else if (orderCertModel.status == OrderCertModel.ONEBSS_SUBMIT_ERROR) {
      if (!isFromListOrder) {
        Get.until((route) => route.isFirst);
      }

      Get.to(() => ErrorRegisterCertScreen(
          title: AppLocalizations.current.submit_onebss_er));
    } else if (orderCertModel.status ==
        OrderCertModel.APPROVE_REQUEST_CERT_ERROR) {
      if (!isFromListOrder) {
        Get.until((route) => route.isFirst);
      }
      Get.to(() => ErrorRegisterCertScreen(
            title: AppLocalizations.current.approve_request_er,
          ));
    } else if (orderCertModel.status == OrderCertModel.REJECT_REQUEST_CERT) {
      if (!isFromListOrder) {
        Get.until((route) => route.isFirst);
      }
      Get.to(() => ErrorRegisterCertScreen(
            title: AppLocalizations.current.orderREJECT_REQUEST_CERT,
          ));
    } else if (orderCertModel.status == OrderCertModel.KEY_ASSIGN_ERROR) {
      if (!isFromListOrder) {
        Get.until((route) => route.isFirst);
      }
      Get.to(() => ErrorRegisterCertScreen(
            title: AppLocalizations.current.orderKEY_ASSIGN_ERROR,
          ));
    } else if (orderCertModel.status == OrderCertModel.CANCELED) {
      if (!isFromListOrder) {
        Get.until((route) => route.isFirst);
        showErrorModal(AppLocalizations.current.orderCANCELED);
      }
    } else if (orderCertModel.status == OrderCertModel.DONE) {
      if (orderCertModel.getTypeEnum() == OrderType.newCert) {
        if (!isFromListOrder) {
          Get.until((route) => route.isFirst);
        }
      } else if (orderCertModel.getTypeEnum() == OrderType.changeDevice) {
        Get.until((route) => route.isFirst);
        // 2 la trang thai cho kich hoat
        try {
          final homeController = Get.find<HomeController>();
          homeController.getCertificateListWaitingActive();
          final cert = homeController.listCertificate.value?.firstWhere(
              (element) => element.id == orderCertModel.credentialId);

          Get.to(() => SetupPinCodePage(
                certificateModel: CertificateModel(
                  id: orderCertModel.credentialId!,
                  status: 2,
                  certProfile: cert != null
                      ? CertProfile(serviceType: cert.certProfile?.serviceType)
                      : null,
                ),
              ));
        } catch (e) {}
      }
    } else if (orderCertModel.status ==
        OrderCertModel.EKYC_PROFILE_SYNC_ERROR) {
      Get.until((route) => route.isFirst);
      Get.to(() => ErrorRegisterCertScreen(
            title: AppLocalizations.current.sync_onebss_er,
          ));
    } else {
      // todo nothing
    }
  }

  activeKey(CertificateModel certificateModel, String otp, String pin) async {
    Get.to(() => GenerateCerKeyPage(
        certificateModel: certificateModel, otp: otp, pin: pin));
    return;
  }

  verifyEkyc(dynamic data, {String? newCTSName}) async {
    String errMess = '';
    showLoading();
    try {
      debugPrint(jsonEncode(data));
      // log('======>' + username!);
      var idFront = data["IdFront"];
      var idBack = data["IdBack"];
      var idFrontFull = data["IdFrontFull"];
      var idBackFull = data["IdBackFull"];
      var faceVideo = data["FaceVideo"];
      var ocrIdVideo = data["OcrIdVideo"];
      var nearPortrait = data["NearPortrait"];
      var farPortrait = data["FarPortrait"];

      ProfileModel profileModel = ProfileModel();

      final authController = Get.find<AuthController>();
      if (authController.authStatus == AuthenticationStatus.authenticated) {
        uid = authController.currentUser.value!.uid;
        profileModel.fullName = authController.currentUser.value?.displayName;
      }

      isFlowRegister = false;
      profileModel.uid = uid;
      DeviceInfoModel deviceInfo = await _deviceInfoService.getDeviceInfo();

      EkycCustomerRequest param = EkycCustomerRequest(
        nearPortrait: nearPortrait,
        farPortrait: farPortrait,
        idFront: idFront,
        idBack: idBack,
        idFrontFull: idFrontFull,
        idBackFull: idBackFull,
        faceVideo: faceVideo,
        ocrIdVideo: ocrIdVideo,
        uid: profileModel.uid,
        fullName: newCTSName ?? profileModel.fullName,
        deviceId: deviceInfo.deviceId,
        dkkdImages: [],
        dkkdVideo: null,
      );

      final failureOrVerified = await orderCertRepository.verifyEkyc(param);
      hideLoading();
      failureOrVerified.fold(
        (failure) {
          ekycErrorCount = ekycErrorCount + 1;
          exceptionHandler(failure);
          String reasonMessage = "";
          if (failure.error is ServerException) {
            ServerException serverException = failure.error as ServerException;
            if (serverException.codeDesc != null &&
                serverException.codeDesc!.isNotEmpty) {
              reasonMessage = serverException.message;
            }
          }
          if (ekycErrorCount >= 3) {
            Get.to(() => VerifyInfoErrorScreen(
                  type: VerifyInfoType.error3times,
                  errorText: reasonMessage,
                ))?.then((value) {
              ekycErrorCount = 0;
              // back to danh sach goi cuoc
              Get.back(result: VerifyInfoType.error3times);
            });
          } else {
            Get.to(() => VerifyInfoErrorScreen(
                  type: VerifyInfoType.error,
                  errorText: reasonMessage,
                ))?.then((value) async {
              if (value == true) {
                await _ekycAgain(newCTSName: newCTSName);
              } else {
                Get.back();
              }
            });
          }
        },
        (result) async {
          // ket qua ocr
          EkycResponseModel ekycResult =
              EkycResponseModel.fromJson(result.content);
          // back to danh sach goi cuoc
          Get.back(result: ekycResult);
          // todo
        },
      );
    } catch (e, s) {
      showErrorModal(errMess,
          title: AppLocalizations.current.verifyFail,
          image: Assets.images.icDialogFail, callback: () {
        Get.back();
      });
    }
  }

  _ekycAgain({String? newCTSName}) async {
    EKYCService ekycService = EKYCService();
    String errMess = '';
    // userStatus
    try {
      var data = await ekycService.eKYCFull();
      if (data == null) {
        Get.back();
        return;
      }

      var idFront = data["IdFront"];
      var idBack = data["IdBack"];
      var idFrontFull = data["IdFrontFull"];
      var idBackFull = data["IdBackFull"];
      var faceVideo = data["FaceVideo"];
      var ocrIdVideo = data["OcrIdVideo"];
      var nearPortrait = data["NearPortrait"];
      var farPortrait = data["FarPortrait"];

      if (idFront == null ||
          idFront.isEmpty ||
          idBack == null ||
          idBack.isEmpty ||
          faceVideo == null ||
          faceVideo.isEmpty ||
          idFrontFull == null ||
          idFrontFull.isEmpty ||
          idBackFull == null ||
          idBackFull.isEmpty ||
          nearPortrait == null ||
          nearPortrait.isEmpty ||
          ocrIdVideo == null ||
          ocrIdVideo.isEmpty ||
          farPortrait == null ||
          farPortrait.isEmpty) {
        Get.back();
        return;
      }
      verifyEkyc(data, newCTSName: newCTSName);
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  Future eKycUserEnroll({String? newCTSName}) async {
    EKYCService ekycService = EKYCService();
    String errMess = '';
    // userStatus
    try {
      var data = await ekycService.eKYCFull();
      if (data == null) {
        return null;
      }

      var idFront = data["IdFront"];
      var idBack = data["IdBack"];
      var idFrontFull = data["IdFrontFull"];
      var idBackFull = data["IdBackFull"];
      var faceVideo = data["FaceVideo"];
      var ocrIdVideo = data["OcrIdVideo"];
      var nearPortrait = data["NearPortrait"];
      var farPortrait = data["FarPortrait"];

      if (idFront == null ||
          idFront.isEmpty ||
          idBack == null ||
          idBack.isEmpty ||
          faceVideo == null ||
          faceVideo.isEmpty ||
          idFrontFull == null ||
          idFrontFull.isEmpty ||
          idBackFull == null ||
          idBackFull.isEmpty ||
          nearPortrait == null ||
          nearPortrait.isEmpty ||
          ocrIdVideo == null ||
          ocrIdVideo.isEmpty ||
          farPortrait == null ||
          farPortrait.isEmpty) {
        return null;
      }

      var result = await Get.to(() => VerifyInfoScreen(
            data: data,
            newCTSName: newCTSName,
          ));
      return result;
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  // huy don hang
  cancelOrder(OrderCertModel orderCertModel) async {
    showLoading();
    try {
      final failureOrVerified =
          await orderCertRepository.cancelOrder(orderCertModel.id);
      hideLoading();
      failureOrVerified.fold(
        (failure) => {
          showErrorModal(exceptionHandler(failure), callback: () {
            // Get.back();
          }),
        },
        (result) async {
          debugPrint(result.toString());
          OrderCertModel orderCertModel1 =
              OrderCertModel.fromJson(result.content);
          orderCertModel.orderItemController?.currentOrderCertModel.value =
              orderCertModel1;
          // currentOrderCertModel.value = orderCertModel;
          // localUpdateUserAddress(
          //     userAddress, addressController, detailAddressController);
        },
      );
    } catch (e, s) {
      hideLoading();
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)),
          callback: () {
        // Get.back();
      });
    }
  }
}
