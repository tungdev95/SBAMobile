// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../core/models/app/province_model.dart';
import '../../../core/models/app/wards_model.dart';
import '../../../core/models/response/user_address.dart';
import '../../controller/auth_controller.dart';
import '../../controller/buy_certificate_controller.dart';
import '../../controller/enter_info_controller.dart';
import '../../i18n/generated_locales/l10n.dart';
import '../../utils/config_input_decoration.dart';
import '../../widgets/typehead_formfield_custom.dart';
import '../../widgets/widget.dart';

class UpdateAdressPage extends StatelessWidget {
  final controllerAddress = Get.put(EnterInfoController());
  final controller = Get.put(BuyCertificateController());
  final authController = Get.find<AuthController>();

  String deviceId = "";
  bool showEmailAndPhone = false;
  bool showDetailAddress = false;
  int maxLength250 = 250;
  int maxLength12 = 12;
  String provinceStr = "";
  String districtStr = "";
  String wardsStr = "";
  String addressDetailStr = "";
  ProvinceModel provinceModel = ProvinceModel(provinceId: 0, provinceName: '');
  WardsModel wardsModel = WardsModel(wardId: 0, wardName: '');

  UpdateAdressPage({super.key}) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controllerAddress.getAllWards();
      controllerAddress.addressStandardization(provinceModel, wardsModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      loadingWidget: BaseLoading<EnterInfoController>(),
      title: AppLocalizations.current.update_info_title,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        color: Color(0xffF5F7FB),
        child: FormBuilder(
          key: controllerAddress.formKey1,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BaseText(
                  AppLocalizations.current.updateAddressNotice,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 26),
                TypeAheadFormFieldCustom(
                  labelText: AppLocalizations.current.provinceCity,
                  controller: controllerAddress.txtProvinceController,
                  suggestionsCallback: (pattern) {
                    return controllerAddress.getProvinceSuggestions(pattern);
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
                          errorText:
                              AppLocalizations.current.maxLength(maxLength250)),
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

                        controller.updateInfoUserAddress(userAddress,
                            actionAccept: Get.back);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
