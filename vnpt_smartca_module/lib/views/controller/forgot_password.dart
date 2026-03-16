import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/configs/injector/injector.dart';
import 'package:vnpt_smartca_module/core/models/app/exceptions.dart';
import 'package:vnpt_smartca_module/core/models/response/certificate_model.dart';
import 'package:vnpt_smartca_module/core/services/device_info.dart';
import 'package:vnpt_smartca_module/core/services/user_info_on_device.dart';
import 'package:vnpt_smartca_module/data/repository/forgot_password.dart';
import 'package:vnpt_smartca_module/views/controller/base_controler.dart';
import 'package:vnpt_smartca_module/views/i18n/generated_locales/l10n.dart';
import 'package:vnpt_smartca_module/views/pages/forgot_password/reset_password.dart';
import 'package:vnpt_smartca_module/views/utils/exception_handler.dart';
import 'package:vnpt_smartca_module/views/widgets/dialog/common_dialog.dart';

class ForgotPasswordController extends BaseController {
  final formKey = GlobalKey<FormBuilderState>();
  final _deviceInfoService = getIt<DeviceInfoService>();

  RxBool showInfo = false.obs;
  RxBool obscureTextReEnterNewPassword = false.obs;
  RxBool obscureTextNewPassword = false.obs;

  final accountInfo = {}.obs;

  final forgotPasswordRepository = getIt<ForgotPasswordRepository>();

  void onFormSubmit() {
    try {
      if (formKey.currentState!.saveAndValidate()) {
        if (showInfo.value == true) {
          getOTP();
        } else {
          getInfo();
        }
      }
    } catch (e, s) {
      showNotifyModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  void resetPasswordWithOtp(String password, String otp) async {
    try {
      showLoading();

      final values = formKey.currentState!.value;
      final deviceInfo = await _deviceInfoService.getDeviceInfo();

      final param = {
        "Uid": values['uid'].trim(),
        "DeviceID": deviceInfo.deviceId,
        "SendType": values['sendType'],
        "Otp": otp,
        "Password": password
      };

      final failureOrVerified =
          await forgotPasswordRepository.resetPasswordWithOtp(param);
      hideLoading();
      failureOrVerified.fold(
          (failure) => {
                showErrorModal(exceptionHandler(failure)),
              }, (result) {
        showSuccessModal(
          message: AppLocalizations.current.changePassSuccess,
          titleBtnAccept: AppLocalizations.current.close,
          actionAccept: () async {
            try {
              final userInfoOnDeviceService = getIt<UserInfoOnDeviceService>();
              final getCurrentUser =
                  await userInfoOnDeviceService.getUser(values['uid'].trim());
              if (getCurrentUser != null) getCurrentUser.password = password;
            } catch (e) {
              print(e);
            }

            Navigator.popUntil(Get.context!, (route) => route.isFirst);
          },
        );
      });
    } catch (e, s) {
      showNotifyModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  void getInfo() async {
    try {
      showLoading();

      final values = formKey.currentState!.value;

      final failureOrVerified =
          await forgotPasswordRepository.getInfo({"Uid": values['uid'].trim()});
      hideLoading();
      failureOrVerified.fold(
        (failure) => {
          showErrorModal(exceptionHandler(failure)),
        },
        (result) {
          showInfo.value = true;
          accountInfo.value = result.content;
        },
      );
    } catch (e, s) {
      showNotifyModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  void getOTP() async {
    try {
      showLoading();

      final values = formKey.currentState!.value;
      final deviceInfo = await _deviceInfoService.getDeviceInfo();

      final param = {
        "Uid": values['uid'].trim(),
        "DeviceID": deviceInfo.deviceId,
        "sendType": values['sendType'],
      };

      final failureOrVerified = await forgotPasswordRepository.getOTP(param);
      hideLoading();
      failureOrVerified.fold(
          (failure) => {
                showErrorModal(exceptionHandler(failure)),
              }, (result) {
        if (result.code == 0) {
          String desc = "";
          if (values['sendType'] == 1) {
            desc = AppLocalizations.current
                .pleaseCheckForgotPassword("email: ${accountInfo['email']}");
          } else {
            desc = AppLocalizations.current.pleaseCheckForgotPassword(
                "${AppLocalizations.current.phone.toLowerCase()}: ${accountInfo['phone']}");
          }

          Get.to(() => ResetPasswordPage(desc: desc));
        } else {
          showNotifyModal(
              exceptionHandler(GenericException(error: result.message)));
        }
      });
    } catch (e, s) {
      showNotifyModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  bool isValidPasswordNumber(String password) {
    List<RegExpMatch> passwordNumbers = [];
    RegExp isValidNumber = RegExp(r'\d+');
    var req = "0123456789";
    var req1 = "9876543210";
    var req2 = ["Vnpt", "admin", "root", "quantri"];
    passwordNumbers = isValidNumber.allMatches(password).toList();
    for (var passwordNumber in passwordNumbers) {
      String stringNumber = passwordNumber.group(0).toString();
      String temp = "";
      for (var number in stringNumber.characters) {
        temp += "1";
      }
      if (stringNumber.length > 3 &&
          int.parse(stringNumber) % int.parse(temp) == 0) {
        return false;
      }
      if (stringNumber.length > 3 &&
          (req.contains(stringNumber) || req1.contains(stringNumber))) {
        return false;
      }
      for (var reqString in req2) {
        if (password.toLowerCase().contains(reqString.toLowerCase())) {
          return false;
        } else {
          continue;
        }
      }
    }
    return true;
  }
}
