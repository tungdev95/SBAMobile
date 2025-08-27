// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i5;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i11;

import '../../core/models/app/econtract_api_config.dart' as _i7;
import '../../core/models/app/eseal_api_config.dart' as _i40;
import '../../core/models/app/smartca_api_config.dart' as _i18;
import '../../core/services/biometrics.dart' as _i4;
import '../../core/services/crypto/aes_encryption_util.dart' as _i3;
import '../../core/services/crypto/jwt_util.dart' as _i12;
import '../../core/services/crypto/kak_utils.dart' as _i16;
import '../../core/services/crypto/message_digest.dart' as _i13;
import '../../core/services/device_info.dart' as _i6;
import '../../core/services/network_info_service.dart' as _i15;
import '../../core/services/secure_local_storage.dart' as _i17;
import '../../core/services/user_info_on_device.dart' as _i26;
import '../../data/network/auth_api.dart' as _i29;
import '../../data/network/cert_api.dart' as _i31;
import '../../data/network/change_password_api.dart' as _i33;
import '../../data/network/check_uid_api.dart' as _i35;
import '../../data/network/confirm_information_api.dart' as _i37;
import '../../data/network/ekyc_api.dart' as _i39;
import '../../data/network/eseal/3rd_eseal_api.dart' as _i62;
import '../../data/network/eseal/api_gateway_eseal.dart' as _i58;
import '../../data/network/eseal/auth_api_eseal.dart' as _i59;
import '../../data/network/eseal/cert_api_eseal.dart' as _i60;
import '../../data/network/eseal/transaction_api_eseal.dart' as _i64;
import '../../data/network/order_cert_api.dart' as _i44;
import '../../data/network/otp_verify_api.dart' as _i42;
import '../../data/network/purchase_certificate_api.dart' as _i46;
import '../../data/network/send_log_api.dart' as _i48;
import '../../data/network/service_pack_api.dart' as _i50;
import '../../data/network/service_pack_history_api.dart' as _i51;
import '../../data/network/sign_bill_api.dart' as _i54;
import '../../data/network/smartca_api_gateway.dart' as _i20;
import '../../data/network/transaction_api.dart' as _i21;
import '../../data/network/transaction_history_api.dart' as _i22;
import '../../data/network/transaction_request_api.dart' as _i24;
import '../../data/network/verify_identifier_api.dart' as _i27;
import '../../data/repository/active_account_repository.dart' as _i57;
import '../../data/repository/authen_repository.dart' as _i30;
import '../../data/repository/certificate_repository.dart' as _i32;
import '../../data/repository/change_password_repository.dart' as _i34;
import '../../data/repository/check_uid_repository.dart' as _i36;
import '../../data/repository/confirm_information_repository.dart' as _i38;
import '../../data/repository/eseal/3rd_repository.dart' as _i63;
import '../../data/repository/eseal/certificate_repository.dart' as _i61;
import '../../data/repository/eseal/transaction_repository.dart' as _i65;
import '../../data/repository/order_cert_repository.dart' as _i45;
import '../../data/repository/otp_verify_repository.dart' as _i43;
import '../../data/repository/purchase_certificate_repository.dart' as _i47;
import '../../data/repository/send_log_repository.dart' as _i49;
import '../../data/repository/service_pack_history_respository.dart' as _i52;
import '../../data/repository/service_pack_page_respository.dart' as _i53;
import '../../data/repository/sign_bill_repository.dart' as _i55;
import '../../data/repository/transaction_history_repository.dart' as _i23;
import '../../data/repository/transaction_repository.dart' as _i10;
import '../../data/repository/transaction_request_repository.dart' as _i25;
import '../../data/repository/user_repository.dart' as _i56;
import '../../data/repository/verify_identifier_repository.dart' as _i28;
import '../../method_channel_handler.dart' as _i14;
import '../econtract_api_gw_config.dart' as _i8;
import '../eseal_api_gw_config.dart' as _i41;
import '../register_module.dart' as _i66;
import '../smartca_api_gw_config.dart' as _i19;

