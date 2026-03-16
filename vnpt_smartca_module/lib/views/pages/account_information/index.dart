// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:scale_size/scale_size.dart';
import 'package:vnpt_smartca_module/core/extensions/string.dart';
import 'package:vnpt_smartca_module/core/models/app/province_model.dart';
import 'package:vnpt_smartca_module/core/models/app/wards_model.dart';
import 'package:vnpt_smartca_module/core/models/response/user_address.dart';
import 'package:vnpt_smartca_module/core/services/device_info.dart';
import 'package:vnpt_smartca_module/views/controller/buy_certificate_controller.dart';
import 'package:vnpt_smartca_module/views/controller/enter_info_controller.dart';
import 'package:vnpt_smartca_module/views/utils/color.dart';
import 'package:vnpt_smartca_module/views/utils/config_input_decoration.dart';
import 'package:vnpt_smartca_module/views/widgets/dialog_notification.dart';
import 'package:vnpt_smartca_module/views/widgets/typehead_formfield_custom.dart';
import 'package:vnpt_smartca_module/views/widgets/widget.dart';

import '../../../configs/app_config.dart';
import '../../../configs/injector/injector.dart';
import '../../../core/models/response/profile_model.dart';
import '../../../core/services/secure_local_storage.dart';
import '../../../core/utils/constants.dart';
import '../../../gen/assets.gen.dart';
import '../../controller/app_controller.dart';
import '../../i18n/generated_locales/l10n.dart';
import '../../widgets/base_text.dart';
import 'address_details_widget.dart';

class AccountInformationPage extends StatefulWidget {
  const AccountInformationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AccountInformationState();
}

class AccountInformationState extends State<AccountInformationPage> {
  final _deviceInfoService = getIt<DeviceInfoService>();

  final appController = Get.find<AppController>();
  final controllerAddress = Get.put(EnterInfoController());

  String deviceId = "";
  bool showEmailAndPhone = false;
  bool showDetailAddress = false;
  int maxLength250 = 250;
  int maxLength12 = 12;
  String provinceStr = "";
  String wardsStr = "";
  String addressDetailStr = "";
  final controller = Get.put(BuyCertificateController());

  @override
  void initState() {
    super.initState();

    getDeviceInfo();
  }

