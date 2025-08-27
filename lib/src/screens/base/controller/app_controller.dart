import 'dart:convert';

import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/sba_app.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/models/login/user_model.dart';
import 'package:sba/src/screens/base/controller/app_states.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/screens/login/login_page.dart';
import 'package:sba/src/utils/utils.dart';

class AppController extends BaseController<AppState> {
  AppController(super.state, super.ref) {
    azureConfig = Config(
      tenant: '43a92d1d-98ce-4726-bec3-32955dbb6944',
      clientId: 'a1a10e59-ff23-4d8a-94b6-798db48a09ff',
      scope: "openid profile offline_access",
      redirectUri: 'cmvapp://oauthredirect',
      navigatorKey: SBAApp.navigatorKey,
      webUseRedirect: true,
      loader: const Center(child: CircularProgressIndicator()),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Đăng nhập',
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: SBAApp.navigatorKey.currentContext?.textTitleBold.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );

    oauth = AadOAuth(azureConfig);
  }

  UserModel? get userLogin => state.userLogin;
  LanguageModel get language => state.language;

  late Config azureConfig;

  late AadOAuth oauth;

  void switchLanguage() {
    state = state.copyWith.call(
      language: language.code == 'vi'
          ? LanguageModel.initEngLanguage()
          : LanguageModel.initViLanguage(),
    );
  }

  void logIn(UserModel user) {
    ref
        .read(sharedPreferencesProvider)
        .setString('user', jsonEncode(user.toJson()));
    state = state.copyWith.call(
      userLogin: user,
    );
  }

  void logOut() async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: S.current.thong_bao,
      message: 'Bạn có chắc muốn đăng xuất không?',
      okLabel: 'OK',
      cancelLabel: 'Hủy',
      defaultType: OkCancelAlertDefaultType.cancel,
      isDestructiveAction: true,
    );
    if (result == OkCancelResult.cancel) return;
    doLogout();
  }

  void doLogout() async {
    if (userLogin?.pass == null) {
      await oauth.logout();
    }

    state = state.copyWith.call(
      userLogin: userLogin?.copyWith(
        accessToken: null,
        refreshToken: null,
      ),
    );

    ref
        .read(sharedPreferencesProvider)
        .setString('user', jsonEncode(state.userLogin?.toJson()));

    AppRoutes.pushReplacement(context, const LoginPage());
  }

  void removeUserInfo() {
    ref.read(sharedPreferencesProvider).remove('user');
    state = state.copyWith.call(
      userLogin: null,
    );
  }

  void hasCachedAccountInformation() async {
    var hasCachedAccountInformation = await oauth.hasCachedAccountInformation;
    // ScaffoldMessenger.of(context).hideCurrentSnackBar();
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content:
    //         Text('HasCachedAccountInformation: $hasCachedAccountInformation'),
    //   ),
    // );
  }
}