const String _prod = 'prod';
const String _dev = 'dev';

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule(getIt);
  gh.factory<_i3.AESEncryptionService>(
      () => registerModule.aESEncryptionService);
  gh.lazySingleton<_i4.BiometricsService>(
      () => registerModule.biometricsService);
  gh.lazySingleton<_i5.Connectivity>(() => registerModule.connectivity);
  gh.factory<_i6.DeviceInfoService>(() => registerModule.deviceInfoService);
  gh.singleton<_i7.EContractApiGWConfig>(
    _i8.EContractApiGWConfigDemo(),
    registerFor: {_dev},
  );
  gh.singleton<_i7.EContractApiGWConfig>(
    _i8.EContractApiGWConfigPro(),
    registerFor: {_prod},
  );
  gh.factory<_i9.FlutterSecureStorage>(
      () => registerModule.flutterSecureStorage);
  gh.lazySingleton<_i10.GenerateSADUtils>(() => _i10.GenerateSADUtils());
  gh.lazySingleton<_i11.InternetConnectionChecker>(
      () => registerModule.connectionChecker);
  gh.factory<_i12.JWTService>(() => registerModule.jWTService);
  gh.factory<_i13.MessageDigestService>(
      () => registerModule.messageDigestService);
  gh.singleton<_i14.MethodChannelHandler>(_i14.MethodChannelHandler());
  gh.lazySingleton<_i15.NetworkInfoService>(
      () => registerModule.thirdPartyType);
  gh.factory<_i16.RsaKeyService>(() => registerModule.rsaKeyService);
  gh.lazySingleton<_i17.SecureLocalStorageService>(
      () => registerModule.secureLocalStorageService);
  gh.singleton<_i18.SmartCAApiConfig>(
    _i19.SmartCAApiGWConfigPro(),
    registerFor: {_prod},
  );
  gh.singleton<_i18.SmartCAApiConfig>(
    _i19.SmartCAApiGWConfigDemo(),
    registerFor: {_dev},
  );
  gh.factory<_i20.SmartCAApiGateway<dynamic>>(
      () => registerModule.smartCAApiGateway);
  gh.factory<_i21.TransactionApi>(
      () => _i21.TransactionApi(gh<_i20.SmartCAApiGateway<dynamic>>()));
  gh.factory<_i22.TransactionHistoryApi>(
      () => _i22.TransactionHistoryApi(gh<_i20.SmartCAApiGateway<dynamic>>()));
  gh.factory<_i23.TransactionHistoryRepository>(
      () => registerModule.transactionHistoryRepository);
  gh.factory<_i10.TransactionRepository>(
      () => registerModule.transactionRepository);
  gh.factory<_i24.TransactionRequestApi>(
      () => _i24.TransactionRequestApi(gh<_i20.SmartCAApiGateway<dynamic>>()));
  gh.factory<_i25.TransactionRequestRepository>(
      () => registerModule.transactionRequestRepository);
  gh.lazySingleton<_i26.UserInfoOnDeviceService>(
      () => registerModule.userInfoOnDeviceService);
  gh.factory<_i27.VerifyIdentifierApi>(
      () => _i27.VerifyIdentifierApi(gh<_i20.SmartCAApiGateway<dynamic>>()));
  gh.factory<_i28.VerifyIdentifierRepository>(
      () => registerModule.verifyIdentifierRepository);
  gh.factory<_i29.AuthRemoteApi>(() => registerModule.authenApi);
  gh.factory<_i30.AuthenRepository>(() => registerModule.authenRepository);
  gh.factory<_i31.CertApi>(
      () => _i31.CertApi(gh<_i20.SmartCAApiGateway<dynamic>>()));
  gh.factory<_i32.CertificateRepository>(
      () => registerModule.certificateRepository);
  gh.factory<_i33.ChangePasswordApi>(
      () => _i33.ChangePasswordApi(gh<_i20.SmartCAApiGateway<dynamic>>()));
  gh.factory<_i34.ChangePasswordRepository>(
      () => registerModule.changePasswordRepository);
  gh.factory<_i35.CheckUidApi>(
      () => _i35.CheckUidApi(gh<_i20.SmartCAApiGateway<dynamic>>()));
  gh.factory<_i36.CheckUidRepository>(() => registerModule.checkUidRepository);
  gh.factory<_i37.ConfirmInformationApi>(
      () => _i37.ConfirmInformationApi(gh<_i20.SmartCAApiGateway<dynamic>>()));
  gh.factory<_i38.ConfirmInformationRepository>(
      () => registerModule.confirmInformationRepository);
  gh.factory<_i39.EKycRemoteApi>(() => _i39.EKycRemoteApi(
        gh<_i18.SmartCAApiConfig>(),
        gh<_i20.SmartCAApiGateway<dynamic>>(),
      ));
  gh.singleton<_i40.EsealApiConfig>(
    _i41.EsealApiGWConfigDemo(gh<_i18.SmartCAApiConfig>()),
    registerFor: {_dev},
  );
  gh.singleton<_i40.EsealApiConfig>(
    _i41.EsealApiGWConfigPro(gh<_i18.SmartCAApiConfig>()),
    registerFor: {_prod},
  );
  gh.factory<_i42.OTPVerifyApi>(
      () => _i42.OTPVerifyApi(gh<_i20.SmartCAApiGateway<dynamic>>()));
  gh.factory<_i43.OTPVerifyRepository>(
      () => registerModule.otpVerifyRepository);
  gh.factory<_i44.OrderCertApi>(
      () => _i44.OrderCertApi(gh<_i20.SmartCAApiGateway<dynamic>>()));
  gh.factory<_i45.OrderCertRepository>(
      () => registerModule.orderCertRepository);
  gh.factory<_i46.PurchaseCertificateApi>(
      () => _i46.PurchaseCertificateApi(gh<_i20.SmartCAApiGateway<dynamic>>()));
  gh.factory<_i47.PurchaseCertificateRepository>(
      () => registerModule.purchaseCertificateRepository);
  gh.lazySingleton<_i48.SendLogAPI>(() => registerModule.sendLogAPI);
  gh.lazySingleton<_i49.SendLogRepository>(
      () => registerModule.sendLogRepository);
  gh.factory<_i50.ServicePackApi>(
      () => _i50.ServicePackApi(gh<_i20.SmartCAApiGateway<dynamic>>()));
  gh.factory<_i51.ServicePackHistoryApi>(
      () => _i51.ServicePackHistoryApi(gh<_i20.SmartCAApiGateway<dynamic>>()));
  gh.factory<_i52.ServicePackHistoryRepository>(
      () => registerModule.servicePackHistoryRepository);
  gh.factory<_i53.ServicePackRepository>(
      () => registerModule.servicePackRepository);
  gh.factory<_i54.SignBillApi>(
      () => _i54.SignBillApi(gh<_i20.SmartCAApiGateway<dynamic>>()));
  gh.factory<_i55.SignBillRepository>(() => registerModule.signBillRepository);
  gh.factory<_i56.UserRepository>(() => registerModule.userRepository);
  gh.factory<_i57.ActiveAccountRepository>(
      () => registerModule.activeAccountRepository);
  gh.factory<_i58.ApiGatewayEseal<dynamic>>(
      () => registerModule.apiGatewayEseal);
  gh.factory<_i59.AuthApiEseal>(
      () => _i59.AuthApiEseal(gh<_i58.ApiGatewayEseal<dynamic>>()));
  gh.factory<_i60.CertApiEseal>(
      () => _i60.CertApiEseal(gh<_i58.ApiGatewayEseal<dynamic>>()));
  gh.factory<_i61.CertificateRepositoryEseal>(
      () => registerModule.certificateRepositoryEseal);
  gh.factory<_i62.ThirdPartyApiEseal>(
      () => _i62.ThirdPartyApiEseal(gh<_i58.ApiGatewayEseal<dynamic>>()));
  gh.factory<_i63.ThirdPartyRepositoryEseal>(
      () => registerModule.thirdPartyRepositoryEseal);
  gh.factory<_i64.TransactionEsealApi>(() => _i64.TransactionEsealApi(
        gh<_i58.ApiGatewayEseal<dynamic>>(),
        gh<_i40.EsealApiConfig>(),
      ));
  gh.factory<_i65.TransactionRepositoryEseal>(
      () => registerModule.transactionRepositoryEseal);
  return getIt;
}

