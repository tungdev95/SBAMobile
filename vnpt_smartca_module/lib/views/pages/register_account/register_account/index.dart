// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import '../../../../configs/app_config.dart';
import '../../../../core/extensions/string.dart';
import '../../../utils/color.dart';
import '../../../widgets/base_screen.dart';
import '../../../widgets/base_text.dart';

import '../../../../gen/assets.gen.dart';
import '../../../controller/register_account_controller.dart';
import '../../../i18n/generated_locales/l10n.dart';
import '../../../utils/config_input_decoration.dart';
import '../../../widgets/app_button_widget.dart';
import '../../../widgets/base_loading.dart';
import '../../../widgets/bottom_contact.dart';
import '../../../widgets/custom_dropdown.dart';
import '../tutorial_register_account/index.dart';

StreamSubscription? checkUidResponse;

class RegisterAccountPage extends StatelessWidget {
  final controller = Get.put(RegisterAccountController());

  final passwordMaxLength = 250;
  final maxLength12 = 12;
  final maxLength10 = 10;
  final maxLength8 = 8;
  int maxLengthIdentifier = 16;
  int minLengthIdentifier = 12;
  int indexDropDownSelected = 0;

  @override
  Widget build(BuildContext context) {
    controller.txtTypeCardController.text =
        AppLocalizations.current.citizenIdentification;

    return BaseScreen(
      loadingWidget: BaseLoading<RegisterAccountController>(),
      title: AppLocalizations.current.certificate_package_register_account,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 30, left: 15, right: 15),
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
                            AppLocalizations.current.registrationCardType,
                            isRequired: true,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5,
                            color: Color(0xff08285C),
                          ),
                          SizedBox(height: 10),
                          CustomDropDown(
                            selectedIndex: indexDropDownSelected,
                            didSelected: (index) async {
                              if (index != indexDropDownSelected) {
                                indexDropDownSelected = index;
                                maxLengthIdentifier = indexDropDownSelected == 0
                                    ? 12
                                    : (indexDropDownSelected == 1 ? 10 : 20);
                                minLengthIdentifier = indexDropDownSelected == 0
                                    ? 12
                                    : (indexDropDownSelected == 1 ? 7 : 10);
                                controller.typeDocumentSelected.value =
                                    indexDropDownSelected == 0
                                        ? TypeDocument.cccd
                                        : (indexDropDownSelected == 1
                                            ? TypeDocument.hc
                                            : TypeDocument.mst);
                                await Future.delayed(
                                    const Duration(milliseconds: 200));
                                controller.formKey.currentState!
                                    .saveAndValidate();
                              }
                            },
                            listValues: controller.listStrTypeCard,
                            isEnable: AppConfig.customerId != "" ? false : true,
                          ),
                          SizedBox(height: 20),
                          BaseText(
                            AppLocalizations.current.idNumber,
                            isRequired: true,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5,
                            color: Color(0xff08285C),
                          ),
                          SizedBox(height: 10),
                          Obx(
                            () => FormBuilderTextField(
                              name: 'identifier',
                              controller: controller.identifierTEC.value,
                              readOnly:
                                  AppConfig.customerId != "" ? true : false,
                              maxLength: maxLengthIdentifier,
                              keyboardType:
                                  controller.typeDocumentSelected.value ==
                                          TypeDocument.cccd
                                      ? TextInputType.streetAddress
                                      : controller.typeDocumentSelected.value ==
                                              TypeDocument.hc
                                          ? TextInputType.streetAddress
                                          : TextInputType.streetAddress,
                              textInputAction: TextInputAction.next,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(
                                    indexDropDownSelected == 1
                                        ? '[a-zA-Z0-9_]'
                                        : (indexDropDownSelected == 0
                                            ? '[0-9_]'
                                            : '[0-9_-]')))
                              ],
                              decoration: ConfigInputDecoration().config(
                                AppLocalizations.current.usernamePlacehoder,
                                // suffixIcon: indexDropDownSelected != 0
                                //     ? null
                                //     : IconButton(
                                //         onPressed: () {
                                //           Get.to(() => ScanQRCodeScreen())
                                //               ?.then((value) {
                                //             if (value is String &&
                                //                 value.isNotEmpty) {
                                //               controller.identifierTEC.value
                                //                   .text = value;
                                //             }
                                //           });
                                //         },
                                //         icon: Assets.images.icScanQr.image(
                                //             width: 24,
                                //             height: 24,
                                //             fit: BoxFit.fill),
                                //         color: Color(0xff0D75D6),
                                //       ),
                              ),
                              onChanged: (text) {
                                controller.checkEnableContinueButton();
                              },
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: AppLocalizations.current
                                        .inputRequired(AppLocalizations
                                            .current.usernamePlacehoder)),
                                FormBuilderValidators.minLength(
                                    minLengthIdentifier,
                                    errorText: AppLocalizations.current
                                        .minLength(minLengthIdentifier)),
                                FormBuilderValidators.maxLength(
                                    maxLengthIdentifier,
                                    errorText: AppLocalizations.current
                                        .maxLength(maxLengthIdentifier)),
                                // (value) {
                                // if (controller.typeDocumentSelected.value ==
                                //         TypeDocument.hc &&
                                //     !value!.isValidPassport) {
                                //   return AppLocalizations
                                //       .current.validate_passport_error;
                                // } else if (maxLengthIdentifier == 13 && value?.length != 10 && value?.length != 13) {
                                //   return AppLocalizations.current
                                //       .enoughLength(AppLocalizations.current.validate10or13);
                                // }
                                // },
                              ]),
                            ),
                          ),
                          SizedBox(height: 10),
                          BaseText(
                            AppLocalizations.current.noteIdentifier,
                            color: Color(0xff5768A5),
                          ),
                          SizedBox(height: 20),
                          BaseText(
                            AppLocalizations.current.phone,
                            isRequired: true,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff08285C),
                          ),
                          SizedBox(height: 10),
                          FormBuilderTextField(
                            name: 'phone',
                            textInputAction: TextInputAction.done,
                            onSubmitted: (value) => controller.onFormSubmit(),
                            controller: controller.phoneTEC,
                            maxLength: maxLength10,
                            keyboardType: TextInputType.phone,
                            readOnly:
                                AppConfig.customerPhone != "" ? true : false,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                            ],
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: ConfigInputDecoration().config(
                                AppLocalizations.current
                                    .certificate_packageuser_form_contact_certificate_info_item_phone_hint_text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: AppLocalizations.current
                                      .inputRequired(
                                          AppLocalizations.current.phone)),
                              FormBuilderValidators.maxLength(maxLength12,
                                  errorText: AppLocalizations.current
                                      .maxLength(maxLength12)),
                              (value) {
                                if (!value!.isValidPhone) {
                                  return AppLocalizations.current
                                      .certificate_package_validate_phone_error;
                                }
                              },
                            ]),
                            onChanged: (text) {
                              controller.checkEnableContinueButton();
                              if (text == " ") {
                                return;
                              }
                            },
                          ),
                          SizedBox(height: 10),
                          BaseText(
                            AppLocalizations.current.notePhoneNumber,
                            color: Color(0xff5768A5),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        Get.to(() => TutorialRegisterAccountPage());
                      },
                      child: Row(
                        children: [
                          Assets.images.messageQuestion.image(
                            width: 20,
                            height: 20,
                            fit: BoxFit.fill,
                            color: HexColor(AppConfig.colorPrimaryBtn),
                          ),
                          SizedBox(width: 5),
                          BaseText(
                            AppLocalizations.current.tutorialRegisterAccount,
                            color: HexColor(AppConfig.colorPrimaryBtn),
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Obx(() {
              return AppButtonWidget(
                backgroundColor: controller.continueEnable.value == true ? HexColor(AppConfig.colorPrimaryBtn) : Colors.grey,
                label: AppLocalizations.current.next,
                doublePadding: 15,
                onTap: () {
                  if (controller.continueEnable.value == true) {
                    controller.onFormSubmit();
                  }
                },
              );
            }),
          ),
          SizedBox(height: 10),
          BottomContact(),
        ],
      ),
    );
  }
}

class TypeCardModel {
  int id;
  String name;

  TypeCardModel(this.id, this.name);
}
