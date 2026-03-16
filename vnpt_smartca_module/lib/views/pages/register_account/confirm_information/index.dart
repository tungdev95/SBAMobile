// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:scale_size/scale_size.dart';
import 'package:vnpt_smartca_module/configs/injector/injector.dart';
import 'package:vnpt_smartca_module/core/services/biometrics.dart';
import '../../../../configs/app_config.dart';
import '../../../../core/extensions/string.dart';
import '../../../controller/auth_controller.dart';
import '../../../utils/common.dart';
import '../../../widgets/base_screen.dart';
import '../../../widgets/base_text.dart';

import '../../../../../core/models/app/province_model.dart';
import '../../../../../core/models/app/wards_model.dart';
import '../../../../../core/models/request/ekyc_result_model.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../gen/assets.gen.dart';
import '../../../controller/buy_certificate_controller.dart';
import '../../../controller/confirm_information_controller.dart';
import '../../../controller/enter_info_controller.dart';
import '../../../i18n/generated_locales/l10n.dart';
import '../../../utils/config_input_decoration.dart';
import '../../../widgets/app_button_widget.dart';
import '../../../widgets/base_edit_text.dart';
import '../../../widgets/base_loading.dart';
import '../../../widgets/typehead_formfield_custom.dart';

class ConfirmInformationPage extends StatefulWidget {
  final bool fromEKYC;
  final EkycResponseModel ekycResponseModel;

  const ConfirmInformationPage(
      {Key? key, required this.ekycResponseModel, this.fromEKYC = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ConfirmInformationState();
}

class ConfirmInformationState extends State<ConfirmInformationPage> {
  final controller = Get.put(ConfirmInformationController());
  final controllerAddress = Get.put(EnterInfoController());
  final controllerEkyc = Get.put(BuyCertificateController());
  final authController = Get.find<AuthController>();

  final maxLength250 = 250;
  final maxLength12 = 12;
  final maxLength6 = 6;
  bool showViewAddress = false;
  bool showViewPolicy = false;

  String nameBusiness = "";
  String citizenId = "";

  late EkycResponseModel ekycResponseModel;

  final passwordMaxLength = 250;

  bool registered3rd = false;
  final biometricService = getIt<BiometricsService>();
  bool isSwitched = true;
  bool isDeviceSupported = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      checkSupportBiometric();
      await controllerAddress.getAllWards();
      updateDataText(updateAddressOnDocument: true);
    });

    ekycResponseModel = widget.ekycResponseModel;
    controllerEkyc.ekycErrorCount = 0;
    controller.emailTEC.text = ekycResponseModel.email?.trim() ?? "";
    controller.phoneTEC.text = ekycResponseModel.phone?.trim() ?? "";
    registered3rd = ekycResponseModel.registered3rd == true;

    if (AppConfig.password != "") {
      controller.passwordTEC.text = AppConfig.password;
    }