class _$RegisterModule extends _i66.RegisterModule {
  _$RegisterModule(this._getIt);

  final _i1.GetIt _getIt;

  @override
  _i3.AESEncryptionService get aESEncryptionService =>
      _i3.AESEncryptionService();

  @override
  _i4.BiometricsService get biometricsService => _i4.BiometricsService();

  @override
  _i6.DeviceInfoService get deviceInfoService => _i6.DeviceInfoService();

  @override
  _i12.JWTService get jWTService => _i12.JWTService();

  @override
  _i13.MessageDigestService get messageDigestService =>
      _i13.MessageDigestService();

  @override
  _i15.NetworkInfoService get thirdPartyType => _i15.NetworkInfoService(
        _getIt<_i11.InternetConnectionChecker>(),
        _getIt<_i5.Connectivity>(),
      );

  @override
  _i16.RsaKeyService get rsaKeyService => _i16.RsaKeyService();

  @override
  _i17.SecureLocalStorageService get secureLocalStorageService =>
      _i17.SecureLocalStorageService(_getIt<_i9.FlutterSecureStorage>());

  @override
  _i20.SmartCAApiGateway<dynamic> get smartCAApiGateway =>
      _i20.SmartCAApiGateway<dynamic>(
        _getIt<_i18.SmartCAApiConfig>(),
        _getIt<_i17.SecureLocalStorageService>(),
        _getIt<_i15.NetworkInfoService>(),
      );

  @override
  _i23.TransactionHistoryRepository get transactionHistoryRepository =>
      _i23.TransactionHistoryRepository(_getIt<_i22.TransactionHistoryApi>());

