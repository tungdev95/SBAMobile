// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vnpt_smartca_module/configs/app_config.dart';

import '../../../configs/injector/injector.dart';
import '../../../core/models/app/exceptions.dart';
import '../../../core/models/app/file_model.dart';
import '../../../core/models/request/waiting_tran_req_model.dart';
import '../../../core/models/request/waiting_trans_req_model.dart';
import '../../../core/models/response/transaction_model.dart';
import '../../../core/services/biometrics.dart';
import '../../../core/utils/share_file.dart';
import '../../../data/repository/transaction_repository.dart';
import '../../../views/controller/base_controler.dart';
import '../../../views/i18n/generated_locales/l10n.dart';
import '../../../views/pages/transaction_request/detail.dart';
import '../../../views/pages/transaction_request/widgets/transaction_clock_count_down.dart';
import '../../../views/utils/exception_handler.dart';
import '../../../views/widgets/circular_count_down_timer.dart';
import 'package:base32/base32.dart';

import '../../core/models/app/smartca_message_result.dart';
import '../../core/models/app/user_info_on_device.dart';
import '../../core/models/response/service_response.dart';
import '../../core/models/response/token_model.dart';
import '../../core/services/secure_local_storage.dart';
import '../../core/services/user_info_on_device.dart';
import '../../core/utils/constants.dart';
import '../../data/repository/eseal/3rd_repository.dart';
import '../../data/repository/eseal/transaction_repository.dart';
import '../../method_channel_handler.dart';
import '../pages/certificate/sign_bbnt/widget/preview_pdf_acceptance.dart';
import '../pages/transaction_request/waiting_confirm_by_smartca_app_screen.dart';
import '../pages/transaction_request/widgets/pin_dialog.dart';
import '../utils/enums.dart';
import '../widgets/dialog/common_dialog.dart';
import '../widgets/draw_signature_dialog.dart';
import '../widgets/navigator_helper.dart';
import '../widgets/show_snackbar_widget.dart';
import 'app_controller.dart';
import 'auth_controller.dart';
import 'certificate_controller.dart';
import 'home_controller.dart';

class TransactionController extends BaseController {
  final transactionRepository = getIt<TransactionRepository>();
  final refreshController = RefreshController(initialRefresh: true);
  final biometricService = getIt<BiometricsService>();
  final _userInfoOnDeviceService = getIt<UserInfoOnDeviceService>();
  final _generateSADUtils = getIt<GenerateSADUtils>();

  //Nhóm giao dịch theo chứng thư số
  // ignore: prefer_collection_literals
  final transactionRequestGroupList = Map<dynamic, dynamic>().obs;
  //Giao dich
  final transactionRequestList = List<TransactionModel>.empty().obs;
  //Thông tin giao dịch ở màn hình chi tiết
  final transactionInfo = Rx<TransactionModel?>(null);

  final listFile = Rx<List<FileModel>>([]);
  final displayDocName = ''.obs;
  final isShowResult = false.obs;
  bool isOpenFromExternalApp = false;
  Timer? waitingConfirmTimer;
  final checkConfirmAcceptance = false.obs;

  /*
    Sử dụng cho việc hiển thị view countdown

    - isTransactionState = true ==> con thời hạn ký;
    - isTransactionState = false ==> các trường hợp khác;
  */
  final isTransactionState = true.obs;
  int wrongPINCount = 0;
  bool isSystemLinkTrans = false;

  final CountDownController countDownController = CountDownController();

  //Lấy danh sách các yêu cầu ký
  getTransactionRequests() async {
    try {
      final failureOrTransactions =
          await transactionRepository.getWaitingTransactions(
              WaitingTransactionListRequest(pageIndex: 1, pageSize: 100));

      failureOrTransactions.fold(
        (failure) {
          isTransactionState.value = false;
          isShowResult.value = false;
          refreshController.refreshFailed();
          showErrorModal(exceptionHandler(
              GenericException(error: failure.error, stack: failure.stack)));
        },
        (res) {
          transactionRequestList.value =
              res.where((element) => element.expiredIn > 0).toList();

          final groupedItems = groupTransactionByCredential(res);

          transactionRequestGroupList.value = groupedItems;
          isShowResult.value = true;
          isTransactionState.value = true;
          refreshController.refreshCompleted();
          update();
        },
      );
    } catch (e) {
      isTransactionState.value = false;
      refreshController.refreshFailed();
      showErrorModal(AppLocalizations.current.serviceSomethingWentWrong);
    }
  }

  Map<dynamic, dynamic> groupTransactionByCredential(
      List<TransactionModel> items) {
    return groupBy(items, (item) => item.credentialId);
  }

  /// Xem chi tiết giao dịch chờ.
  getWaitingTransactionInfoById(String tranId) async {
    String msg = '';
    try {
      final failureOrTransactionInfo = await transactionRepository
          .getWaitingTransactionById(WaitingTransactionRequest(tranId: tranId));
      await failureOrTransactionInfo.fold(
        (l) async {
          isTransactionState.value = false;
          isShowResult.value = false;
          refreshController.refreshFailed();
          msg = exceptionHandler(
              GenericException(error: l.error, stack: l.stack));
          showErrorModal(msg);
        },
        (r) async {
          transactionInfo.value = r;
          getListTransactionFile(r);
          isShowResult.value = true;
          isTransactionState.value = true;
        },
      );
    } catch (e) {
      isTransactionState.value = false;
      msg = AppLocalizations.current.serviceSomethingWentWrong;
      showErrorModal(msg);
    }
    return msg;
  }

