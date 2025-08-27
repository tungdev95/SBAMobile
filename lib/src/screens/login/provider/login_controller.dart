import 'dart:io';
import 'package:aad_oauth/aad_oauth.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/event/event.dart';
import 'package:sba/src/models/base/base_api_model.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/screens/home/main_page.dart';
import 'package:sba/src/utils/dialog_utils.dart';
import 'package:sba/src/utils/utils.dart';

import '../../../models/login/user_model.dart';
import '../../../services/api/user_api.dart';
import '../../base/top_level_provider.dart';
import 'login_states.dart';

class LoginController extends BaseController<LoginState> {
  LoginController(Ref ref) : super(LoginState(), ref) {
    userNameController.text = ref.read(appController).userLogin?.username ?? '';
    if (kDebugMode) {
      passController.text = 'Sup3rP@\$\$W0rD@2024';
    }
    checkBiometricsSupport();
    layDanhSachChiNhanh();
  }

  static final togglePassProvider =
      StateProvider.autoDispose<bool>((ref) => false);
  static final validateDataProvider =
      StateProvider.autoDispose<bool>((ref) => false);
  TextEditingController userNameController = TextEditingController(text: '');
  TextEditingController passController = TextEditingController(text: '');
  final loginFormKey = GlobalKey<FormState>();
  final LocalAuthentication localAuthentication = LocalAuthentication();

  static final loginStateProvider =
      StateNotifierProvider.autoDispose<LoginController, LoginState>((ref) {
    return LoginController(ref);
  });

  void togglePassword() {
    ref.read(togglePassProvider.notifier).update((state) => !state);
  }

  void toggleValidateData() {
    ref.read(validateDataProvider.notifier).update((state) => true);
  }

