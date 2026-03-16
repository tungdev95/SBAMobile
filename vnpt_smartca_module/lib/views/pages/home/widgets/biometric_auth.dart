// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/configs/app_config.dart';
import 'package:vnpt_smartca_module/views/utils/color.dart';
import '../../../controller/auth_controller.dart';
import '../../../i18n/generated_locales/l10n.dart';

import '../../../../gen/assets.gen.dart';
import '../../../widgets/widget.dart';

class BiometricAuthWidget extends GetView<AuthController> {
  const BiometricAuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        height: Get.height * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.images.faceId.svg(color: HexColor(AppConfig.colorPrimaryBtn), height: 52),
            SizedBox(height: 10),
            BaseText(AppLocalizations.current.biometricAuthDesc,
                fontSize: 14.5, fontWeight: FontWeight.w500),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: AppButtonWidget(
                  label: AppLocalizations.current.skip,
                  // backgroundColor: Colors.white,
                  // labelColor: Colors.black,
                  // border: Border.all(color: Color(0xff0D75D6)),
                  labelColor: HexColor(AppConfig.colorPrimaryBtn),
                  backgroundColor: HexColor(AppConfig.colorSecondBtn),
                  border: AppConfig.colorPrimaryBtn == "#0D75D6"
                      ? null
                      : Border.all(
                          width: 1.5, color: HexColor(AppConfig.colorPrimaryBtn)),
                  onTap: () {
                    controller.toggleAuthBiometrics(
                        value: false, authRequired: false);
                    Get.back();
                  },
                )),
                SizedBox(width: 12),
                Expanded(
                    child: AppButtonWidget(
                  label: AppLocalizations.current.agree,
                  backgroundColor: HexColor(AppConfig.colorPrimaryBtn),
                  onTap: () {
                    controller.toggleAuthBiometrics(value: true);
                    Get.back();
                  },
                ))
              ],
            )
          ],
        ));
  }
}