    if (AppConfig.customerEmail != "") {
      controller.emailTEC.text = AppConfig.customerEmail;
    }
  }

  checkSupportBiometric() async {
    final isSupported = await biometricService.isDeviceSupported();

    final availableBiometrics =
        (await biometricService.getAvailableBiometrics()).isNotEmpty;

    setState(() {
      isDeviceSupported = isSupported;
      isSwitched = availableBiometrics;
    });
  }

  Widget switchBiometric() {
    return Platform.isAndroid
        ? Switch(
            value: isSwitched,
            onChanged: onActiveBiometric,
            activeColor: Color(0xff0D75D6),
          )
        : CupertinoSwitch(
            value: isSwitched,
            onChanged: onActiveBiometric,
            activeColor: Color(0xff0D75D6),
          );
  }

  onActiveBiometric(value) {
    isSwitched = !isSwitched;
    setState(() {});
  }

  updateDataText({bool updateAddressOnDocument = false}) {
    nameBusiness = ekycResponseModel.ocrResult.name;
    citizenId = ekycResponseModel.ocrResult.id;

    String provinceStr = ekycResponseModel.ocrResult.city?.capitalize ?? "";
    String districtStr = ekycResponseModel.ocrResult.district?.capitalize ?? "";
    String wardsStr = ekycResponseModel.ocrResult.ward?.capitalize ?? "";
    String addressDetailStr =
        ekycResponseModel.ocrResult.recentlyLocation ?? "";

    controller.nameTEC.text = nameBusiness.toUpperCase();
    controller.uidTEC.text = Common.removeSuffixInUid(citizenId);
    controller.provinceTEC.text = "";

    if (controllerAddress.validateProvinces(provinceStr) == null) {
      controller.provinceTEC.text = provinceStr;
    }
    if (controllerAddress.validateWards(wardsStr) == null) {
      controller.provinceTEC.text += ", $wardsStr";
    }

    if (updateAddressOnDocument) {
      controller.addressOnDocumentTEC.text =
          "$provinceStr${districtStr != "" ? ", $districtStr" : ""}${wardsStr != "" ? ", $wardsStr" : ""}";

      if (controller.addressOnDocumentTEC.text.isEmpty) {
        controller.addressOnDocumentTEC.text =
            ekycResponseModel.ocrResult.originLocation.capitalize ?? "";
      }
    }
    controller.addressDetailTEC.text = addressDetailStr;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      loadingWidget: BaseLoading<ConfirmInformationController>(),
      title: AppLocalizations.current.confirmInformation,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 10, left: 15, right: 15),
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
                                AppLocalizations
                                    .current.informationRegistration,
                                color: Color(0xff0D75D6),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: 8),
                              BaseText(
                                AppLocalizations.current.nameBusinessPersonal,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff08285C),
                              ),
                              SizedBox(height: 2),
                              FormBuilderTextField(
                                name: 'nameBusiness',
                                controller: controller.nameTEC,
                                readOnly: true,
                                decoration: ConfigInputDecoration().config("",
                                    vertical: 8, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 8),
                              BaseText(
                                AppLocalizations.current.citizenIdFullLabel,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff08285C),
                              ),
                              SizedBox(height: 2),
                              FormBuilderTextField(
                                name: 'citizenId',
                                controller: controller.uidTEC,
                                readOnly: true,
                                decoration: ConfigInputDecoration().config("",
                                    vertical: 8, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 8),
                              BaseText(
                                AppLocalizations.current.addressOnDocuments,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff08285C),
                              ),
                              SizedBox(height: 2),
                              FormBuilderTextField(
                                name: 'addressOnDocuments',
                                controller: controller.addressOnDocumentTEC,
                                readOnly: true,
                                decoration: ConfigInputDecoration().config("",
                                    vertical: 8, fontWeight: FontWeight.w600),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                color: Color(0xFFDDE3EC),
                                height: 1,
                              ),
                              BaseText(
                                AppLocalizations.current.addressInfo,
                                color: Color(0xff0D75D6),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: 8),
                              BaseText(
                                AppLocalizations.current.addressInfo,
                                isRequired: true,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff08285C),
                              ),
                              SizedBox(height: 4),
                              Stack(
                                children: [
                                  FormBuilderTextField(
                                    name: 'address',
                                    readOnly: true,
                                    controller: controller.provinceTEC,
                                    decoration: registered3rd
                                        ? ConfigInputDecoration().config("")
                                        : ConfigInputDecoration().config(
                                            AppLocalizations
                                                .current.addressFullLabel,
                                            fillColor: Colors.white,
                                            borderColor: Color(0xffCADCEE),
                                          ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                          errorText: AppLocalizations.current
                                              .inputRequired(AppLocalizations
                                                  .current.addressInfo)),
                                      FormBuilderValidators.minLength(10,
                                          errorText: AppLocalizations.current
                                              .minLength(5)),
                                    ]),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (registered3rd) {
                                        return;
                                      }
                                      setState(() {
                                        showViewAddress = true;
                                      });
                                    },
                                    child: SizedBox(width: 1.width, height: 45),
                                  )
                                ],
                              ),
                              SizedBox(height: 8),
                              BaseText(
                                AppLocalizations.current.detail,
                                isRequired: true,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff08285C),
                              ),
                              SizedBox(height: 4),
                              FormBuilderTextField(
                                name: 'detailAddress',
                                enableSuggestions: true,
                                controller: controller.addressDetailTEC,
                                readOnly: false,
                                decoration: ConfigInputDecoration().config(
                                  AppLocalizations.current.detailAddress,
                                  fillColor: Colors.white,
                                  borderColor: Color(0xffCADCEE),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: AppLocalizations.current
                                          .inputRequired(AppLocalizations
                                              .current.detailAddress)),
                                  FormBuilderValidators.maxLength(maxLength250,
                                      errorText: AppLocalizations.current
                                          .maxLength(maxLength250)),
                                ]),
                              ),
                              SizedBox(height: 8),
                              BaseText(
                                AppLocalizations.current.noteInformationAddress,
                                color: Color(0xff5768A5),
                                fontSize: 13,
                                textAlign: TextAlign.justify,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                color: Color(0xFFDDE3EC),
                                height: 1,
                              ),
                              BaseText(
                                AppLocalizations.current.contactInfo,
                                color: Color(0xff0D75D6),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: 10),
                              BaseText(
                                AppLocalizations.current.emailOnly,
                                isRequired: true,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff08285C),
                              ),
                              SizedBox(height: 4),
                              FormBuilderTextField(
                                name: 'email',
                                textInputAction: TextInputAction.next,
                                controller: controller.emailTEC,
                                maxLength: maxLength250,
                                readOnly: ekycResponseModel.source ==
                                        AccountSources.vneid
                                    ? false
                                    : registered3rd,
                                decoration: (ekycResponseModel.source ==
                                            AccountSources.vneid
                                        ? false
                                        : registered3rd)
                                    ? ConfigInputDecoration().config("")
                                    : ConfigInputDecoration().config(
                                        AppLocalizations.current.emailOnly,
                                        fillColor: Colors.white,
                                        borderColor: Color(0xffCADCEE),
                                      ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: AppLocalizations.current
                                          .inputRequired(
                                              AppLocalizations.current.email)),
                                  FormBuilderValidators.maxLength(maxLength250,
                                      errorText: AppLocalizations.current
                                          .maxLength(maxLength250)),
                                  (value) {
                                    if (!value!.trim().isValidEmail) {
                                      return AppLocalizations.current
                                          .certificate_package_validate_emailr_error;
                                    }
                                  },
                                ]),
                              ),
                              SizedBox(height: 8),
                              BaseText(
                                AppLocalizations.current.phone,
                                isRequired: true,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff08285C),
                              ),
                              SizedBox(height: 4),
                              FormBuilderTextField(
                                name: 'phone',
                                readOnly: true,
                                controller: controller.phoneTEC,
                                maxLength: maxLength12,
                                decoration: ConfigInputDecoration()
                                    .config(AppLocalizations.current.phone),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: AppLocalizations.current
                                          .inputRequired(
                                              AppLocalizations.current.phone)),
                                  FormBuilderValidators.maxLength(maxLength12,
                                      errorText: AppLocalizations.current
                                          .maxLength(maxLength12)),
                                  (value) {
                                    if (!value!.trim().isValidPhone) {
                                      return AppLocalizations.current
                                          .certificate_package_validate_phone_error;
                                    }
                                  },
                                ]),
                              ),
                              SizedBox(height: 8),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                color: Color(0xFFDDE3EC),
                                height: 1,
                              ),
                              BaseText(
                                AppLocalizations.current.setupPasswordAccount,
                                color: Color(0xff0D75D6),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: 10),
                              BaseText(
                                AppLocalizations.current.password,
                                isRequired: true,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff08285C),
                              ),
                              SizedBox(height: 4),
                              Obx(
                                () => FormBuilderTextField(
                                  name: 'password',
                                  obscureText:
                                      controller.obscureTextPassword.value,
                                  controller: controller.passwordTEC,
                                  maxLength: passwordMaxLength,
                                  textInputAction: TextInputAction.next,
                                  decoration: ConfigInputDecoration().config(
                                    AppLocalizations.current.enterPassword,
                                    fillColor: Colors.white,
                                    borderColor: Color(0xffCADCEE),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.obscureTextPassword.value =
                                            !controller
                                                .obscureTextPassword.value;
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
                                                .current.password)),
                                    FormBuilderValidators.maxLength(
                                        passwordMaxLength,
                                        errorText: AppLocalizations.current
                                            .maxLength(passwordMaxLength)),
                                    (value) {
                                      if (!value!.isValidPassword ||
                                          !value.isValidPasswordHasNumber) {
                                        return AppLocalizations
                                            .current.passwordNotValid;
                                      }
                                    },
                                  ]),
                                  onEditingComplete: () {
                                    controller.formKey.currentState
                                        ?.fields["rePassword"]
                                        ?.focus();
                                  },
                                ),
                              ),
                              SizedBox(height: 8),
                              BaseText(
                                AppLocalizations.current.reEnterPassword,
                                isRequired: true,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff08285C),
                              ),
                              SizedBox(height: 4),
                              Obx(
                                () => FormBuilderTextField(
                                  name: 'rePassword',
                                  maxLength: passwordMaxLength,
                                  obscureText:
                                      controller.obscureTextRePassword.value,
                                  initialValue: AppConfig.password != ""
                                      ? AppConfig.password
                                      : null,
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (value) => controller
                                      .onFormSubmit(ekycResponseModel),
                                  decoration: ConfigInputDecoration().config(
                                    AppLocalizations.current.reEnterPassword,
                                    fillColor: Colors.white,
                                    borderColor: Color(0xffCADCEE),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.obscureTextRePassword.value =
                                            !controller
                                                .obscureTextRePassword.value;
                                      },
                                      icon: Icon(
                                          controller.obscureTextRePassword.value
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                      color: Color(0xff5768A5),
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: AppLocalizations.current
                                            .inputRequired(AppLocalizations
                                                .current.reEnterPassword)),
                                    FormBuilderValidators.maxLength(
                                        passwordMaxLength,
                                        errorText: AppLocalizations.current
                                            .maxLength(passwordMaxLength)),
                                    (value) {
                                      if (controller.formKey.currentState!
                                              .fields['password']?.value !=
                                          value) {
                                        return AppLocalizations
                                            .current.passwordNotMatch;
                                      }
                                    }
                                  ]),
                                ),
                              ),
                              SizedBox(height: 10),
                              if (isDeviceSupported)
                                Row(
                                  children: [
                                    switchBiometric(),
                                    SizedBox(width: 5),
                                    BaseText(
                                      AppLocalizations.current.use_bio,
                                      color: Color(0xff0D75D6),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              BaseText(
                                AppLocalizations.current.notice_type_password,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff5768A5),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      spreadRadius: 0,
                      blurRadius: 12,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: Container(
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: AppButtonWidget(
                          label: AppLocalizations.current.retry,
                          labelColor: Color(0xff0D75D6),
                          backgroundColor: Color(0xffE0F0FF),
                          doublePadding: 15,
                          onTap: () {
                            controllerEkyc.isFlowRegister = true;
                            controllerEkyc.uid = ekycResponseModel.ocrResult.id;
                            controllerEkyc.eKycUserEnroll().then((value) {
                              debugPrint("result ekyc >>>>: $value");

                              if (value == VerifyInfoType.error3times) {
                                // back to danh sach chung thu so
                                // Get.back();
                              } else if (value is EkycResponseModel) {
                                // todo ekyc success
                                debugPrint("eKYC success: $value");
                                setState(() {
                                  ekycResponseModel.ekycCode = value.ekycCode;
                                  ekycResponseModel.ekycExpiredTime =
                                      value.ekycExpiredTime;
                                  ekycResponseModel.ocrResult = value.ocrResult;
                                  updateDataText();
                                });
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        flex: 1,
                        child: AppButtonWidget(
                          label: AppLocalizations.current.Continue,
                          doublePadding: 15,
                          onTap: () async {
                            controller.onFormSubmit(ekycResponseModel,
                                isUseBio: isSwitched);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          showViewAddress ? showAddress() : Container(),
        ],
      ),
    );
  }

  Widget showAddress() {
    ekycResponseModel.ocrResult.recentlyLocation =
        controller.addressDetailTEC.text;
    String provinceStr = ekycResponseModel.ocrResult.city?.capitalize ?? "";
    String wardsStr = ekycResponseModel.ocrResult.ward?.capitalize ?? "";
    String addressDetailStr =
        ekycResponseModel.ocrResult.recentlyLocation?.capitalize ?? "";

    controllerAddress.txtProvinceController.text = provinceStr;
    controllerAddress.txtWardController.text = wardsStr;
    controllerAddress.txtAddressController.text = addressDetailStr;

    ProvinceModel provinceModel = ProvinceModel(
      provinceId: int.parse(ekycResponseModel.ocrResult.cityId ?? "0"),
      provinceName: provinceStr,
    );

    WardsModel wardsModel = WardsModel(
      wardId: int.parse(ekycResponseModel.ocrResult.wardId ?? "0"),
      wardName: wardsStr,
    );

    return Container(
      height: 1.height,
      alignment: Alignment.bottomCenter,
      color: Colors.black.withOpacity(0.3),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
              child: FormBuilder(
                key: controllerAddress.formKey1,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BaseText(
                            AppLocalizations.current.update_info_title,
                            color: Color(0xff08285C),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                showViewAddress = false;
                              });
                            },
                            child: Container(
                              width: 25,
                              height: 25,
                              alignment: Alignment.centerRight,
                              child: Assets.images.icClose.svg(
                                width: 15,
                                height: 14,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      color: Color(0xffE0E0E0),
                      height: 1,
                    ),
                    TypeAheadFormFieldCustom(
                      labelText: AppLocalizations.current.provinceCity,
                      controller: controllerAddress.txtProvinceController,
                      suggestionsCallback: (pattern) {
                        return controllerAddress
                            .getProvinceSuggestions(pattern);
                      },
                      onSelectedCallback: (option) {
                        ProvinceModel province = option as ProvinceModel;
                        provinceModel = province;
                        controllerAddress.txtProvinceController.text =
                            province.name;
                        controllerAddress.txtWardController.text = "";
                        return province.name;
                      },
                      validator: (value) {
                        return controllerAddress.validateProvinces(value);
                      },
                    ),
                    SizedBox(height: 16),
                    TypeAheadFormFieldCustom(
                      labelText: AppLocalizations.current.wards,
                      controller: controllerAddress.txtWardController,
                      suggestionsCallback: (pattern) {
                        return controllerAddress.getWardSuggestions(pattern);
                      },
                      onSelectedCallback: (option) {
                        WardsModel wards = option as WardsModel;
                        wardsModel = wards;
                        controllerAddress.txtWardController.text = wards.name;
                        return wards.name;
                      },
                      validator: (value) {
                        return controllerAddress.validateWards(value);
                      },
                    ),
                    SizedBox(height: 16),
                    BaseEditText(
                      label: AppLocalizations.current.addressDetail,
                      controller: controllerAddress.txtAddressController,
                      isRequired: true,
                      formName: "",
                      maxLength: maxLength250,
                      placeHolder: "",
                      textInputAction: TextInputAction.done,
                      // initValue: "",
                    ),
                    SizedBox(height: 16),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: AppButtonWidget(
                        label: AppLocalizations.current.complete,
                        doublePadding: 15,
                        onTap: () {
                          if (controllerAddress.formKey1.currentState!
                              .saveAndValidate()) {
                            ekycResponseModel.ocrResult.city =
                                provinceModel.provinceName;
                            ekycResponseModel.ocrResult.cityId =
                                provinceModel.provinceId.toString();
                            ekycResponseModel.ocrResult.ward =
                                wardsModel.wardName;
                            ekycResponseModel.ocrResult.wardId =
                                wardsModel.wardId.toString();
                            ekycResponseModel.ocrResult.recentlyLocation =
                                controllerAddress.txtAddressController.text;
                            updateDataText();
                            showViewAddress = false;
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