  @override
  _i10.TransactionRepository get transactionRepository =>
      _i10.TransactionRepository(_getIt<_i21.TransactionApi>());

  @override
  _i25.TransactionRequestRepository get transactionRequestRepository =>
      _i25.TransactionRequestRepository(_getIt<_i24.TransactionRequestApi>());

  @override
  _i26.UserInfoOnDeviceService get userInfoOnDeviceService =>
      _i26.UserInfoOnDeviceService();

  @override
  _i28.VerifyIdentifierRepository get verifyIdentifierRepository =>
      _i28.VerifyIdentifierRepository(_getIt<_i27.VerifyIdentifierApi>());

  @override
  _i29.AuthRemoteApi get authenApi => _i29.AuthRemoteApi(
        _getIt<_i18.SmartCAApiConfig>(),
        _getIt<_i20.SmartCAApiGateway<dynamic>>(),
        _getIt<_i7.EContractApiGWConfig>(),
      );

  @override
  _i30.AuthenRepository get authenRepository => _i30.AuthenRepository(
        _getIt<_i29.AuthRemoteApi>(),
        _getIt<_i17.SecureLocalStorageService>(),
      );

  @override
  _i32.CertificateRepository get certificateRepository =>
      _i32.CertificateRepository(_getIt<_i31.CertApi>());

  @override
  _i34.ChangePasswordRepository get changePasswordRepository =>
      _i34.ChangePasswordRepository(_getIt<_i33.ChangePasswordApi>());

  @override
  _i36.CheckUidRepository get checkUidRepository =>
      _i36.CheckUidRepository(_getIt<_i35.CheckUidApi>());

  @override
  _i38.ConfirmInformationRepository get confirmInformationRepository =>
      _i38.ConfirmInformationRepository(_getIt<_i37.ConfirmInformationApi>());

  @override
  _i43.OTPVerifyRepository get otpVerifyRepository =>
      _i43.OTPVerifyRepository(_getIt<_i42.OTPVerifyApi>());

  @override
  _i45.OrderCertRepository get orderCertRepository =>
      _i45.OrderCertRepository(_getIt<_i44.OrderCertApi>());

  @override
  _i47.PurchaseCertificateRepository get purchaseCertificateRepository =>
      _i47.PurchaseCertificateRepository(_getIt<_i46.PurchaseCertificateApi>());

  @override
  _i48.SendLogAPI get sendLogAPI =>
      _i48.SendLogAPI(_getIt<_i20.SmartCAApiGateway<dynamic>>());

  @override
  _i49.SendLogRepository get sendLogRepository => _i49.SendLogRepository(
        _getIt<_i48.SendLogAPI>(),
        _getIt<_i17.SecureLocalStorageService>(),
        _getIt<_i6.DeviceInfoService>(),
      );

  @override
  _i52.ServicePackHistoryRepository get servicePackHistoryRepository =>
      _i52.ServicePackHistoryRepository(_getIt<_i51.ServicePackHistoryApi>());

  @override
  _i53.ServicePackRepository get servicePackRepository =>
      _i53.ServicePackRepository(_getIt<_i50.ServicePackApi>());

  @override
  _i55.SignBillRepository get signBillRepository =>
      _i55.SignBillRepository(_getIt<_i54.SignBillApi>());

  @override
  _i56.UserRepository get userRepository => _i56.UserRepository(
        _getIt<_i29.AuthRemoteApi>(),
        _getIt<_i17.SecureLocalStorageService>(),
      );

  @override
  _i57.ActiveAccountRepository get activeAccountRepository =>
      _i57.ActiveAccountRepository(
        _getIt<_i29.AuthRemoteApi>(),
        _getIt<_i18.SmartCAApiConfig>(),
        _getIt<_i39.EKycRemoteApi>(),
      );

  @override
  _i58.ApiGatewayEseal<dynamic> get apiGatewayEseal =>
      _i58.ApiGatewayEseal<dynamic>(
        _getIt<_i40.EsealApiConfig>(),
        _getIt<_i17.SecureLocalStorageService>(),
        _getIt<_i15.NetworkInfoService>(),
      );

  @override
  _i61.CertificateRepositoryEseal get certificateRepositoryEseal =>
      _i61.CertificateRepositoryEseal(_getIt<_i60.CertApiEseal>());

  @override
  _i63.ThirdPartyRepositoryEseal get thirdPartyRepositoryEseal =>
      _i63.ThirdPartyRepositoryEseal(_getIt<_i62.ThirdPartyApiEseal>());

  @override
  _i65.TransactionRepositoryEseal get transactionRepositoryEseal =>
      _i65.TransactionRepositoryEseal(_getIt<_i64.TransactionEsealApi>());
}
