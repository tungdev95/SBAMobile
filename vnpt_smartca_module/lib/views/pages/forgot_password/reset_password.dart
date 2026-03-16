import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/configs/app_config.dart';
import 'package:vnpt_smartca_module/configs/injector/injector.dart';
import 'package:vnpt_smartca_module/core/extensions/string.dart';
import 'package:vnpt_smartca_module/core/services/secure_local_storage.dart';
import 'package:vnpt_smartca_module/views/controller/forgot_password.dart';
import 'package:vnpt_smartca_module/views/i18n/generated_locales/l10n.dart';
import 'package:vnpt_smartca_module/views/utils/color.dart';
import 'package:vnpt_smartca_module/views/utils/config_input_decoration.dart';
import 'package:vnpt_smartca_module/views/widgets/bottom_contact.dart';
import 'package:vnpt_smartca_module/views/widgets/widget.dart';

class ResetPasswordPage extends StatelessWidget {
  final String desc;
  ResetPasswordPage({super.key, required this.desc});

  final controller = Get.find<ForgotPasswordController>();
  final _formKey = GlobalKey<FormBuilderState>();

  final passwordMaxLength = 30;

  final secureLocalDataSource = getIt<SecureLocalStorageService>();
  String password = "";
  TextEditingController newPasswordTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final values = controller.formKey.currentState!.value;

    return BaseScreen(
      loadingWidget: BaseLoading<ForgotPasswordController>(),
      title: AppLocalizations.current.resetPassword,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormBuilder(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseText(
                            "${AppLocalizations.current.idNumber} ${AppLocalizations.current.citizenIdLabel}",
                            isRequired: true,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff08285C),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue: values['uid'],
                            decoration: ConfigInputDecoration().config(""),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          BaseText(
                            AppLocalizations.current.newPassword,
                            isRequired: true,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff08285C),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => FormBuilderTextField(
                              name: "newPassword",
                              obscureText:
                                  controller.obscureTextNewPassword.value,
                              controller: newPasswordTEC,
                              maxLength: passwordMaxLength,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
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
                                  errorText:
                                      AppLocalizations.current.inputRequired(
                                    AppLocalizations.current.newPassword,
                                  ),
                                ),
                                FormBuilderValidators.maxLength(
                                  passwordMaxLength,
                                  errorText: AppLocalizations.current
                                      .maxLength(passwordMaxLength),
                                ),
                                (value) {
                                  if (!value!.isValidPassword || !controller.isValidPasswordNumber(value) || !value.isValidPasswordHasNumber) {
                                    return AppLocalizations
                                        .current.passwordNotValid;
                                  } else if (value == password) {
                                    return AppLocalizations
                                        .current.passwordDuplicate;
                                  }
                                },
                              ]),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          BaseText(
                            AppLocalizations.current.reEnterNewPassword,
                            isRequired: true,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff08285C),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => FormBuilderTextField(
                              name: 'reNewPassword',
                              obscureText: controller
                                  .obscureTextReEnterNewPassword.value,
                              maxLength: passwordMaxLength,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
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
                                  errorText:
                                      AppLocalizations.current.inputRequired(
                                    AppLocalizations.current.reEnterNewPassword,
                                  ),
                                ),
                                FormBuilderValidators.maxLength(
                                  passwordMaxLength,
                                  errorText: AppLocalizations.current
                                      .maxLength(passwordMaxLength),
                                ),
                                (value) {
                                  if (value != newPasswordTEC.text) {
                                    return AppLocalizations
                                        .current.reEnterNewPasswordNotCorrect;
                                  }
                                }
                              ]),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          BaseText(
                            AppLocalizations.current.verificationCode,
                            isRequired: true,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff08285C),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FormBuilderTextField(
                            name: 'otp',
                            maxLength: 6,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                            ],
                            textInputAction: TextInputAction.done,
                            onSubmitted: (value) {
                              if (_formKey.currentState!.saveAndValidate()) {
                                final values = _formKey.currentState!.value;
                                controller.resetPasswordWithOtp(
                                    values['newPassword'], values['otp']);
                              }
                            },
                            decoration: ConfigInputDecoration().config(
                              AppLocalizations.current.enterAnything(
                                  AppLocalizations.current.verificationCode),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: AppLocalizations.current
                                      .inputRequired(
                                          AppLocalizations.current.inputOTP)),
                              FormBuilderValidators.minLength(6,
                                  errorText:
                                      AppLocalizations.current.minLength(6)),
                              FormBuilderValidators.maxLength(6,
                                  errorText:
                                      AppLocalizations.current.maxLength(6)),
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BaseText(
                            desc,
                            textOverflow: TextOverflow.visible,
                            textAlign: TextAlign.justify,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff5768A5),
                          ),
                          SizedBox(height: 10),
                          BaseText(
                            AppLocalizations.current.notice_type_password,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff5768A5),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          AppButtonWidget(
                            label: AppLocalizations.current.confirm,
                            backgroundColor:
                                HexColor(AppConfig.colorPrimaryBtn),
                            doublePadding: 15,
                            onTap: () {
                              if (_formKey.currentState!.saveAndValidate()) {
                                final values = _formKey.currentState!.value;
                                controller.resetPasswordWithOtp(
                                    values['newPassword'], values['otp']);
                              }
                            },
                          ),
                          SizedBox(height: 15),
                          // BaseText(
                          //   AppLocalizations.current.strongPasswordValid,
                          //   fontWeight: FontWeight.w400,
                          //   color: Color(0xff08285C),
                          // ),
                        ],
                      ),
                    ),
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
}
