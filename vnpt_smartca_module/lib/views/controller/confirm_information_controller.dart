import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/configs/app_config.dart';
import 'package:vnpt_smartca_module/views/controller/register_account_controller.dart';
import 'package:vnpt_smartca_module/views/pages/privacy_policy/index.dart';
import '../../../configs/injector/injector.dart';
import '../../../core/models/app/exceptions.dart';
import '../../../core/models/response/check_uid_response.dart';
import '../../../views/controller/base_controler.dart';
import '../../../views/utils/exception_handler.dart';
import '../../../views/widgets/dialog/common_dialog.dart';

import '../../core/models/app/identity_card_model.dart';
import '../../core/models/request/ekyc_result_model.dart';
import '../../data/repository/confirm_information_repository.dart';
import '../i18n/generated_locales/l10n.dart';
import '../widgets/dialog_notification.dart';
import 'auth_controller.dart';

class ConfirmInformationController extends BaseController {
  final formKey = GlobalKey<FormBuilderState>();
  final formKeyOTP = GlobalKey<FormBuilderState>();

  final confirmInformationRepository = getIt<ConfirmInformationRepository>();

  RxString identifier = "".obs;
  RxBool obscureTextPassword = true.obs;
  RxBool obscureTextRePassword = true.obs;

  RxString statusAccount = "".obs;
  RxBool isCheckDontWant = false.obs;

  TextEditingController nameTEC = TextEditingController();
  TextEditingController uidTEC = TextEditingController();
  TextEditingController provinceTEC = TextEditingController();
  TextEditingController addressDetailTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  TextEditingController addressOnDocumentTEC = TextEditingController();

  onFormSubmit(EkycResponseModel ekycModel, {bool? isUseBio}) async {
    if (formKey.currentState!.saveAndValidate()) {
      if (isUseBio == true) {
        final authController = Get.find<AuthController>();
        isUseBio =
            await authController.biometricsService.authenticateWithBiometrics();
      }

      if (ekycModel.registered3rd != true) {
        String wardId = (ekycModel.ocrResult.wardId ?? "");
        String cityId = (ekycModel.ocrResult.cityId ?? "");
        String city = (ekycModel.ocrResult.city ?? "");
        String ward = (ekycModel.ocrResult.ward ?? "");
        identifier.value = ekycModel.uid!;

        if ((wardId.isEmpty || wardId == "0") ||
            (cityId.isEmpty || cityId == "0") ||
            city == "" ||
            ward == "") {
          // show dialog
          Get.dialog(DialogNotification(
            content: AppLocalizations.current.addressInvalid,
            onlyActionAccept: true,
            titleBtnAccept: AppLocalizations.current.agree,
          ));
          return;
        }
      }

      ekycModel.email = emailTEC.text.toLowerCase().trim();
      ekycModel.password =
          AppConfig.password != "" ? AppConfig.password : passwordTEC.text;
      ekycModel.ocrResult.recentlyLocation = addressDetailTEC.text;
      ekycModel.ocrResult.street = addressDetailTEC.text.capitalize;
      ekycModel.notAllowReceivedAds = isCheckDontWant.value;
      ekycModel.ocrResult.districtId = "99999";

      if (ekycModel.loaiGiayTo == identityCards[0].name) {
        ekycModel.ocrResult.name = ekycModel.ocrResult.name.capitalize!;
      }

      bool isIndividual = false;

      if (Get.isRegistered<RegisterAccountController>()) {
        final registerAccountController = Get.find<RegisterAccountController>();

        if (registerAccountController.typeDocumentSelected.value !=
            TypeDocument.mst) isIndividual = true;
      } else {
        final authController = Get.find<AuthController>();
        isIndividual = authController.currentUser.value?.accType != 1;
      }

      if (isIndividual == true) {
        Get.to(() => PrivacyPolicy(
              fromScreen: "registerAccount",
              callback: () {
                register(ekycModel, isUseBio: isUseBio);
              },
            ));
      } else {
        register(ekycModel, isUseBio: isUseBio);
      }
    }
  }

  register(EkycResponseModel ekycModel, {bool? isUseBio}) async {
    showLoading();
    try {
      final failureOrVerified =
          await confirmInformationRepository.register(ekycModel);
      hideLoading();
      failureOrVerified.fold(
        (failure) {
          String mess = exceptionHandler(failure);

          if ((failure.error as ServerException).codeDesc ==
              "VERIFY_EKYC_ERROR") {
            showNotifyModal(
              mess,
              titleBtnAccept: AppLocalizations.current.retry,
              titleBtnCancel: AppLocalizations.current.close,
              showFaq: false,
              onlyActionCancel: false,
              actionAccept: () {
                Get.back();
                Get.back();
              },
            );
            return;
          } else if ((failure.error as ServerException).codeDesc ==
              "VERIFY_OTP_ERROR") {
            showNotifyModal(
              mess,
              titleBtnAccept: AppLocalizations.current.retry,
              titleBtnCancel: AppLocalizations.current.close,
              showFaq: false,
              onlyActionCancel: false,
              actionAccept: () {
                Get.back();
                Get.back();
              },
            );
            return;
          }

          showErrorModal(mess);
          return;
        },
        (result) async {
          Get.until((route) => route.isFirst);

          final authController = Get.find<AuthController>();
          authController.currentUser.value = null;
          await authController.signOut();
          await authController.onLogin(ekycModel.uid ?? ekycModel.ocrResult.id,
              ekycModel.password ?? "");
          await authController.toggleAuthBiometrics(
              value: isUseBio, authRequired: false);
        },
      );
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }
}