  /// Xem chi tiết giao dịch chờ.
  waitingtraninfoAcceptance(String tranId) async {
    String msg = '';
    try {
      final failureOrTransactionInfo = await transactionRepository
          .waitingtraninfoAcceptance(WaitingTransactionRequest(tranId: tranId));
      await failureOrTransactionInfo.fold(
        (l) async {
          isTransactionState.value = false;
          isShowResult.value = false;
          refreshController.refreshFailed();
          msg = exceptionHandler(
              GenericException(error: l.error, stack: l.stack));
          showErrorModal(msg);
        },
        (r) async {
          transactionInfo.value = r;
          getListTransactionFile(r);
          isShowResult.value = true;
          isTransactionState.value = true;
        },
      );
    } catch (e) {
      isTransactionState.value = false;
      msg = AppLocalizations.current.serviceSomethingWentWrong;
      showErrorModal(msg);
    }
    return msg;
  }

  //isBlank = false: đang ở màn hình giao dịch cần ký
  //isBlank = true: đang ở màn hình xem chi tiết giao dịch cần ký
  void onUpdateTransactionItems(TransactionModel tran) {
    transactionRequestList.value = transactionRequestList
        .where((element) => element.tranId != tran.tranId)
        .toList();
    // ignore: invalid_use_of_protected_member
    final groupedItems =
        groupTransactionByCredential(transactionRequestList.value);
    transactionRequestGroupList.value = groupedItems;
    transactionRequestGroupList.refresh();
    transactionRequestList.refresh();
    update();

    Get.until((route) => Get.currentRoute == "/");
  }

  //Lây danh sách tài liệu yêu cầu ký
  String getListTransactionFile(TransactionModel tran) {
    displayDocName.value = '';
    listFile.value = [];
    for (var element in tran.docs) {
      FileModel file = FileModel(
          name: element['name'] ?? "",
          size: element['size'] ?? "",
          data: element['data'] ?? "",
          file: null,
          path: '',
          sizeMb: 0);
      listFile.value.add(file);
    }

    List<String?> lstFileName =
        listFile.value.map((file) => file.name).toList();
    displayDocName.value = lstFileName.join(", ");
    return lstFileName.join(", ");
  }

  /// Lấy chi tiết giao dịch và Xác nhận ký giao dịch
  getDetailAndConfirmWaitingTransaction(
      String userPIN, TransactionModel transactionModel) async {
    try {
      showProgress();
      final failureOrTransactionInfo =
          await transactionRepository.getWaitingTransactionById(
              WaitingTransactionRequest(tranId: transactionModel.tranId));
      hideProgress();

      failureOrTransactionInfo.fold(
        (l) {
          refreshController.refreshFailed();
          if (l.error is ServerException &&
              ((l.error as ServerException).codeDesc ?? "")
                  .contains("SIGNATURE_TRANSACTION_NOT_WAITING")) {
            Timer(const Duration(milliseconds: 500), () {
              final appController = Get.find<AppController>();
              if (appController.selectedIndex.value == 0) {
                onRefresh();
              }

              appController.backToMainPage();
            });

            showNotifyModal(AppLocalizations.current.transactionNotWaiting);

            return;
          }
          showErrorModal(exceptionHandler(
              GenericException(error: l.error, stack: l.stack)));
        },
        (r) async {
          transactionInfo.value = r;
          await confirmWaitingTransaction(userPIN, r);
        },
      );
    } catch (e) {
      showErrorModal(AppLocalizations.current.serviceSomethingWentWrong);
    }
  }

