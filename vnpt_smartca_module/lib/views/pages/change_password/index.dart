// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/core/extensions/string.dart';

import '../../../../configs/injector/injector.dart';
import '../../../core/services/secure_local_storage.dart';
import '../../../core/utils/constants.dart';
import '../../controller/change_password_controller.dart';
import '../../i18n/generated_locales/l10n.dart';
import '../../utils/config_input_decoration.dart';
import '../../widgets/app_button_widget.dart';
import '../../widgets/base_loading.dart';
import '../../widgets/base_screen.dart';
import '../../widgets/bottom_contact.dart';
import '../../widgets/widget.dart';

class ChangePasswordPage extends StatelessWidget {
  final controller = Get.put(ChangePasswordController());

  final passwordMaxLength = 30;

  final secureLocalDataSource = getIt<SecureLocalStorageService>();
  String password = "";
  TextEditingController newPasswordTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getPassword();

    return BaseScreen(
      loadingWidget: BaseLoading<ChangePasswordController>(),
      title: AppLocalizations.current.changePassword,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormBuilder(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseText(
                            AppLocalizations.current.currentPassword,
                            isRequired: true,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff08285C),
                          ),
                          SizedBox(height: 10),
                          Obx(
                            () => FormBuilderTextField(
                              name: 'currentPassword',
                              obscureText: controller.obscureTextPassword.value,
                              maxLength: passwordMaxLength,
                              textInputAction: TextInputAction.next,
                              decoration: ConfigInputDecoration().config(
                                AppLocalizations.current.enterCurrentPassword,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.obscureTextPassword.value =
                                        !controller.obscureTextPassword.value;
                                  },
                                  icon: Icon(
                                      controller.obscureTextPassword.value
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                  color: Color(0xff5768A5),
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: AppLocalizations.current
                                        .inputRequired(AppLocalizations
                                            .current.currentPassword)),
                                FormBuilderValidators.maxLength(
                                    passwordMaxLength,
                                    errorText: AppLocalizations.current
                                        .maxLength(passwordMaxLength)),
                                (value) {
                                  if (value != password) {
                                    return AppLocalizations
                                        .current.currentPasswordNotCorrect;
                                  }
                                },
                              ]),
                            ),
                          ),
                          SizedBox(height: 20),
                          BaseText(
                            AppLocalizations.current.newPassword,
                            isRequired: true,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff08285C),
                          ),
                          SizedBox(height: 10),
                          Obx(
                            () => FormBuilderTextField(
                              name: 'newPassword',
                              obscureText:
                                  controller.obscureTextNewPassword.value,
                              controller: newPasswordTEC,
                              maxLength: passwordMaxLength,
                              textInputAction: TextInputAction.next,
                              decoration: ConfigInputDecoration().config(
                                AppLocalizations.current.enterNewPassword,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.obscureTextNewPassword.value =
                                        !controller
                                            .obscureTextNewPassword.value;
                                  },
                                  icon: Icon(
                                      controller.obscureTextNewPassword.value
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                  color: Color(0xff5768A5),
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: AppLocalizations.current
                                        .inputRequired(AppLocalizations
                                            .current.newPassword)),
                                FormBuilderValidators.maxLength(
                                    passwordMaxLength,
                                    errorText: AppLocalizations.current
                                        .maxLength(passwordMaxLength)),
                                (value) {
                                  if (!value!.isValidPassword) {
                                    return AppLocalizations
                                        .current.strongPasswordValid;
                                  } else if (value == password) {
                                    return AppLocalizations
                                        .current.passwordDuplicate;
                                  }
                                },
                              ]),
                            ),
                          ),
                          SizedBox(height: 20),
                          BaseText(
                            AppLocalizations.current.reEnterNewPassword,
                            isRequired: true,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff08285C),
                          ),
                          SizedBox(height: 10),
                          Obx(
                            () => FormBuilderTextField(
                              name: 'reNewPassword',
                              obscureText: controller
                                  .obscureTextReEnterNewPassword.value,
                              maxLength: passwordMaxLength,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (value) => controller.onFormSubmit(),
                              decoration: ConfigInputDecoration().config(
                                AppLocalizations.current.reEnterNewPassword,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.obscureTextReEnterNewPassword
                                            .value =
                                        !controller
                                            .obscureTextReEnterNewPassword
                                            .value;
                                  },
                                  icon: Icon(controller
                                          .obscureTextReEnterNewPassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  color: Color(0xff5768A5),
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: AppLocalizations.current
                                        .inputRequired(AppLocalizations
                                            .current.reEnterNewPassword)),
                                FormBuilderValidators.maxLength(
                                    passwordMaxLength,
                                    errorText: AppLocalizations.current
                                        .maxLength(passwordMaxLength)),
                                (value) {
                                  if (value != newPasswordTEC.text) {
                                    return AppLocalizations
                                        .current.reEnterNewPasswordNotCorrect;
                                  }
                                },
                              ]),
                            ),
                          ),
                          SizedBox(height: 20),
                          AppButtonWidget(
                            label: AppLocalizations.current.changePassword,
                            doublePadding: 15,
                            onTap: () {
                              controller.onFormSubmit();
                            },
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    // SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
          BottomContact(),
        ],
      ),
    );
  }

  getPassword() async {
    password = await secureLocalDataSource.getLastData(PASSWORD_KEY) ?? "";
  }
}
