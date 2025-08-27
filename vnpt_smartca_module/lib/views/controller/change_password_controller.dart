import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../configs/injector/injector.dart';
import '../../core/models/app/exceptions.dart';
import '../../core/services/secure_local_storage.dart';
import '../../core/utils/constants.dart';
import '../../data/repository/change_password_repository.dart';
import '../i18n/generated_locales/l10n.dart';
import '../utils/exception_handler.dart';
import '../widgets/dialog/common_dialog.dart';
import 'auth_controller.dart';
import 'base_controler.dart';

class ChangePasswordController extends BaseController {
  final formKey = GlobalKey<FormBuilderState>();

  RxBool obscureTextPassword = true.obs;
  RxBool obscureTextNewPassword = true.obs;
  RxBool obscureTextReEnterNewPassword = true.obs;

  RxBool changePasswordSuccess = false.obs;

  final changePasswordRepository = getIt<ChangePasswordRepository>();

  onFormSubmit() {
    try {
      if (formKey.currentState!.saveAndValidate()) {
        final values = formKey.currentState!.value;
        changePassword(values["currentPassword"], values["newPassword"]);
      }
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  void changePassword(String currentPassword, String newPassword) async {
    showLoading();
    try {
      final failureOrVerified = await changePasswordRepository.changePassword(
          currentPassword, newPassword);
      hideLoading();
      failureOrVerified.fold(
        (failure) => {
          showErrorModal(exceptionHandler(failure)),
        },
        (result) {
          changePasswordSuccess.value = true;
          showSuccessModal(
            message: AppLocalizations.current.changePassSuccess,
            actionAccept: () {
              // CHANGE PASSWORD SUCCESS
              Navigator.popUntil(Get.context!, (route) => route.isFirst);
              final authController = Get.find<AuthController>();
              authController.currentUser.value?.password = newPassword;
              final _secureLocalDataSource = getIt<SecureLocalStorageService>();
              _secureLocalDataSource.saveData(PASSWORD_KEY, newPassword);

              authController.signOut();
            },
          );
        },
      );
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }
}