  /// Xác nhận ký giao dịch
  confirmWaitingTransaction(
      String userPIN, TransactionModel transactionModel) async {
    try {
      final cert = await getCertInfoOnDevice(transactionModel.credentialId,
          transactionModel: transactionModel,
          showNotify: transactionModel.tranType != 5);

      if (cert == null) {
        if (transactionModel.tranType == 5) {
          showNotifyModal(
            AppLocalizations.current.reSignAcceptance,
            titleBtnAccept: AppLocalizations.current.Continue,
            showFaq: false,
            actionAccept: () {
              drawSignature(transactionModel);
            },
            onlyActionCancel: false,
          );
        }
        return;
      }

      final authController = Get.find<AuthController>();
      final currentUser = authController.currentUser.value;

      final isEseal = cert.otpSecret != null && cert.otpSecret != "";
      if (userPIN != cert.pin) {
        wrongPINCount++;
        if (wrongPINCount > 4 && transactionModel.tranType == 5) {
          showNotifyModal(
            AppLocalizations.current.reSignAcceptance,
            titleBtnAccept: AppLocalizations.current.Continue,
            showFaq: false,
            actionAccept: () {
              drawSignature(transactionModel);
            },
            onlyActionCancel: false,
          );
        } else {
          showErrorModal(AppLocalizations.current.invalidPIN);
        }
        return;
      }
      wrongPINCount = 0;
      showProgress();

      String sad;
      if (isEseal == true) {
        if (transactionModel.tranType != 5) {
          await getOTPSecret(transactionModel.credentialId);
        }

        sad = await _generateSADUtils.checkedAndGenerateSADAcceptanceESeal(
            transactionModel, currentUser!.uid, cert);
      } else {
        sad = await _generateSADUtils.checkedAndGenerateSAD(
            transactionModel, userPIN, cert);
      }

      late Either<GenericException, SmartCAApiResponse> failureOrConfirmed;
      late TransactionRepositoryEseal transactionRepositoryEseal;

      if (isEseal == true) {
        transactionRepositoryEseal = getIt<TransactionRepositoryEseal>();
        final thirdPartyRepositoryEseal = getIt<ThirdPartyRepositoryEseal>();

        final reqConfirmTran = {
          "tranId": transactionModel.tranId,
          "credentialId": transactionModel.credentialId,
          "uid": currentUser!.uid,
          "sad": sad,
        };

        if (transactionModel.tranType == 5) {
          failureOrConfirmed = await transactionRepositoryEseal
              .confirmAcceptance(reqConfirmTran);
        } else {
          if (transactionModel.refTransactionId.contains("iscaLink")) {
            failureOrConfirmed =
                await thirdPartyRepositoryEseal.confirmLink3rd(reqConfirmTran);
          } else if (transactionModel.refTransactionId.contains("iscaUnlink")) {
            failureOrConfirmed = await thirdPartyRepositoryEseal
                .confirmDelete3rdLink(reqConfirmTran);
          } else {
            failureOrConfirmed =
                await transactionRepositoryEseal.signhashEseal(reqConfirmTran);
          }
        }
      } else {
        // if (transactionModel.tranType == 5) {
        //   failureOrConfirmed = await transactionRepository
        //       .signconfirmAcceptance(transactionModel, userPIN, sad);
        // } else {
        failureOrConfirmed = await transactionRepository
            .confirmWaitingTransaction(transactionModel, userPIN, sad);
        // }
      }

      hideProgress();

      failureOrConfirmed.fold(
        (l) async {
          refreshController.refreshFailed();
          if (l.error is ServerException) {
            if ((l.error as ServerException).code == 62003) {
              showSuccessModal(
                  message: AppLocalizations.current.signedSuccess,
                  titleBtnAccept: AppLocalizations.current.close,
                  actionAccept: () {
                    Timer(const Duration(milliseconds: 500), () {
                      final appController = Get.find<AppController>();
                      if (appController.selectedIndex.value == 0) {
                        onRefresh();
                      }
                      if (isSystemLinkTrans == false) {
                        appController.backToMainPage();
                      }
                    });
                  });
              return;
            } else if (transactionModel.tranType == 5) {
              showNotifyModal(
                AppLocalizations.current.reSignAcceptance,
                titleBtnAccept: AppLocalizations.current.Continue,
                showFaq: false,
                actionAccept: () {
                  drawSignature(transactionModel);
                },
                onlyActionCancel: false,
              );
              return;
            } else if ((l.error as ServerException).code == 63000 ||
                (l.error as ServerException).code == 63001) {
              Get.to(
                () => WaitingConfirmBySmartCAAppScreen(
                  label: AppLocalizations.current.KAKChanged,
                  transactionModel: transactionModel,
                  onChangeDevice: () =>
                      onTapChangeDevice(transactionModel.credentialId),
                  openSmartCAApp: () => openSmartCAApp(transactionModel),
                  waitingConfirmOnApp: () =>
                      waitingConfirmOnSmartCAApp(transactionModel!),
                ),
              );
              return;
            }
          }

          final message = exceptionHandler(
              GenericException(error: l.error, stack: l.stack));

          sendWaitingTransactionResult(message, 1);

          showErrorModal(message);
        },
        (r) async {
          refreshController.refreshCompleted();
          final appController = Get.find<AppController>();

          final currentHostAppMethod = appController.currentHostAppMethod.value;

          showSuccessModal(
            message: transactionModel.tranType == 5
                ? AppLocalizations.current.signBbntSuccess
                : AppLocalizations.current.signTransactionDone,
            titleBtnAccept: transactionModel.tranType == 5
                ? AppLocalizations.current.iUnderstand
                : AppLocalizations.current.close,
            title: AppLocalizations.current.successNotirce,
            actionAccept: () {
              Timer(const Duration(milliseconds: 500), () async {
                appController.backToMainPage();

                if (transactionModel.tranType == 5 &&
                    (currentHostAppMethod == MethodChannelNames.createAccount ||
                        currentHostAppMethod ==
                            MethodChannelNames.getAuthentication)) {
                  final secureLocalDataSource =
                      getIt<SecureLocalStorageService>();

                  final tokenString = await secureLocalDataSource
                      .getLastData(LOCAL_ACCESS_TOKEN_AUTH);

                  var token = TokenModel.fromJson(tokenString!);

                  final homeController = Get.find<HomeController>();
                  final serial = homeController.listCertificate.value
                      ?.firstWhere((element) =>
                          element.id == transactionModel.credentialId)
                      .serial;

                  SmartCaResult resp = SmartCaResult(
                    ResultCode.SUCCESS_CODE,
                    ResultCodeDesc.SUCCESS,
                    jsonEncode(
                      {
                        'accessToken': token.accessToken,
                        'credentialId': transactionModel.credentialId,
                        'serial': serial,
                      },
                    ),
                  );

                  final methodChannelHandler = getIt<MethodChannelHandler>();
                  if (currentHostAppMethod ==
                      MethodChannelNames.getAuthentication) {
                    methodChannelHandler.send(
                        method: MethodChannelNames.getAuthenticationResult,
                        data: resp);
                  } else {
                    methodChannelHandler.send(
                        method: MethodChannelNames.createAccountResult,
                        data: resp);
                  }

                  NavigatorHandler.closeSDK();
                } else if (currentHostAppMethod ==
                    MethodChannelNames.getWaitingTransaction) {
                  if (transactionModel.tranType != 5) {
                    sendWaitingTransactionResult(r.message, r.code);
                  } else {
                    appController.selectTab(0);
                  }
                }
              });
            },
          );

          if (currentHostAppMethod ==
                  MethodChannelNames.getWaitingTransaction &&
              transactionModel.tranType != 5) {
            appController.backToMainPage();

            Timer(const Duration(milliseconds: 100), () async {
              sendWaitingTransactionResult(r.message, r.code);
            });
          }

          Timer(
            const Duration(milliseconds: 300),
            () async {
              if (transactionModel.tranType == 5 && isEseal == true) {
                var param = {
                  'uid': currentUser!.uid,
                  'pin': userPIN,
                  'showQr': true,
                  'credentialId': transactionModel.credentialId,
                };
                var resp;
                failureOrConfirmed =
                    await transactionRepositoryEseal.eSealGetCode(param);
                failureOrConfirmed.fold((l) => l, (_resp) => resp = _resp);

                final totpBasicSpec = resp.content['totpBasicSpec'];
                final cert = await _userInfoOnDeviceService
                    .getCerCurrentUserByIdCer(transactionModel.credentialId);
                cert?.otpSecret =
                    base32.encode(base64Decode(totpBasicSpec['totp']));
                await _userInfoOnDeviceService.addOrUpdateCert(
                    currentUser.uid, cert!);
              }
            },
          );
        },
      );
    } catch (e) {
      showErrorModal(AppLocalizations.current.serviceSomethingWentWrong);
    } finally {
      isOpenFromExternalApp = false;
    }
  }

