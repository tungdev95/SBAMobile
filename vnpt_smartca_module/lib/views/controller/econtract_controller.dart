import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/core/models/app/exceptions.dart';
import 'package:vnpt_smartca_module/data/repository/authen_repository.dart';
import 'package:vnpt_smartca_module/views/controller/base_controler.dart';
import 'package:vnpt_smartca_module/views/pages/sign_contract/index.dart';
import 'package:vnpt_smartca_module/views/utils/exception_handler.dart';
import '../../../views/controller/auth_controller.dart';
import '../../configs/injector/injector.dart';
import '../../core/models/response/contract_check_exist.dart';
import '../../core/services/secure_local_storage.dart';
import '../../core/services/econtract_service.dart';
import '../../core/utils/constants.dart';
import '../../data/network/auth_api.dart';
import '../widgets/dialog/common_dialog.dart';
import 'package:http/http.dart' as http;

class ContractController extends BaseController {
  AuthRemoteApi authenService = getIt<AuthRemoteApi>();
  // ContractService eContractService = ContractService();
  final _authenRepository = getIt<AuthenRepository>();
  final _localDataSource = getIt<SecureLocalStorageService>();

  // final IErrorHandlerService _errorHandlerService =
  //     Injector().errorHandlerServiceService;

  final accessTokenSSO = ''.obs;
  final refresh_token = ''.obs;

  final isContractSuccess = false.obs;
  final authStatus = false.obs;
  final requiredContract = false.obs;
  final uid = ''.obs;
  final contractData = Rx<ContractData?>(null);
  final checkAll = 0.obs;
  RxBool checkIRead1 = false.obs;
  RxBool checkIRead2 = false.obs;
  final Rx<Uint8List?> bytes = Rx<Uint8List?>(null);

  // kiểm tra lại xem hợp đồng đã tồn tại chưa?
  checkSignedExist(String orderIdContract) async {
    final result = await authenService.isSignedContract(orderIdContract);
    contractData.value = result.contractData;
  }
  //LUỒNG KÝ HỢP ĐỒNG CŨ DÙNG SDK ECONTRACT
  // Future signedContractV1({String? orderId, bool isFromListOrder = true}) async {
  //   try {
  //     if (isFromListOrder) showProgress();

  //     isContractSuccess.value = false;
  //     var token = await authenService.getAppAccessToken();
  //     String accessToken = token.accessToken;
  //     if (accessToken.isEmpty) {
  //       hideProgress();
  //       return;
  //     }
  //     uid.value = await _localDataSource.getLastData(USERNAME_KEY) ?? "";
  //     final authController = Get.find<AuthController>();
  //     final currentUser = authController.currentUser.value;

  //     final phone = currentUser?.phone ?? "";
  //     if (currentUser?.phone == null) {
  //       isContractSuccess.value = false;
  //       // showErrorModal(AppLocalizations.current.phoneNumberIncorrect);
  //     } else {
  //       final result = await authenService.ssoContract(accessToken, phone);
  //       if (result.access_token == null) {
  //         // showErrorModal(result.message);
  //         debugPrint(result.message);
  //       } else {
  //         accessTokenSSO.value = result.access_token ?? "";
  //         refresh_token.value = result.refresh_token ?? "";

  //         if (orderId.isNotNullOrBlank) {
  //           // bool? isSigned = await checkSigned(orderId!);
  //           await checkSignedExist(orderId!);

  //           if (!contractData.value!.isSigned!) {
  //             var eContractResult = await eContractService.signContract(
  //                 accessTokenSSO.value, orderId);
  //             if (eContractResult != null) {
  //               if (eContractResult['isSuccess']) {
  //                 isContractSuccess.value = eContractResult['isSuccess'];

  //                 // await authenService.eContractStatus(uid.value, orderId);
  //               }
  //             }
  //           } else {
  //             // await authenService.eContractStatus(uid.value, orderId);
  //             isContractSuccess.value = true;
  //           }
  //         } else {
  //           // showErrorModal('Không lấy được thông tin mã đơn hàng!');
  //           debugPrint('Không lấy được thông tin mã đơn hàng!');
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     // showErrorModal(S.current.contractMessage);
  //     debugPrint(e.toString());
  //   }

  //   if (isFromListOrder) hideProgress();
  // }

  //LUỒNG KÝ HỢP ĐỒNG MỚI ONLINE TOÀN TRÌNH
  Future signedContract({String? orderId, bool isFromListOrder = true}) async {
    try {
      if (isFromListOrder) showProgress();

      isContractSuccess.value = false;
      if (orderId.isNotNullOrBlank) {
        await checkSignedExist(orderId!);
        if (isFromListOrder) hideProgress();

        if (contractData.value != null) {
          if (!contractData.value!.isSigned!) {
            await Get.to(() => SignContractView(
                contractId: contractData.value!.contractId!,
                contractUrl: contractData.value!.urlPath!));
          } else {
            isContractSuccess.value = true;
          }
        }
      } else {
        debugPrint('Không lấy được thông tin mã đơn hàng!');
      }
      // }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  signedWithoutOTP(String contractId) async {
    try {
      showLoading();

      final failureOrVerified =
          await _authenRepository.signContractWithoutOTP(contractId);
      hideLoading();
      failureOrVerified.fold(
        (failure) {
          isContractSuccess.value = false;
          showNotifyModal(exceptionHandler(failure));
        },
        (result) {
          if (result.message == "ECT-00000000") {
            isContractSuccess.value = true;
            checkIRead1.value = false;
            checkIRead2.value = false;
          } else {
            isContractSuccess.value = false;
          }
        },
      );
    } catch (e, s) {
      showNotifyModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  Future<void> writeData2Pdf(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
          bytes.value = response.bodyBytes;
      }
      else {
        bytes.value = null;
      }
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  Future<bool> getContractSuccess() async {
    final isSuccess = await _localDataSource.getLastData(eCONTRACT_SUCCESS);
    if (isSuccess == "true") {
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }

  @override
  void refresh() {
    // TODO: implement refresh
    super.refresh();
  }
}
