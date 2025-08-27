import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sba/src/models/home_model.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/services/api/user_api.dart';
import 'package:sba/src/utils/utils.dart';

class MainController extends BaseController<HomeData> {
  final PageController pageController = PageController(initialPage: 2);

  MainController(super.state, super.ref) {
    checkAppVersion();
    getLocation();
    getUserProfile();
  }

  void getLocation() {
    Future.delayed(const Duration(seconds: 1)).then(
      (value) => LocationUtils.getUserLocation(),
    );
  }

  void getUserProfile() async {
    final result = await ref.read(userApiProvider).getUserProfile();
    var currentUser = ref.read(appController).userLogin;
    if (result.data != null) {
      final newProfile = result.data!.copyWith.call(
        loginName: currentUser?.loginName,
        pass: currentUser?.pass,
        accessToken: currentUser?.accessToken,
        refreshToken: currentUser?.refreshToken,
      );
      ref.read(appController.notifier).logIn(newProfile);
    }
  }

  Future<bool> checkAppVersion() async {
    // final remoteConfig = FirebaseRemoteConfig.instance;
    // await remoteConfig.setConfigSettings(RemoteConfigSettings(
    //   fetchTimeout: Duration(seconds: 10),
    //   minimumFetchInterval: Duration(minutes: 1),
    // ));
    // var key = Platform.isAndroid ? 'android_version' : 'ios_version';
    // await remoteConfig.fetchAndActivate();
    // var appVersion = remoteConfig.getString(key);
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // var currentVersion = '${packageInfo.version}';
    // if (currentVersion != appVersion) {
    //   var result = await showOkCancelAlertDialog(
    //     context: context,
    //     title: 'Cập nhật ứng dụng',
    //     message:
    //         'Đã có phiên bản mới của ứng dụng ${packageInfo.appName}. Vui lòng cập nhật để tiếp tục sử dụng!',
    //   );
    //   if (result == OkCancelResult.ok) {
    //     var url = getStoreURL(remoteConfig);
    //     try {
    //       launchUrlString(url, mode: LaunchMode.externalApplication);
    //     } catch (e) {}
    //   }
    //   return false;
    // } else {
    //   return true;
    // }
    return true;
  }

  // String getStoreURL(FirebaseRemoteConfig remoteConfig) =>
  //     remoteConfig.getString(Platform.isAndroid ? 'ch_play' : 'app_store');

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void focusTaiSan() {
    pageController.jumpTo(0);
  }
}