  /// Hủy giao dịch chờ
  rejectWaitingTransaction(
      String userPIN, TransactionModel transactionModel) async {
    try {
      final cert = await getCertInfoOnDevice(
        transactionModel.credentialId,
        transactionModel: transactionModel,
      );
      if (cert == null) return;

      if (userPIN != cert.pin) {
        showErrorModal(AppLocalizations.current.invalidPIN);
        return;
      }
      showProgress();

      final sad = await _generateSADUtils.checkedAndGenerateSAD(
          transactionModel, userPIN, cert);

      final failureOrConfirmed = await transactionRepository
          .rejectWaitingTransaction(transactionModel, userPIN, sad);

      hideProgress();

      await failureOrConfirmed.fold(
        (l) async {
          refreshController.refreshFailed();
          final message = exceptionHandler(
              GenericException(error: l.error, stack: l.stack));

          if ((l.error as ServerException).code == 62003) {
            showSuccessModal(
                message:
                    AppLocalizations.current.cancel_tranaction_success("", ""),
                titleBtnAccept: AppLocalizations.current.close,
                actionAccept: () {
                  Timer(const Duration(milliseconds: 500), () {
                    final appController = Get.find<AppController>();
                    if (appController.selectedIndex.value == 0) {
                      onRefresh();
                    }
                    if (isSystemLinkTrans == false) {
                      appController.backToMainPage();
                    }
                  });
                });
            return;
          }

          sendWaitingTransactionResult(message, 1);

          showErrorModal(message);
        },
        (r) async {
          refreshController.refreshCompleted();

          sendWaitingTransactionResult(r.message, r.code);

          showSnackBarWidget(
            message: AppLocalizations.current.cancelTransactionDone,
            icon: const Icon(Icons.check_circle_outline,
                color: Colors.white, size: 32),
            milliseconds: 1400,
            backgroundColor: Color(0xff0D75D6),
          );

          onRefresh();
          Get.until((route) => Get.currentRoute == "/");
        },
      );
    } catch (e) {
      showErrorModal(AppLocalizations.current.serviceSomethingWentWrong);
    } finally {
      isOpenFromExternalApp = false;
    }
  }

  //Ký/hủy tất cả giao dịch
  void useBiometricWithAllTransaction(
      TransactionType transactionType, String credentialId) async {
    await biometricService
        .authenticateWithBiometrics()
        .then((authenticated) async {
      if (authenticated) {
        //Lấy PIN lưu ở Local
        final cert = await getCertInfoOnDevice(credentialId);
        if (cert == null) return;

        if (transactionType == TransactionType.confirm) {
          confirmAllWaitingTransaction(cert.pin, credentialId);
        } else {
          rejectAllWaitingTransaction(cert.pin, credentialId);
        }
      } else {
        Get.dialog(
          PINDialogWidget(
              transactionType: transactionType,
              callback: (pin) {
                if (transactionType == TransactionType.confirm) {
                  confirmAllWaitingTransaction(pin, credentialId);
                } else {
                  rejectAllWaitingTransaction(pin, credentialId);
                }
              }),
          barrierDismissible: false,
        );
      }
    }).catchError((onError) => null);
  }

