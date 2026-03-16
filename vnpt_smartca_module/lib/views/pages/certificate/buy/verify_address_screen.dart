// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:scale_size/scale_size.dart';
import 'package:vnpt_smartca_module/configs/app_config.dart';
import 'package:vnpt_smartca_module/views/utils/color.dart';
import '../../../../core/extensions/string.dart';
import '../../../../core/models/response/order_cert_model.dart';
import '../../../controller/auth_controller.dart';
import '../../../utils/common.dart';
import '../../../widgets/base_screen.dart';
import '../../../widgets/base_text.dart';

import '../../../../core/models/app/province_model.dart';
import '../../../../core/models/app/wards_model.dart';
import '../../../../core/models/response/profile_model.dart';
import '../../../../core/models/response/user_address.dart';
import '../../../../gen/assets.gen.dart';
import '../../../controller/buy_certificate_controller.dart';
import '../../../controller/confirm_information_controller.dart';
import '../../../controller/enter_info_controller.dart';
import '../../../i18n/generated_locales/l10n.dart';
import '../../../utils/config_input_decoration.dart';
import '../../../widgets/app_button_widget.dart';
import '../../../widgets/base_edit_text.dart';
import '../../../widgets/base_loading.dart';
import '../../../widgets/dialog_notification.dart';
import '../../../widgets/typehead_formfield_custom.dart';

class VerifyAddressScreen extends StatefulWidget {
  final bool isCanEditInformation;
  // final EkycResponseModel ekycResponseModel;
  final ProfileModel profileModel;
  final OrderCertModel orderCertModel;

  const VerifyAddressScreen(
      {Key? key,
      this.isCanEditInformation = true,
      required this.profileModel,
      required this.orderCertModel})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerifyAddressScreenState();
}

class _VerifyAddressScreenState extends State<VerifyAddressScreen> {
  final controller = Get.put(ConfirmInformationController());
  final controllerAddress = Get.put(EnterInfoController());
  final controllerEkyc = Get.find<BuyCertificateController>();
  final authController = Get.find<AuthController>();
  final maxLength250 = 250;
  final maxLength12 = 12;
  final maxLength6 = 6;
  bool showViewAddress = false;
  // bool showViewOTP = false;

  String nameBusiness = "";
  String citizenId = "";

  String provinceStr = "";
  String districtStr = "";
  String wardsStr = "";
  String addressDetailStr = "";

  // OTP
  late Timer _timer;
  int _timeInt = 300;
  String timeDisplay = "05:00";

  // late EkycResponseModel ekycResponseModel;
  bool isCanEditInformation = true;

  final passwordMaxLength = 250;

  UserAddress? _userAddress = null;

