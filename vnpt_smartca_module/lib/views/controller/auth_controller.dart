// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import '../../../core/models/request/login.dart';
import '../../../core/models/response/token_model.dart';
import '../../../core/services/user_info_on_device.dart';
import '../../../data/repository/authen_repository.dart';
import '../../../views/controller/app_controller.dart';
import '../../../views/pages/register_account/register_account/index.dart';
import '../../../views/utils/enums.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

import '../../configs/app_config.dart';
import '../../configs/injector/injector.dart';
import '../../core/models/app/exceptions.dart';
import '../../core/models/app/user_info_on_device.dart';
import '../../core/services/biometrics.dart';
import '../../core/services/secure_local_storage.dart';
import '../../core/utils/constants.dart';
import '../../data/repository/user_repository.dart';
import '../i18n/generated_locales/l10n.dart';
import '../utils/exception_handler.dart';
import '../widgets/dialog/common_dialog.dart';
import 'home_controller.dart';
import 'host_app_controller.dart';

class AuthController extends GetxController {
  final authStatus = AuthenticationStatus.unauthenticated.obs;
  final _secureLocalDataSource = getIt<SecureLocalStorageService>();
  // final tokenModel = Rx<TokenModel?>(null);
  final currentUser = Rx<UserInfoOnDeviceModel?>(null);
  final _authenRepository = getIt<AuthenRepository>();
  final _userInfoOnDeviceService = getIt<UserInfoOnDeviceService>();
  final biometricsService = getIt<BiometricsService>();
  final _userRepository = getIt<UserRepository>();
  bool isRegisterAccount = true;
  final canCheckBiometrics = false.obs;

  @override
  void onInit() {
    super.onInit();

    checkAuth();
  }

  @override
  onReady() async {
    super.onReady();

    biometricsService.init(
        AppLocalizations.current
            .requestBiometricDesc(AppLocalizations.current.Continue),
        [
          AndroidAuthMessages(
            signInTitle: AppLocalizations.current.Notice,
            biometricHint: AppLocalizations.current.biometricDialogTitle,
            cancelButton: AppLocalizations.current.close,
            goToSettingsButton: AppLocalizations.current.goToSettingsButton,
            goToSettingsDescription:
                AppLocalizations.current.biometricsGoToSettingsDesc,
            biometricNotRecognized: AppLocalizations.current.bioNotRecognized,
            biometricRequiredTitle: AppLocalizations.current.bioRequiredTitle,
            biometricSuccess: AppLocalizations.current.biometricSuccess,
          ),
          IOSAuthMessages(
              cancelButton: AppLocalizations.current.close,
              goToSettingsButton: AppLocalizations.current.goToSettingsButton,
              goToSettingsDescription:
                  AppLocalizations.current.biometricsGoToSettingsDesc,
              lockOut: AppLocalizations.current.iOSLockOut),
        ]);

    canCheckBiometrics.value = await biometricsService.isDeviceSupported();
  }

  toggleAuthBiometrics({bool? value, bool? authRequired = true}) async {
    try {
      if (authRequired == true) {
        final isDeviceSupported = await biometricsService.isDeviceSupported();
        final availableBiometrics =
            (await biometricsService.getAvailableBiometrics()).isNotEmpty;

        if (!isDeviceSupported) {
          showErrorModal(AppLocalizations.current.notSupportBiometrics);
          return false;
        }

        if (availableBiometrics == false) {
          showErrorModal(AppLocalizations.current.biometricsGoToSettingsDesc);
          return false;
        }

        final authenticated =
            await biometricsService.authenticateWithBiometrics();
        if (!authenticated) {
          return false;
        }
      }

      final getCurrentUser =
          await _userInfoOnDeviceService.getUser(currentUser.value!.uid);

      final newUser = getCurrentUser;
      newUser?.useBiometric = value ?? !(getCurrentUser?.useBiometric ?? false);
      currentUser.value = newUser;

      await _userInfoOnDeviceService.addOrUpdate(newUser!);

      currentUser.update((val) {
        val?.useBiometric = newUser.useBiometric;
      });

      return true;
    } catch (e, s) {
      exceptionHandler(GenericException(error: e, stack: s));
      showErrorModal(AppLocalizations.current.notSupportBiometrics);
      return false;
    }
  }