  /// Xác nhận ký tất cả giao dịch
  Future confirmAllWaitingTransaction(
      String userPIN, String credentialId) async {
    try {
      showProgress();
      final itemTransactions = transactionRequestGroupList[credentialId];
      int signRrrors = 0;

      final cert = await getCertInfoOnDevice(itemTransactions[0].credentialId);
      if (cert == null) return;

      if (userPIN != cert.pin) {
        hideProgress();
        showErrorModal(AppLocalizations.current.invalidPIN);
        return;
      }

      final authController = Get.find<AuthController>();
      final currentUser = authController.currentUser.value;

      final isEseal = cert.otpSecret != null && cert.otpSecret != "";

      if (isEseal == true) {
        getOTPSecret(credentialId);
      }

      // ignore: prefer_collection_literals
      Map<String, String> lstMessages = Map<String, String>();
      for (var i = 0; i < itemTransactions.length; i++) {
        TransactionModel item = itemTransactions[i];
        final failureOrTransactionInfo =
            await transactionRepository.getWaitingTransactionById(
                WaitingTransactionRequest(tranId: item.tranId));
        failureOrTransactionInfo.fold(
          (l) async {
            signRrrors++;
            final msg = exceptionHandler(
                GenericException(error: l.error, stack: l.stack));
            lstMessages['ERR-${signRrrors.toString().padLeft(2, "0")}'] = msg;
            return;
          },
          (r) async {
            transactionInfo.value = r;

            String sad;

            if (isEseal == true) {
              sad =
                  await _generateSADUtils.checkedAndGenerateSADAcceptanceESeal(
                      r, currentUser!.uid, cert);
            } else {
              sad = await _generateSADUtils.checkedAndGenerateSAD(
                  r, userPIN, cert);
            }

            late Either<GenericException, SmartCAApiResponse>
                failureOrConfirmed;
            late TransactionRepositoryEseal transactionRepositoryEseal;

            if (isEseal == true) {
              transactionRepositoryEseal = getIt<TransactionRepositoryEseal>();
              final thirdPartyRepositoryEseal =
                  getIt<ThirdPartyRepositoryEseal>();

              final reqConfirmTran = {
                "tranId": r.tranId,
                "credentialId": r.credentialId,
                "uid": currentUser!.uid,
                "sad": sad,
              };

              if (r.tranType == 5) {
                failureOrConfirmed = await transactionRepositoryEseal
                    .confirmAcceptance(reqConfirmTran);
              } else {
                if (r.refTransactionId.contains("iscaLink")) {
                  failureOrConfirmed = await thirdPartyRepositoryEseal
                      .confirmLink3rd(reqConfirmTran);
                } else if (r.refTransactionId.contains("iscaUnlink")) {
                  failureOrConfirmed = await thirdPartyRepositoryEseal
                      .confirmDelete3rdLink(reqConfirmTran);
                } else {
                  failureOrConfirmed = await transactionRepositoryEseal
                      .signhashEseal(reqConfirmTran);
                }
              }
            } else {
              failureOrConfirmed = await transactionRepository
                  .confirmWaitingTransaction(r, userPIN, sad);
            }

            // Ký BBNT
            failureOrConfirmed.fold(
              (l) {
                signRrrors++;
                final msg = exceptionHandler(
                    GenericException(error: l.error, stack: l.stack));
                lstMessages['ERR-${signRrrors.toString().padLeft(2, "0")}'] =
                    msg;
                return;
              },
              (r) {
                return;
              },
            );
          },
        );
      }
      hideProgress();
      refreshController.refreshCompleted();

      final signDone = itemTransactions.length - signRrrors;
      if (signRrrors == 0) {
        showSuccessModal(
          message: AppLocalizations.current.signTransactionDone,
          titleBtnAccept: AppLocalizations.current.close,
          title: AppLocalizations.current.successNotirce,
          actionAccept: () {
            onRefresh();
          },
        );
        return;
      }
      String mesg = '';
      lstMessages.forEach((key, value) {
        mesg += '[$key]: $value \n';
      });

      final signSuccess = '$signDone/${itemTransactions.length}';
      showSuccessModal(
        message:
            AppLocalizations.current.sign_tranaction_success(signSuccess, mesg),
        titleBtnAccept: AppLocalizations.current.close,
        title: AppLocalizations.current.successNotirce,
        actionAccept: () {
          onRefresh();
        },
      );
    } catch (e) {
      hideProgress();
      refreshController.refreshFailed();
      showErrorModal(AppLocalizations.current.serviceSomethingWentWrong);
    }
  }

