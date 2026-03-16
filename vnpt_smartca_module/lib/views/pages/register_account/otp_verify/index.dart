// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/configs/app_config.dart';
import '../../../controller/otp_verify_controller.dart';
import '../../../utils/color.dart';
import '../../../widgets/base_screen.dart';

import '../../../../core/models/request/ekyc_result_model.dart';
import '../../../../core/utils/enums.dart';
import '../../../../gen/assets.gen.dart';
import '../../../controller/buy_certificate_controller.dart';
import '../../../controller/otp_verify_controller.dart';
import '../../../i18n/generated_locales/l10n.dart';
import '../../../widgets/app_button_widget.dart';
import '../../../widgets/base_loading.dart';
import '../../../widgets/base_screen.dart';
import '../../../widgets/base_text.dart';
import '../../../widgets/dialog_notification.dart';
import '../../../widgets/bottom_contact.dart';
import '../../certificate/setup_pin_code/widget/create_pin_code_widget.dart';
import '../confirm_information/index.dart';

StreamSubscription? successVerifyOTP;

class OTPVerifyPage extends StatefulWidget {
  final bool requiredEKYC;
  final EkycResponseModel ekycResponseModel;

  const OTPVerifyPage(
      {super.key, required this.ekycResponseModel, required this.requiredEKYC});

  @override
  State<StatefulWidget> createState() => OTPVerifyState();
}

class OTPVerifyState extends State<OTPVerifyPage> {
  late FocusNode _focusNode;

  bool hasError = true;
  String errorMsg = '';
  String pin = '';

  final controller = Get.put(OTPVerifyController());
  final controllerEkyc = Get.put(BuyCertificateController());

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    controllerEkyc.ekycErrorCount = 0;

    successVerifyOTP?.cancel();
    successVerifyOTP = controller.successVerifyOTP.listen((success) async {
      if (success) {
        // VERIFY OTP SUCCESS
        controller.successVerifyOTP.value = false;
        if (widget.requiredEKYC) {
          controllerEkyc.isFlowRegister = true;
          controllerEkyc.uid = widget.ekycResponseModel.ocrResult.id;
          controllerEkyc.eKycUserEnroll().then((value) {
            debugPrint("result ekyc >>>>: $value");

            if (value == VerifyInfoType.error3times) {
              // back to login
              Navigator.popUntil(context, (route) => route.isFirst);
            } else if (value is EkycResponseModel) {
              // ekyc success
              value.password = widget.ekycResponseModel.password;
              value.loaiGiayTo = widget.ekycResponseModel.loaiGiayTo;
              value.phone = widget.ekycResponseModel.phone;
              value.deviceId = widget.ekycResponseModel.deviceId;
              value.otp = pin;
              value.email = widget.ekycResponseModel.email;
              value.uid = widget.ekycResponseModel.uid;
              Get.to(() => ConfirmInformationPage(
                    ekycResponseModel: value,
                    fromEKYC: true,
                  ));
            } else if (value == null) {
              Get.back();
            }
          });
        } else {
          Get.to(() => ConfirmInformationPage(
              ekycResponseModel: widget.ekycResponseModel));
        }
      }
    });
    controller.successResendOTP.listen((success) async {
      if (success) {
        // RESEND OTP SUCCESS
        controller.successResendOTP.value = false;
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // ignore: avoid-unused-parameters
  void verifyOTP(String pin) {
    _focusNode.unfocus();
    // API OTP
    widget.ekycResponseModel.otp = pin;
    controller.verifyOTP(widget.ekycResponseModel);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      loadingWidget: BaseLoading<OTPVerifyController>(),
      title: AppLocalizations.current.inputOTP,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Assets.images.icDialogLock.image(
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BaseText(
                          AppLocalizations.current.otpSendToPhone,
                          textOverflow: TextOverflow.visible,
                          height: 24 / 14,
                          color: Color(0xff5768A5),
                        ),
                        SizedBox(width: 2),
                        BaseText(
                          widget.ekycResponseModel.phone,
                          color: Color(0xff5768A5),
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: CreatePinCodeTextField(
                        // ignore: prefer-extracting-callbacks
                        // shape: PinCodeFieldShape.box,
                        showTitle: false,
                        callback: (value) {
                          setState(() {
                            pin = value;
                          });
                        },
                        focusNode: _focusNode,
                        onCompleteCallback: verifyOTP,
                      ),
                    ),
                    hasError
                        ? Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: BaseText(
                              errorMsg,
                              fontSize: 12,
                              color: Color(0xffE51F1F),
                            ),
                          )
                        : Container(),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BaseText(
                          AppLocalizations.current.reciveOTP,
                          color: Color(0xff5768A5),
                        ),
                        SizedBox(width: 2),
                        InkWell(
                          onTap: () {
                            controller.resendOTP(widget.ekycResponseModel);
                          },
                          child: BaseText(
                            AppLocalizations.current.resendOTP,
                            color: HexColor(AppConfig.colorPrimaryBtn),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          AppButtonWidget(
            label: AppLocalizations.current.confirm,
            backgroundColor:
                !hasError ? HexColor(AppConfig.colorPrimaryBtn) : Colors.grey,
            doublePadding: 15,
            onTap: () {
              if (hasError) {
                return;
              }
              verifyOTP(pin);
            },
          ),
          SizedBox(height: 10),
          BottomContact(),
        ]),
      ),
    );
  }

  void onShowError(String content) {
    Get.dialog(
      DialogNotification(
        content: content,
        onlyActionCancel: true,
      ),
    );
  }
}
