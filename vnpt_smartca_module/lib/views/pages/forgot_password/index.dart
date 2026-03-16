import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/configs/app_config.dart';
import 'package:vnpt_smartca_module/views/controller/forgot_password.dart';
import 'package:vnpt_smartca_module/views/utils/color.dart';
import 'package:vnpt_smartca_module/views/utils/config_input_decoration.dart';
import 'package:vnpt_smartca_module/views/utils/global_key.dart';
import 'package:vnpt_smartca_module/views/widgets/bottom_contact.dart';
import 'package:vnpt_smartca_module/views/widgets/widget.dart';
import '../../i18n/generated_locales/l10n.dart';
class ForgotPasswordPage extends StatelessWidget {
  // ForgotPasswordPage({super.key});
  final controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      loadingWidget: BaseLoading<ForgotPasswordController>(),
      title: AppLocalizations.current.forgotPasswordScreen,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Obx(
                  () => 
                  FormBuilder(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseText(
                          AppLocalizations.current.usernamePlacehoder,
                          isRequired: true,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.5,
                          color: Color(0xff08285C),
                        ),
                        SizedBox(height: 10,),
                        FormBuilderTextField(
                          name: 'uid',
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) => controller.showInfo.value = false,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9-_]'))],
                          decoration: ConfigInputDecoration().config(
                            AppLocalizations.current.inputRequired(
                                AppLocalizations.current.citizenIdLabel),
                          ),
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(
                                errorText: AppLocalizations.current
                                    .inputRequired(AppLocalizations
                                        .current.usernamePlacehoder)),
                              FormBuilderValidators.maxLength(
                                20, errorText: AppLocalizations.current.maxLength(20)),
                              FormBuilderValidators.minLength(7,
                                errorText:
                                    AppLocalizations.current.minLength(7)),
                            ]
                          ),
                        ),
                        if(controller.showInfo.value == true) ...[
                          SizedBox(height: 14,),
                          BaseText(
                            AppLocalizations.current.forgotPasswordNote,
                            textAlign: TextAlign.justify,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff08285C),
                          ),
                          FormBuilderRadioGroup(
                            name: "sendType", 
                            initialValue: 1,
                            orientation: OptionsOrientation.vertical,
                            decoration: InputDecoration(
                                  border: InputBorder.none, isDense: true),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required()]),
                            options: [
                              if(controller.accountInfo['email'] != null) 
                                FormBuilderFieldOption(
                                      value: 1,
                                      child: BaseText(
                                          "${AppLocalizations.current.emailOnly} (${controller.accountInfo['email']})",
                                          fontSize: 15)), 
                              if(controller.accountInfo['phone'] != null)
                                FormBuilderFieldOption(
                                        value: 0,
                                        child: BaseText(
                                            "${AppLocalizations.current.phone} (${controller.accountInfo['phone']})",
                                            fontSize: 15)),
                            ],
                          ),
                        ],
                        SizedBox(height: 10,),
                        AppButtonWidget(
                          label: AppLocalizations.current.next,
                          backgroundColor: HexColor(AppConfig.colorPrimaryBtn),
                          doublePadding: 15,
                          onTap: () {
                            controller.onFormSubmit();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          BottomContact(),
          SizedBox(height: 14),
        ],
      ),
    );
  }
}
