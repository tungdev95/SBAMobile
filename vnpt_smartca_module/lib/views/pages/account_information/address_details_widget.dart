// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:scale_size/scale_size.dart';

import '../../../core/models/app/province_model.dart';
import '../../../core/models/app/wards_model.dart';
import '../../../core/models/response/user_address.dart';
import '../../../gen/assets.gen.dart';
import '../../controller/buy_certificate_controller.dart';
import '../../controller/enter_info_controller.dart';
import '../../i18n/generated_locales/l10n.dart';
import '../../utils/config_input_decoration.dart';
import '../../widgets/app_button_widget.dart';
import '../../widgets/base_text.dart';
import '../../widgets/dialog_notification.dart';
import '../../widgets/typehead_formfield_custom.dart';

class AddressDetailsWidget extends StatelessWidget {
  final EnterInfoController controllerAddress;
  final BuyCertificateController controller;
  final VoidCallback onClose;

  const AddressDetailsWidget({
    Key? key,
    required this.controllerAddress,
    required this.controller,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProvinceModel provinceModel =
        ProvinceModel(provinceId: 0, provinceName: '');
    WardsModel wardsModel = WardsModel(wardId: 0, wardName: '');
    const int maxLength250 = 250;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controllerAddress.getAllWards();
      await controllerAddress.addressStandardization(provinceModel, wardsModel);
    });

    return Obx(
      () {
        return controllerAddress.lstProvinces.isEmpty
            ? Container()
            : Container(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BaseText(
                                      AppLocalizations
                                          .current.update_info_title,
                                      color: Color(0xff08285C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    InkWell(
                                      onTap: onClose,
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
                                labelText:
                                    AppLocalizations.current.provinceCity,
                                controller:
                                    controllerAddress.txtProvinceController,
                                suggestionsCallback: (pattern) {
                                  return controllerAddress
                                      .getProvinceSuggestions(pattern);
                                },
                                onSelectedCallback: (option) {
                                  ProvinceModel province =
                                      option as ProvinceModel;
                                  provinceModel = province;
                                  controllerAddress.txtProvinceController.text =
                                      province.name;
                                  controllerAddress.txtWardController.text = "";
                                  return province.name;
                                },
                                validator: (value) {
                                  return controllerAddress
                                      .validateProvinces(value);
                                },
                              ),
                              SizedBox(height: 16),
                              TypeAheadFormFieldCustom(
                                labelText: AppLocalizations.current.wards,
                                controller: controllerAddress.txtWardController,
                                suggestionsCallback: (pattern) {
                                  return controllerAddress
                                      .getWardSuggestions(pattern);
                                },
                                onSelectedCallback: (option) {
                                  WardsModel wards = option as WardsModel;
                                  wardsModel = wards;
                                  controllerAddress.txtWardController.text =
                                      wards.name;
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
                                  readOnly: false,
                                  controller:
                                      controllerAddress.txtAddressController,
                                  decoration: ConfigInputDecoration().config(
                                      AppLocalizations.current.detailAddress,
                                      borderColor: Color(0xffA5B0C2),
                                      fillColor: Colors.white),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: AppLocalizations.current
                                            .inputRequired(AppLocalizations
                                                .current.detailAddress)),
                                    FormBuilderValidators.maxLength(
                                        maxLength250,
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
                                              int.tryParse(controllerAddress
                                                      .userProfile
                                                      .value
                                                      .userAddress
                                                      ?.provinceId ??
                                                  "0") &&
                                          wardsModel.wardId ==
                                              int.tryParse(controllerAddress
                                                      .userProfile
                                                      .value
                                                      .userAddress
                                                      ?.wardId ??
                                                  "0") &&
                                          controllerAddress
                                                  .txtAddressController.text ==
                                              controllerAddress
                                                  .userProfile
                                                  .value
                                                  .userAddress
                                                  ?.streetName) {
                                        Get.dialog(DialogNotification(
                                          content: AppLocalizations
                                              .current.not_info_change,
                                          titleBtnAccept:
                                              AppLocalizations.current.agree,
                                          onlyActionAccept: true,
                                          actionAccept: () {},
                                        ));
                                        return;
                                      }

                                      UserAddress userAddress = UserAddress(
                                          provinceId: provinceModel.provinceId
                                              .toString(),
                                          provinceName:
                                              provinceModel.provinceName,
                                          wardId: wardsModel.wardId.toString(),
                                          wardName:
                                              wardsModel.wardName.toString(),
                                          streetName: controllerAddress
                                              .txtAddressController.text,
                                          diaChi:
                                              "${controllerAddress.txtAddressController.text}, ${wardsModel.wardName.toString()}, ${provinceModel.provinceName}");

                                      controller
                                          .updateInfoUserAddress(userAddress);
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
      },
    );
  }
}