  getDeviceInfo() async {
    var deviceInfo = await _deviceInfoService.getDeviceInfo();

    setState(() {
      deviceId = deviceInfo.deviceId;
    });
  }
  // BaseHeader(title: AppLocalizations.current.accountInformation),

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.current.accountInformation,
      loadingWidget: BaseLoading<BuyCertificateController>(),
      body: Container(
        height: Get.size.height,
        color: Colors.white,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // BaseHeader(title: AppLocalizations.current.accountInformation),
                  Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(Assets.images.icInfoHeaderBg.path,
                            package: AppConfig.package),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Row(
                      children: [
                        Assets.images.icHomeLogo.image(width: 55, height: 55),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BaseText(
                                controllerAddress
                                    .userProfile.value.fullName?.capitalize,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                              SizedBox(height: 4),
                              BaseText(
                                controllerAddress.userProfile.value.uid
                                    ?.toUpperCase(),
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff1A3478).withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        _itemInformation(
                            Assets.images.icProfileCircle,
                            AppLocalizations.current.accountType,
                            getTypeAccount(
                                controllerAddress.userProfile.value.accType)),
                        _itemInformation(
                            Assets.images.icPersonalCard,
                            AppLocalizations.current.fullDocument,
                            controllerAddress.userProfile.value.uid
                                ?.split("_")
                                .first
                                .toUpperCase()),
                        _itemInformation(
                            Assets.images.icCall,
                            AppLocalizations.current.phone,
                            controllerAddress.userProfile.value.phone),
                        _itemInformation(
                            Assets.images.mail,
                            AppLocalizations.current.email,
                            controllerAddress.userProfile.value.email),
                        _itemInformation(
                            Assets.images.icLocation,
                            AppLocalizations.current.addressDetail,
                            controllerAddress
                                .userProfile.value.userAddress?.diaChi,
                            isEditAddressImg: true, tapEdit: () {
                          setState(() {
                            showDetailAddress = !showDetailAddress;
                          });
                        }),
                        _itemInformation(Assets.images.icBarcode,
                            AppLocalizations.current.deviceIdloggedIn, deviceId,
                            marginBottom: 0),
                      ],
                    ),
                  ),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                      child: AppButtonWidget(
                        onTap: () {
                          setState(() {
                            showEmailAndPhone = !showEmailAndPhone;
                          });
                        },
                        label: AppLocalizations.current.update_email_phone,
                      ))
                ],
              ),
            ),
            showEmailAndPhone ? showEmailAndPhones() : Container(),
            showDetailAddress
                ? AddressDetailsWidget(
                    controllerAddress: controllerAddress,
                    controller: controller,
                    onClose: () {
                      setState(() {
                        showDetailAddress = false;
                      });
                    },
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _itemInformation(AssetGenImage image, String title, String? content,
      {double marginBottom = 15,
      bool isEditAddressImg = false,
      Function? tapEdit}) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image.image(width: 20),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  title,
                  color: Color(0xff102459),
                ),
                SizedBox(height: 5),
                BaseText(
                  content,
                  color: Color(0xff102459),
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          if (isEditAddressImg)
            InkWell(
              onTap: () {
                tapEdit?.call();
              },
              child: Container(
                padding: EdgeInsets.all(4),
                child: Assets.images.icEditAddress.image(width: 24, height: 24),
              ),
            )
        ],
      ),
    );
  }

  String getTypeAccount(int? type) {
    switch (type) {
      case 0:
        return AppLocalizations.current.personal;
      case 1:
        return AppLocalizations.current.business;
      case 2:
        return AppLocalizations.current.personalInBusiness;
      case 3:
        return 'One time CA';
      default:
        return AppLocalizations.current.unknown;
    }
  }

  Widget showAddressDetails() {
    ProvinceModel provinceModel =
        ProvinceModel(provinceId: 0, provinceName: '');

    WardsModel wardsModel = WardsModel(wardId: 0, wardName: '');

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controllerAddress.getAllWards();
      controllerAddress.addressStandardization(provinceModel, wardsModel);
    });

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
              padding: EdgeInsets.symmetric(vertical: 20),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                showDetailAddress = false;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.centerRight,
                              child: Assets.images.icClose.svg(
                                width: 15,
                                height: 15,
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: BaseText(
                        AppLocalizations.current.detailAddress,
                        isRequired: true,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff08285C),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: FormBuilderTextField(
                        name: 'detailAddress',
                        enableSuggestions: true,
                        // initialValue: addressDetailStr,
                        readOnly: false,
                        controller: controllerAddress.txtAddressController,
                        decoration: ConfigInputDecoration().config(
                            AppLocalizations.current.detailAddress,
                            borderColor: Color(0xffA5B0C2),
                            fillColor: Colors.white),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: AppLocalizations.current.inputRequired(
                                  AppLocalizations.current.detailAddress)),
                          FormBuilderValidators.maxLength(maxLength250,
                              errorText: AppLocalizations.current
                                  .maxLength(maxLength250)),
                        ]),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: AppButtonWidget(
                        label: AppLocalizations.current.confirm,
                        doublePadding: 15,
                        onTap: () {
                          if (controllerAddress.formKey1.currentState!
                              .saveAndValidate()) {
                            if (provinceModel.provinceId ==
                                    int.tryParse(controllerAddress.userProfile
                                            .value.userAddress?.provinceId ??
                                        "0") &&
                                wardsModel.wardId ==
                                    int.tryParse(controllerAddress.userProfile
                                            .value.userAddress?.wardId ??
                                        "0") &&
                                controllerAddress.txtAddressController.text ==
                                    controllerAddress.userProfile.value
                                        .userAddress?.streetName) {
                              Get.dialog(DialogNotification(
                                content:
                                    AppLocalizations.current.not_info_change,
                                titleBtnAccept: AppLocalizations.current.agree,
                                onlyActionAccept: true,
                                actionAccept: () {},
                              ));
                              return;
                            }
                            provinceStr =
                                controllerAddress.txtProvinceController.text;
                            wardsStr = controllerAddress.txtWardController.text;
                            addressDetailStr =
                                controllerAddress.txtAddressController.text;

                            UserAddress userAddress = UserAddress(
                                provinceId: provinceModel.provinceId.toString(),
                                provinceName: provinceModel.provinceName,
                                wardId: wardsModel.wardId.toString(),
                                wardName: wardsModel.wardName.toString(),
                                streetName:
                                    controllerAddress.txtAddressController.text,
                                diaChi:
                                    "${controllerAddress.txtAddressController.text}, ${wardsModel!.wardName.toString()}, ${provinceModel!.provinceName}");

                            controller.updateInfoUserAddress(userAddress);
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

  Widget showEmailAndPhones() {
    controllerAddress.txtPhoneController.text =
        controllerAddress.userProfile.value.phone ?? '';
    controllerAddress.txtEmailController.text =
        controllerAddress.userProfile.value.email ?? '';

    return Container(
      // height: 1.height,
      alignment: Alignment.bottomCenter,
      color: Colors.black.withOpacity(0.3),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BaseText(
                            AppLocalizations.current.update_email_phone,
                            color: Color(0xff08285C),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                showEmailAndPhone = false;
                              });
                            },
                            child: Container(
                              width: 25,
                              height: 25,
                              alignment: Alignment.centerRight,
                              child: Assets.images.icClose.svg(
                                width: 15,
                                height: 15,
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      child: BaseText(
                        AppLocalizations.current.phone,
                        isRequired: true,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff08285C),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      child: FormBuilderTextField(
                        name: 'phone',
                        readOnly: false,
                        textInputAction: TextInputAction.done,
                        // onSubmitted: (value) => controller.onFormSubmit(ekycResponseModel),
                        controller: controllerAddress.txtPhoneController,
                        maxLength: maxLength12,
                        decoration: ConfigInputDecoration().config(
                            AppLocalizations.current.phone,
                            borderColor: Color(0xffA5B0C2),
                            fillColor: Colors.white),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: AppLocalizations.current.inputRequired(
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
                    ),
                    SizedBox(height: 16),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      child: BaseText(
                        AppLocalizations.current.emailOnly,
                        isRequired: true,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff08285C),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      child: FormBuilderTextField(
                        name: 'email',
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        controller: controllerAddress.txtEmailController,
                        maxLength: maxLength250,
                        decoration: ConfigInputDecoration().config(
                            AppLocalizations.current.emailOnly,
                            borderColor: Color(0xffA5B0C2),
                            fillColor: Colors.white),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: AppLocalizations.current.inputRequired(
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
                    ),
                    SizedBox(height: 16),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: AppButtonWidget(
                        label: AppLocalizations.current.Continue,
                        doublePadding: 15,
                        onTap: () {
                          if (controllerAddress.formKey1.currentState!
                              .saveAndValidate()) {
                            if (controllerAddress.txtPhoneController.text ==
                                    controllerAddress.userProfile.value.phone &&
                                controllerAddress.txtEmailController.text ==
                                    controllerAddress.userProfile.value.email) {
                              Get.dialog(DialogNotification(
                                content: AppLocalizations
                                    .current.please_choose_email_phone_other,
                                titleBtnAccept: AppLocalizations.current.agree,
                                onlyActionAccept: true,
                                actionAccept: () {},
                              ));
                              return;
                            }
                            if (controllerAddress
                                    .txtPhoneController.text.isEmpty ||
                                controllerAddress
                                    .txtEmailController.text.isEmpty) {
                              return;
                            }
                            controller.sendOTPUpdateInfo(
                              sendAgain: false,
                              phone: controllerAddress.txtPhoneController.text
                                  .trim(),
                              email: controllerAddress.txtEmailController.text
                                  .trim(),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20),
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