  /// Hủy giao dịch chờ
  rejectAllWaitingTransaction(String userPIN, String credentialId) async {
    try {
      showProgress();
      final itemTransactions = transactionRequestGroupList[credentialId];
      var cancelRrrors = 0;
      Map<String, String> lstMessages = {};
      final cert = await getCertInfoOnDevice(credentialId);
      if (cert == null) return;
      if (userPIN != cert.pin) {
        hideProgress();
        showErrorModal(AppLocalizations.current.invalidPIN);
        return;
      }

      for (var item in itemTransactions) {
        if (item.tranType == 5) continue;

        final sad =
            await _generateSADUtils.checkedAndGenerateSAD(item, userPIN, cert);

        final failureOrCanceled = await transactionRepository
            .rejectWaitingTransaction(item, userPIN, sad);
        await failureOrCanceled.fold(
          (l) async {
            cancelRrrors++;
            final msg = exceptionHandler(
                GenericException(error: l.error, stack: l.stack));
            lstMessages['ERR-$cancelRrrors'] = msg;
            return;
          },
          (r) async {
            return;
          },
        );
      }

      hideProgress();

      final cancelDone = itemTransactions.length - cancelRrrors;

      if (cancelRrrors == 0) {
        showSuccessModal(
          message: AppLocalizations.current.cancelTransactionDone,
          titleBtnAccept: AppLocalizations.current.close,
          title: AppLocalizations.current.successNotirce,
          actionAccept: () {
            onRefresh();
          },
        );
        return;
      }

      String mesg = '';
      lstMessages.forEach((key, value) {
        mesg += '[$key]: $value \n';
      });

      refreshController.refreshCompleted();

      final cancelSuccess = '$cancelDone/${itemTransactions.length}';
      showSuccessModal(
        message: AppLocalizations.current
            .cancel_tranaction_success(cancelSuccess, mesg),
        titleBtnAccept: AppLocalizations.current.close,
        title: AppLocalizations.current.successNotirce,
        actionAccept: () {
          onRefresh();
        },
      );
    } catch (e) {
      hideProgress();
      refreshController.refreshFailed();
      showErrorModal(AppLocalizations.current.serviceSomethingWentWrong);
    }
  }

  useBiometricWithTransaction(
      TransactionType transactionType, TransactionModel transactionModel,
      {bool needGetDetail = false}) async {
    final authenticated = await biometricService.authenticateWithBiometrics();
    if (authenticated) {
      //Lấy PIN lưu ở Local
      final cert = await getCertInfoOnDevice(transactionModel.credentialId,
          transactionModel: transactionModel);
      if (cert == null) return;

      if (transactionType == TransactionType.confirm) {
        if (needGetDetail == true) {
          await getDetailAndConfirmWaitingTransaction(
              cert.pin, transactionModel);
        } else {
          await confirmWaitingTransaction(cert.pin, transactionModel);
        }
      } else {
        await rejectWaitingTransaction(cert.pin, transactionModel);
      }
    }

    return authenticated;
  }

  getDetailTrans(String tranId) async {
    try {
      showProgress();
      String msg = await getWaitingTransactionInfoById(tranId);
      hideProgress();
      if (msg.isEmpty) {
        Get.to(() => TransactionDetail());
      } else {
        sendWaitingTransactionResult(msg, 1);
        // showErrorModal(msg);
      }
    } catch (e) {
      hideProgress(closeOverlays: true);
    }
  }

  /// Khởi tạo file_name từ danh sách file nhận được qua API.
  void _initFileModel(TransactionModel trans) {
    listFile.value = [];
    for (var element in trans.docs) {
      FileModel? file = FileModel.fromDoc(element);
      if (file != null) {
        listFile.value.add(file);
      }
    }
  }