  Future onClickLogin() async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    }
    var userName = userNameController.text;
    if (userName.isEmpty) {
      userName = ref.read(appController).userLogin?.loginName ??
          userNameController.text;
    }
    final pass = passController.text;
    if (pass.isEmpty) {
      showMessageDialog(
          'Không hỗ trợ đăng nhập nhanh nếu bạn sử dụng Microsoft');
      return;
    }

    return loginWithUserNameAndPass(userName, pass);
  }

  Future loginWithUserNameAndPass(
    String userName,
    String pass,
  ) async {
    showLoading();

    var result = await ref.read(userApiProvider).login(
          userName,
          pass,
        );

    hideLoading();
    var isOK = await handleResponse<UserModel>(result, (UserModel? data) async {
      isFromDeeplink = false;
      loggedIn(data);
    });

    return isOK;
  }

  ///Đăng nhập token
  Future logginToken(
    String idToken,
    String? accessToken,
    String? refreshToken,
  ) async {
    showLoading();
    final result = await ref.read(userApiProvider).loginWithToken(
          idToken,
          accessToken,
          refreshToken,
        );
    hideLoading();
    var isOK = await handleResponse<UserModel>(result, (UserModel? data) async {
      isFromDeeplink = false;
      loggedIn(data);
    });
  }

  ///Đăng nhập thành công
  Future loggedIn(UserModel? data) async {
    if (data != null) {
      ref.read(appController.notifier).logIn(data);
      await AppRoutes.pushReplacement(
        context,
        const MainPage(),
        name: 'MainPage',
      );
    }
  }

  void checkBiometricsSupport() async {
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    List<BiometricType> availableBiometrics =
        await localAuthentication.getAvailableBiometrics();

    try {
      if (Platform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face) &&
            isBiometricSupported == true) {
          updateBioType(BiometricType.face);
        } else if (availableBiometrics.contains(BiometricType.fingerprint) &&
            isBiometricSupported == true) {
          updateBioType(BiometricType.fingerprint);
        }
      } else if (Platform.isAndroid) {
        if (availableBiometrics.contains(availableBiometrics.firstOrNull) &&
            isBiometricSupported == true) {
          updateBioType(availableBiometrics.first);
        }
      }
    } on PlatformException {
      availableBiometrics = <BiometricType>[];
    }
  }

  void updateBioType(BiometricType bioType) {
    state = state.copyWith.call(bioMetricType: bioType);
  }

  Future loginWithBiometric() async {
    bool isBioAuthenticated = await authenticateWithBiometrics();
    if (isBioAuthenticated) {
      final userLogin = ref.read(appController).userLogin;
      if ((userLogin?.pass ?? '').isEmpty) {
        showMessageDialog(
            'Không hỗ trợ đăng nhập nhanh nếu bạn sử dụng Microsoft');
        return;
      }
      loginWithUserNameAndPass(
          userLogin?.loginName ?? '', userLogin?.pass ?? '');
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;
    List<BiometricType> availableBiometrics =
        await localAuthentication.getAvailableBiometrics();

    if (Platform.isIOS) {
      if (availableBiometrics.contains(BiometricType.face)) {
        if (isBiometricSupported && canCheckBiometrics) {
          isAuthenticated = await localAuthentication.authenticate(
            localizedReason: 'Please complete the biometrics to proceed.',
            options: const AuthenticationOptions(
              biometricOnly: true,
              stickyAuth: true,
            ),
          );
        }
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        if (isBiometricSupported && canCheckBiometrics) {
          isAuthenticated = await localAuthentication.authenticate(
            localizedReason: 'Please complete the biometrics to proceed.',
            options: const AuthenticationOptions(
              biometricOnly: true,
              stickyAuth: true,
            ),
          );
        }
      }
    } else {
      if (availableBiometrics.contains(availableBiometrics.first)) {
        if (isBiometricSupported && canCheckBiometrics) {
          isAuthenticated = await localAuthentication.authenticate(
            localizedReason: 'Please complete the biometrics to proceed.',
            options: const AuthenticationOptions(
              biometricOnly: true,
            ),
          );
        }
      }
    }

    return isAuthenticated;
  }

  void layDanhSachChiNhanh() {
    // state = state.copyWith.call(
    //   lsChiNhanh: List.generate(
    //     100,
    //     (index) => KeyValueModel(
    //       key: '$index',
    //       title: 'Chi nhánh $index',
    //     ),
    //   ),
    // );
  }

  @override
  void dispose() {
    userNameController.dispose();
    passController.dispose();
    super.dispose();
  }

  void onChangeChiNhanh(newItem) {
    // state = state.copyWith.call(selectedChiNhanh: newItem);
  }

  void clearUserInfo() {
    passController.text = '';
    userNameController.text = '';
    ref.read(appController.notifier).removeUserInfo();
  }

  Future azureADLogin() async {
    final AadOAuth oauth = ref.read(appController.notifier).oauth;
    final hasCacheAccount = await oauth.hasCachedAccountInformation;
    await oauth.logout();
    final result = await oauth.login();

    result.fold(
      (l) => BotToast.showText(text: 'Đăng nhập không thành công'),
      (r) => logginToken(r.idToken ?? '', r.accessToken, r.refreshToken),
    );
  }

  @override
  Future<bool> exceptionThrow(AppException? exception) async {
    if (mounted) {
      if (exception?.code == StatusCode.kTokenExpired) {
        await DialogUtils.showMessageDialog(
            context, S.current.sai_tai_khoan_hoac_mat_khau);
        return false;
      }
    }
    return super.exceptionThrow(exception);
  }

  Future<void> changeApiUrl() async {
    var defaultUrl =
        ref.read(sharedPreferencesProvider).getString(AppConstants.kApiUrl) ??
            AppConstants.kUatUrl;

    final results = await showTextInputDialog(
      context: context,
      title: 'Nhập link api',
      textFields: [
        DialogTextField(
          initialText: defaultUrl,
          validator: (value) {
            final RegExp regex = RegExp(
              r'[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z,0-9]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)\/',
            );
            if (regex.hasMatch(value ?? '')) {
              return null;
            }
            return 'Đường dẫn không hợp lệ';
          },
        ),
      ],
    );
    if ((results ?? []).isNotEmpty) {
      ref
          .read(sharedPreferencesProvider)
          .setString(AppConstants.kApiUrl, (results ?? []).first);
      showMessageDialog(
        'Đổi đường dẫn thành công, vui lòng khởi động lại ứng dụng!',
      );
    }
  }
}
