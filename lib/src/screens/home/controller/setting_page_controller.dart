import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/src/helper/digital_sign.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/screens/home/states/setting_state.dart';

class SettingPageController extends BaseController<SettingState> {
  SettingPageController(super.state, super.ref);

  static final settingController =
      StateNotifierProvider.autoDispose<SettingPageController, SettingState>(
    (ref) {
      bool isEnableSign =
          ref.read(sharedPreferencesProvider).getBool('sign') ?? false;
      return SettingPageController(
          SettingState(isEnableSignature: isEnableSign), ref);
    },
  );

  void getMainInfo(BuildContext context) async {
    DigitalSign.instance.getMainInfo();
  }
}