  /// Xem chi tiết giao dịch .
  Future getTransInfor(String tranId) async {
    try {
      showLoading();
      transactionInfo.value = null;
      final failureOrTransactionModel =
          await transactionRepository.getTransInfor(tranId);
      hideLoading();
      failureOrTransactionModel.fold(
        (l) => {showErrorModal(exceptionHandler(l), callback: () {})},
        (r) => {
          transactionInfo.value = r,
          _initFileModel(r),
        },
      );
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)),
          callback: () {});
    }
  }

  getBbntTrans(String credentialId) async {
    try {
      TransactionModel? transactionBbnt;
      transactionInfo.value = null;

      var req = WaitingTransactionListRequest(pageIndex: 1, pageSize: 25);
      bool isStop = false;
      List<TransactionModel>? transactions;
      int count = 0;

      while (isStop == false) {
        if (count > 150) isStop = true;

        final failureOrTransactionModel =
            await transactionRepository.getWaitingTransactions(req);

        failureOrTransactionModel.fold(
          (l) => {
            isStop = true,
            showErrorModal(exceptionHandler(GenericException(error: l.error))),
          },
          (result) {
            transactions = result;
          },
        );

        if (transactions != null) {
          for (var element in transactions!) {
            if (element.credentialId == credentialId && element.tranType == 5) {
              transactionBbnt = element;
              isStop = true;
            }
          }
        } else {
          await Future.delayed(Duration(seconds: count > 20 ? 4 : 3), () {});
          count++;
        }
      }

      if (transactionBbnt != null) {
        await getWaitingTransactionInfoById(transactionBbnt.tranId);
      }
    } catch (e, s) {
      showErrorModal(exceptionHandler(
        GenericException(error: e, stack: s),
      ));
    }
  }

  void _onComplete(TransactionModel tran) => onUpdateTransactionItems(tran);

  // Đồng hồ đếm ngược
  Widget buildCountdown(TransactionModel transactionModel) {
    return SizedBox(
      child: isTransactionState.value
          ? TransactionClockCountDown(
              key: UniqueKey(),
              isShowResult: isShowResult.value,
              model: transactionModel,
              onComplete: (tran) => _onComplete(transactionModel),
              countDownController: countDownController,
            )
          : Container(),
    );
  }

  ///  Hiển thị file trước khi ký
  onPreviewDocument(FileModel file) {
    try {
      final extension = p.extension(file.name).trim();
      if (extension.isNotEmpty) {
        ShareFiles.saveFile(file.data, file.name).then((value) => {
              // ShareFiles.readFile(file.name)
              Get.to(() => PreviewPDfAcceptance(file: file))
            });
      } else {
        showErrorModal(AppLocalizations.current.serviceSomethingWentWrong);
      }
    } catch (e) {
      showErrorModal(AppLocalizations.current.serviceSomethingWentWrong);
    }
  }

  ///  Lấy thông tin giao dịch sau đó xem/chia sẻ file
  onViewOrShareDocument(TransactionModel value, {bool? isShare = false}) async {
    try {
      showProgress();
      final failureOrTransactionModel =
          await getIt<TransactionRepository>().getTransInfor(value.tranId);
      hideProgress();
      failureOrTransactionModel.fold(
        (l) => {showErrorModal(exceptionHandler(l), callback: () {})},
        (r) {
          FileModel? file = FileModel.fromDoc(r.docs.first);
          if (file == null || (file.data.isEmpty)) {
            showErrorModal(AppLocalizations.current.listFileEmpty,
                callback: () {});
          } else {
            if (isShare == true) {
              onShareFile(file);
            } else {
              onPreviewDocument(file);
            }
          }
        },
      );
    } catch (e, s) {
      hideProgress();
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)),
          callback: () {});
    }
  }

  onShareFile(FileModel file) async {
    await ShareFiles.saveFile(file.data, file.name);
    ShareFiles.shareFiles(file.name);
  }

  onRefresh() async {
    await getTransactionRequests();

    final controller = Get.find<HomeController>();
    final param = {'order': 'InitialDate', 'isDesc': true};
    controller.appRefreshController.refresh(params: param);
  }

  onTapChangeDevice(String credentialId) {
    try {
      waitingConfirmTimer?.cancel();
      Get.find<AppController>().selectTab(0);

      final certificateController = Get.isRegistered<CertificateController>()
          ? Get.find<CertificateController>()
          : Get.put(CertificateController());

      final homeController = Get.find<HomeController>();
      final serial = homeController.listCertificate.value
          ?.firstWhere((element) => element.id == credentialId)
          .serial;

      certificateController.requestChangeDevice(
          id: credentialId, serial: serial ?? "");
    } catch (e) {
      print(e);
    }
  }

  waitingConfirmOnSmartCAApp(TransactionModel transactionModel) async {
    try {
      waitingConfirmTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
        await getTransInfor(transactionModel!.tranId);

        switch (transactionInfo.value?.tranStatus) {
          case 1:
            Get.until((route) => route.isFirst);
            Get.find<AppController>().backToMainPage();
            // return AppLocalizations.current.signedSuccess;
            sendWaitingTransactionResult(transactionInfo.value!.textStatus, 0);
            timer.cancel();
            break;
          case 4000:
            // return AppLocalizations.current.waitingForSignerConfirm;
            break;
          default:
            Get.until((route) => route.isFirst);
            Get.find<AppController>().backToMainPage();
            sendWaitingTransactionResult(transactionInfo.value!.textStatus, 1);
            timer.cancel();
        }
      });
    } catch (e) {
      print(e);
    }
  }

  openSmartCAApp(TransactionModel transactionModel) async {
    final uid = Get.find<AuthController>().currentUser.value?.uid;
    final host = AppConfig.environment == Environment.dev
        ? "http://demorms.vnptit.vn"
        : "https://smartca.vnpt.vn";
    String appUrl =
        "$host/app/?uid=$uid&action=getTransactionDetail&tranId=${transactionModel.tranId}";

    final Uri url = Uri.parse(appUrl);
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  Future<CertModel?> getCertInfoOnDevice(String credentialId,
      {bool showNotify = true, TransactionModel? transactionModel}) async {
    final certModel =
        await _userInfoOnDeviceService.getCerCurrentUserByIdCer(credentialId);

    if (certModel == null ||
        (certModel?.privateKey == null && certModel.otpSecret == null)) {
      if (showNotify == true) {
        Get.to(
          () => WaitingConfirmBySmartCAAppScreen(
            label: AppLocalizations.current.KAKNotFound,
            transactionModel: transactionModel,
            onChangeDevice: () => onTapChangeDevice(credentialId),
            openSmartCAApp: () => openSmartCAApp(transactionModel!),
            waitingConfirmOnApp: () =>
                waitingConfirmOnSmartCAApp(transactionModel!),
          ),
        );
      }

      return null;
    }
    return certModel;
  }

  sendWaitingTransactionResult(String msg, int code) {
    if (Get.find<AppController>().currentHostAppMethod.value !=
        MethodChannelNames.getWaitingTransaction) {
      return;
    }

    SmartCaResult data = code != 0
        ? SmartCaResult.sendError(msg)
        : SmartCaResult(
            ResultCode.SUCCESS_CODE,
            ResultCodeDesc.SUCCESS,
          );

    getIt<MethodChannelHandler>().send(
      method: MethodChannelNames.getWaitingTransactionResult,
      data: data,
    );

    if (Get.isDialogOpen == true) Get.back();

    NavigatorHandler.closeSDK();
  }

  handleBack() {
    sendWaitingTransactionResult('USER_CANCELED', 1);
    Get.back();
    return true;
  }

  onPressCommand(TransactionModel transactionModel, TransactionType type,
      {bool needGetDetail = false}) async {
    final authController = Get.find<AuthController>();
    bool authenticated = false;
    if (authController.currentUser.value?.useBiometric == true) {
      authenticated = await useBiometricWithTransaction(type, transactionModel,
          needGetDetail: needGetDetail);

      if (authenticated == true) return;
    }

    Get.dialog(
      PINDialogWidget(
          transactionType: type,
          callback: (pin) {
            if (type == TransactionType.confirm) {
              getDetailAndConfirmWaitingTransaction(pin, transactionModel);
            } else {
              rejectWaitingTransaction(pin, transactionModel);
            }
          }),
      barrierDismissible: false,
    );
  }

  getOTPSecret(String credentialId) async {
    try {
      final TransactionRepositoryEseal transactionRepositoryEseal =
          getIt<TransactionRepositoryEseal>();
      final userInfoOnDeviceService = getIt<UserInfoOnDeviceService>();

      final authController = Get.find<AuthController>();

      final currentUser = authController.currentUser.value;
      final certModel =
          await userInfoOnDeviceService.getCerCurrentUserByIdCer(credentialId);

      if (certModel == null || certModel.otpSecret == null) {
        showNotifyModal(AppLocalizations.current.KAKNotFound,
            titleBtnAccept: AppLocalizations.current.changeDevice,
            titleBtnCancel: AppLocalizations.current.searchFaq,
            showFaq: true,
            actionAccept: () {},
            onlyActionCancel: false);

        return null;
      }

      var param = {
        'uid': currentUser!.uid,
        'pin': certModel.pin,
        'showQr': true,
        'credentialId': credentialId,
      };

      final failureOrConfirmed =
          await transactionRepositoryEseal.eSealGetCode(param);

      SmartCAApiResponse<dynamic>? resp;

      failureOrConfirmed.fold((l) => throw l, (_resp) => resp = _resp);

      final totpBasicSpec = resp?.content['totpBasicSpec'];
      final cert =
          await userInfoOnDeviceService.getCerCurrentUserByIdCer(credentialId);
      final newTOTP = base32.encode(base64Decode(totpBasicSpec['totp']));

      if (cert?.otpSecret != newTOTP) {
        cert?.otpSecret = newTOTP;
        await userInfoOnDeviceService.addOrUpdateCert(currentUser.uid, cert!);
      }
    } catch (e, s) {
      rethrow;
    }
  }

  drawSignature(TransactionModel transactionModel) {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: DrawSignatureWidget(
            callBack: (data) async {
              showProgress();

              String base64Image = base64Encode(data);
              final failureOrConfirmed =
                  await transactionRepository.uploadSignedAcceptance({
                "TranId": transactionModel.tranId,
                "AcceptanceSignatureBase64": base64Image,
              });
              hideProgress();

              failureOrConfirmed.fold(
                (failure) async {
                  showErrorModal(exceptionHandler(failure));
                },
                (r) {
                  Get.until((route) => Get.currentRoute == "/");

                  showSuccessModal(
                    message: AppLocalizations.current.reSignAcceptanceSuccess,
                    titleBtnAccept: AppLocalizations.current.activate,
                    actionAccept: () async {
                      wrongPINCount = 0;
                      showProgress();

                      await Future.delayed(
                        const Duration(seconds: 2),
                        () async {
                          final certificateController =
                              Get.isRegistered<CertificateController>()
                                  ? Get.find<CertificateController>()
                                  : Get.put(CertificateController());

                          final homeController = Get.find<HomeController>();
                          await homeController
                              .getCertificateListWaitingActive();

                          final serial = homeController.listCertificate.value
                              ?.firstWhere((element) =>
                                  element.id == transactionModel.credentialId)
                              .serial;

                          certificateController.requestChangeDevice(
                              id: transactionModel.credentialId,
                              serial: serial ?? "");

                          final appController = Get.find<AppController>();
                          if (appController.selectedIndex.value == 0) {
                            onRefresh();
                          }

                          if (isSystemLinkTrans == false) {
                            appController.backToMainPage();
                          }
                        },
                      );

                      hideProgress();
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  confirmApproveCert(String serial) async {
    showLoading();
    try {
      final failureOrVerified =
          await transactionRepository.confirmApproveCert(serial);
      hideLoading();
      failureOrVerified.fold(
        (failure) => {
          showErrorModal(exceptionHandler(failure)),
        },
        (result) {
          final appController = Get.find<AppController>();
          if (isSystemLinkTrans == false) {
            checkConfirmAcceptance.value = false;
            appController.backToMainPage();
          }
        },
      );
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }
}