  @override
  void initState() {
    super.initState();
    // ekycResponseModel = widget.ekycResponseModel;
    isCanEditInformation = widget.isCanEditInformation;
    // isCanEditInformation = false;
    isCanEditInformation = widget.orderCertModel.isCreatedBy3rd == false;
    updateDataText();
    controllerEkyc.ekycErrorCount = 0;

    controller.phoneTEC.text = authController.currentUser.value?.phone ?? "";
    controller.emailTEC.text = authController.currentUser.value?.email ?? "";

    ever(controllerEkyc.userAddress, (p0) {
      if (mounted) {
        if (isCanEditInformation == false && p0 != null) {
          if (p0.wardId.isEmpty || p0.wardId == "0") {
            isCanEditInformation = true;
            setState(() {});
          }
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controllerAddress.getAllWards();

      controllerEkyc.getUserAddress(controller.provinceTEC,
          controller.addressDetailTEC, widget.orderCertModel);
    });
  }

  updateDataText() {
    nameBusiness = authController.currentUser.value?.displayName ?? "";
    citizenId = authController.currentUser.value?.uid ?? "";

    controller.nameTEC.text = nameBusiness;
    controller.uidTEC.text = Common.removeSuffixInUid(citizenId);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      loadingWidget: Stack(
        children: [
          BaseLoading<ConfirmInformationController>(),
          BaseLoading<BuyCertificateController>(),
        ],
      ),
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
                              SizedBox(height: 10),
                              BaseText(
                                AppLocalizations.current.nameBusinessPersonal,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff08285C),
                              ),
                              SizedBox(height: 4),
                              FormBuilderTextField(
                                name: 'nameBusiness',
                                // initialValue: nameBusiness,
                                enableSuggestions: true,
                                controller: controller.nameTEC,
                                readOnly: true,
                                decoration: ConfigInputDecoration()
                                    .config("", vertical: 8),
                              ),
                              SizedBox(height: 8),
                              BaseText(
                                AppLocalizations.current.citizenIdFullLabel,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff08285C),
                              ),
                              SizedBox(height: 4),
                              FormBuilderTextField(
                                name: 'citizenId',
                                // initialValue: citizenId,
                                controller: controller.uidTEC,
                                readOnly: true,
                                decoration: ConfigInputDecoration()
                                    .config("", vertical: 8),
                              ),
                              SizedBox(height: 8),
                              BaseText(
                                AppLocalizations.current.addressFullLabel,
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
                                    onTap: () {
                                      if (isCanEditInformation) {
                                        setState(() {
                                          addressDetailStr = controller
                                              .addressDetailTEC.value.text;
                                          showViewAddress = true;
                                        });
                                      }
                                    },
                                    controller: controller.provinceTEC,
                                    decoration: ConfigInputDecoration().config(
                                        AppLocalizations
                                            .current.addressFullLabel,
                                        borderColor: isCanEditInformation
                                            ? Color(0xffA5B0C2)
                                            : null,
                                        fillColor: isCanEditInformation
                                            ? Colors.white
                                            : null),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              BaseText(
                                AppLocalizations.current.detailAddress,
                                isRequired: true,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff08285C),
                              ),
                              SizedBox(height: 4),
                              FormBuilderTextField(
                                name: 'detailAddress',
                                enableSuggestions: true,
                                // initialValue: addressDetailStr,
                                readOnly: !isCanEditInformation,
                                controller: controller.addressDetailTEC,
                                decoration: ConfigInputDecoration().config(
                                    AppLocalizations.current.detailAddress,
                                    borderColor: isCanEditInformation
                                        ? Color(0xffA5B0C2)
                                        : null,
                                    fillColor: isCanEditInformation
                                        ? Colors.white
                                        : null),
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
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                color: Color(0xffC9CED7),
                                height: 1,
                              ),
                              BaseText(
                                AppLocalizations.current.contactInfo,
                                color: Color(0xff0D75D6),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: 8),
                              BaseText(
                                AppLocalizations.current.emailOnly,
                                isRequired: true,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff08285C),
                              ),
                              SizedBox(height: 4),
                              FormBuilderTextField(
                                name: 'email',
                                readOnly: false,
                                textInputAction: TextInputAction.next,
                                controller: controller.emailTEC,
                                maxLength: maxLength250,
                                decoration: ConfigInputDecoration().config(
                                    AppLocalizations.current.emailOnly,
                                    borderColor: Color(0xffA5B0C2),
                                    fillColor: Colors.white),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: AppLocalizations.current
                                          .inputRequired(
                                              AppLocalizations.current.email)),
                                  FormBuilderValidators.maxLength(maxLength250,
                                      errorText: AppLocalizations.current
                                          .maxLength(maxLength250)),
                                  (value) {
                                    if (!value!.isValidEmail) {
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
                                readOnly: false,
                                textInputAction: TextInputAction.done,
                                // onSubmitted: (value) => controller.onFormSubmit(ekycResponseModel),
                                controller: controller.phoneTEC,
                                maxLength: maxLength12,
                                decoration: ConfigInputDecoration().config(
                                    AppLocalizations.current.phone,
                                    borderColor: Color(0xffA5B0C2),
                                    fillColor: Colors.white),
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
                              ),
                              // SizedBox(height: 6),
                              // BaseText(
                              //   AppLocalizations.current.notePhoneNumber,
                              //   color: Color(0xff5768A5),
                              // ),
                              SizedBox(height: 8),
                              // Container(
                              //   margin: EdgeInsets.symmetric(vertical: 14),
                              //   color: Color(0xffC9CED7),
                              //   height: 1,
                              // ),
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
                      EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 25),
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
                            // ekyc again
                            Get.back(result: true);
                          },
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        flex: 1,
                        child: AppButtonWidget(
                          label: AppLocalizations.current.Continue,
                          doublePadding: 15,
                          onTap: () {
                            // controller.onFormSubmit(ekycResponseModel);
                            if (controller.formKey.currentState!
                                .saveAndValidate()) {
                              // setState(() {
                              //   _timeInt = 300;
                              //   timeDisplay = "05:00";
                              //   showViewOTP = true;
                              //   startTimer();
                              // });
                              if (controllerEkyc.userAddress.value == null) {
                                return;
                              }

                              String wardId =
                                  (controllerEkyc.userAddress.value!.wardId ??
                                      "");

                              String cityId = (controllerEkyc
                                      .userAddress.value!.provinceId ??
                                  "");
                              if ((wardId.isEmpty || wardId == "0") ||
                                  (cityId.isEmpty || cityId == "0")) {
                                // show dialog
                                Get.dialog(DialogNotification(
                                  content:
                                      AppLocalizations.current.addressInvalid,
                                  onlyActionAccept: true,
                                  titleBtnAccept:
                                      AppLocalizations.current.agree,
                                  actionAccept: () {
                                    setState(() {
                                      showViewAddress = true;
                                    });
                                  },
                                ));
                                return;
                              }

                              controllerEkyc.userAddress.value!.streetName =
                                  controller.addressDetailTEC.text;
                              controllerEkyc.userAddress.value!.diaChi =
                                  "${controller.addressDetailTEC.text}, ${controllerEkyc.userAddress.value!.wardName}, ${controllerEkyc.userAddress.value!.provinceName}";
                              controllerEkyc.updateUserAddress(
                                  widget.orderCertModel,
                                  controllerEkyc.userAddress.value!,
                                  controller.emailTEC.text,
                                  controller.phoneTEC.text);
                            } else {
                              // todo
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // color: Colors.red,
              )
            ],
          ),
          showViewAddress
              ? showAddress(
                  controllerEkyc.userAddress.value?.provinceName ?? "",
                  controllerEkyc.userAddress.value?.wardName ?? "",
                  controllerEkyc.userAddress.value?.streetName ?? "",
                  controllerEkyc.userAddress.value?.provinceId ?? "",
                  controllerEkyc.userAddress.value?.wardId ?? "",
                )
              : Container(),
          // showViewOTP ? showOTP(controller.phoneTEC.text) : Container()
        ],
      ),
    );
  }

  Widget showAddress(String province, String wards, String addressDetail,
      String provinceId, String wardsId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controllerAddress.getAllWards();
    });

    ProvinceModel? provinceModel = ProvinceModel.fromJson(
        {"provinceId": int.tryParse(provinceId), "provinceName": province});

    WardsModel? wardsModel = WardsModel.fromJson(
        {"wardId": int.tryParse(wardsId), "wardName": wards});

    controllerAddress.txtProvinceController.text = province;
    controllerAddress.txtWardController.text = wards;
    controllerAddress.txtAddressController.text = addressDetail;

    return Container(
      height: 1.height,
      alignment: Alignment.bottomCenter,
      color: Colors.black.withOpacity(0.3),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Spacer(),
            // Expanded(child: Container()),
            Container(
              padding: EdgeInsets.symmetric(vertical: 14),
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
                            AppLocalizations.current.addressOption,
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
                                height: 10,
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
                      backgroundColor: Colors.white,
                      borderColor: Color(0xffA5B0C2),
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
                            provinceStr =
                                controllerAddress.txtProvinceController.text;
                            wardsStr = controllerAddress.txtWardController.text;
                            addressDetailStr =
                                controllerAddress.txtAddressController.text;
                            controller.provinceTEC.text =
                                "$provinceStr, $wardsStr";
                            controller.addressDetailTEC.text = addressDetailStr;

                            _userAddress = UserAddress(
                                provinceId:
                                    provinceModel!.provinceId.toString(),
                                provinceName: provinceModel!.provinceName,
                                wardId: wardsModel!.wardId.toString(),
                                wardName: wardsModel!.wardName.toString(),
                                streetName:
                                    controllerAddress.txtAddressController.text,
                                diaChi:
                                    "${controllerAddress.txtAddressController.text}, ${wardsModel!.wardName.toString()}, ${provinceModel!.provinceName}");

                            controllerEkyc.localUpdateUserAddress(
                                _userAddress!,
                                controller.provinceTEC,
                                controller.addressDetailTEC);

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