  checkAuth() async {
    try {
      var uid = await _secureLocalDataSource.getLastData(USERNAME_KEY);

      if (AppConfig.customerId != "" && AppConfig.customerId != uid) {
        await signOut();

        uid = AppConfig.customerId;
        final failureOrUserInfor = await _authenRepository.getUserStatus(uid);

        failureOrUserInfor.fold((l) async {
          if ((l.error is ServerException) &&
              (l.error as ServerException).codeDesc == "IDENTITY_NOT_FOUND") {
            Get.to(()=>RegisterAccountPage());
          }
        }, (r) async {});

        return;
      }

      final tokenString =
          await _secureLocalDataSource.getLastData(LOCAL_ACCESS_TOKEN_AUTH);
      if (tokenString != null) {
        var token = TokenModel.fromJson(tokenString);
        if (token.expireTime!.millisecondsSinceEpoch >
            DateTime.now().millisecondsSinceEpoch + 3 * 60 * 1000) {
          authStatus.value = AuthenticationStatus.authenticated;
          final allUsers = await _userInfoOnDeviceService.getAllUsers();
          if (allUsers.isNotEmpty) {
            currentUser.value = allUsers.first;
          }
          //TODO: Kiểm tra trạng thái User
        } else {
          final password =
              await _secureLocalDataSource.getLastData(PASSWORD_KEY);
          if (password != null && uid != null) onLogin(uid, password);
        }
      }
      if (uid == null) {
        return;
      }
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  signOut() async {
    try {
      await _secureLocalDataSource.removeData(LOCAL_ACCESS_TOKEN_AUTH);
      await _secureLocalDataSource.removeData(FULLNAME_KEY);
      authStatus.value = AuthenticationStatus.unauthenticated;

      final appController = Get.find<AppController>();
      appController.selectedIndex.value = 0;
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  loginWithBiometric() async {
    try {
      var authenticated = await biometricsService.authenticateWithBiometrics();

      if (authenticated == true && currentUser.value != null) {
        onLogin(currentUser.value!.uid, currentUser.value!.password);
      }
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  onLogin(String uid, String password,
      {bool isFromCreateAccount = false}) async {
    try {
      showProgress();
      authStatus.value = AuthenticationStatus.unauthenticated;

      final failureOrTokenModel = await _authenRepository
          .getAccessToken(LoginRequestModel(uid, password));
      TokenModel? token;
      hideProgress(closeOverlays: true);

      failureOrTokenModel.fold(
        (failure) {
          try {
            String error =
                (failure.error as dynamic).response!.data['error_description'];
            if (error.toLowerCase().contains("no account") ||
                error.toLowerCase().contains("account not found") ||
                error.contains("Không tìm thấy thông tin tài khoản") ||
                error.contains("Tài khoản không tồn tại")) {
              showNotifyModal(exceptionHandler(failure),
                  titleBtnAccept: AppLocalizations.current.createAccount,
                  actionAccept: () {
                Get.to(() => RegisterAccountPage());
              }, onlyActionCancel: false);
              return;
            }
          } catch (e) {
            print(e);
          }

          showErrorModal(exceptionHandler(failure));
        },
        (_token) {
          token = _token;
          // Cache Token, Username, Password
        },
      );

      if (token == null) {
        return false;
      }

      authStatus.value = AuthenticationStatus.authenticated;

      if (isFromCreateAccount != true) {
        final hostAppController = Get.find<HostAppController>();
        await hostAppController.checkCerts();
      } else {
        // if (isShowBuyCert == true && AppConfig.packageDefault != "") {
        //   Get.to(() => CertificatePackScreen());
        // }
      }

      if (Get.isRegistered<HomeController>() == true) {
        final homeController = Get.find<HomeController>();
        homeController.onReady();
      }

      await _secureLocalDataSource.saveData(
          LOCAL_ACCESS_TOKEN_AUTH, token!.toJson());

      _secureLocalDataSource.saveData(USERNAME_KEY, uid);
      _secureLocalDataSource.saveData(PASSWORD_KEY, password);
      // tokenModel.value = token;

      await getProfile(uid, password);

      return true;
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  getProfile(String uid, String password) async {
    var user = await _userInfoOnDeviceService.getUser(uid);
    if (user != null) {
      user.password = password;
      user.uid = uid;
    } else {
      user = UserInfoOnDeviceModel(uid: uid, password: password);
    }

    // if (user.displayName.isNullOrEmpty ||
    //     user.phone.isNullOrEmpty ||
    //     user.email.isNullOrEmpty) {
    bool finished = false;
    int count = 0;

    while (finished == false && count < 3) {
      final response = await _userRepository.getProfile();
      count++;
      response.fold(
        (l) {
          user?.displayName = "";
          user?.phone = "";
          user?.email = "";
          finished = false;
        },
        (r) {
          user?.displayName = r.fullName;
          user?.phone = r.phone?.trim();
          user?.email = r.email?.trim();
          user?.accType = r.accType;
          finished = true;
        },
      );

      if (finished == false) {
        await Future.delayed(Duration(seconds: count + 3), () {});
      }
    }

    currentUser.value = user;
    // Lưu thông tin đăng nhập
    await _userInfoOnDeviceService.addOrUpdate(user);
  }
}
