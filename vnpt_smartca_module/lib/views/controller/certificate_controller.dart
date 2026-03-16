import 'package:get/get.dart';
import '../../../configs/injector/injector.dart';
import '../../../data/repository/certificate_repository.dart';

import '../../core/models/app/exceptions.dart';
import '../../core/models/response/order_cert_model.dart';
import '../../core/models/response/service_response.dart';
import '../i18n/generated_locales/l10n.dart';
import '../pages/certificate/buy/order_detail_screen.dart';
import '../pages/change_device/sign_bill.dart';
import '../utils/exception_handler.dart';
import '../widgets/dialog/common_dialog.dart';
import '../widgets/dialog_notification.dart';
import 'auth_controller.dart';
import 'base_controler.dart';
import '../../core/services/secure_local_storage.dart';
import '../../core/models/response/certificate_model.dart';

class CertificateController extends BaseController {
  final certificateRepository = getIt<CertificateRepository>();

  final RxString currentName = "".obs;

  final requestChangeDeviceResponse = Rx<SmartCAApiResponse?>(null);
  final secureLocalDataSource = getIt<SecureLocalStorageService>();

  final orderCertModel = Rx<OrderCertModel?>(null);
  final showCurrentDevice = true.obs;
  final showAnotherDevice = true.obs;
  final isTick = false.obs;
  final isShowViewMore = true.obs;
  final isHaveCertHide = true.obs;
  final listCertsDefault = Rx<List<CertificateModel>>([]);
  final listCertShow = Rx<List<CertificateModel>>([]);
  final authController = Get.find<AuthController>();

  void isCheckCertHide() async {
    final currentUser = authController.currentUser.value;

    String listHide =
        await secureLocalDataSource.getLastData(currentUser!.uid) ?? '';
    if (listHide.trim().isNotEmpty) {
      isHaveCertHide.value = true;
    } else {
      isHaveCertHide.value = false;
    }
  }

  void pushListCert(List<CertificateModel> list) async {
    // showLoading();
    final currentUser = authController.currentUser.value;
    listCertsDefault.value = list;
    String listHide =
        await secureLocalDataSource.getLastData(currentUser!.uid) ?? '';
    if (listHide.trim().isNotEmpty) {
      isHaveCertHide.value = true;
    } else {
      isHaveCertHide.value = false;
    }
    List<CertificateModel> listNew = [];
    if (!isShowViewMore.value) {
      listNew = list;
      List<String> listRemove = [];
      for (var element in listCertsDefault.value) {
        if (!listHide.contains(element.id)) {
          listRemove.add(element.id);
        }
      }
      for (var value in listRemove) {
        listHide.replaceAll(",$value", "");
      }
      await secureLocalDataSource.saveData(currentUser!.uid, listHide);
    } else {
      listNew = [];
      for (var element in listCertsDefault.value) {
        if (!listHide.contains(element.id)) {
          listNew.add(element);
        }
      }
    }
    listCertShow.value = listNew.toSet().toList();
    // hideLoading();
  }

  void hideCert(String id) async {
    showLoading();
    final currentUser = authController.currentUser.value;
    String listHide =
        await secureLocalDataSource.getLastData(currentUser!.uid) ?? '';
    if (isTick.value) {
      listHide = listHide.replaceAll(",$id", "");
      // await secureLocalDataSource.saveData(HIDE_CERT_LIST, listHide);
      await secureLocalDataSource.saveData(currentUser!.uid, listHide);
      isTick.value = false;
    } else {
      await secureLocalDataSource.saveData(currentUser!.uid, "$listHide,$id");
      isTick.value = true;
    }
    hideLoading();
  }

  void isHideShowCert() async {
    if (isShowViewMore.value) {
      isShowViewMore.value = false;
    } else {
      isShowViewMore.value = true;
    }
    refresh();
  }

  void requestChangeDevice({required String id, required String serial}) async {
    showProgress();
    try {
      final failureOrVerified =
          await certificateRepository.requestChangeDevice(serial);
      hideProgress();
      failureOrVerified.fold(
        (failure) => {
          showErrorModal(exceptionHandler(failure)),
        },
        (result) {
          if (result.code == 60014) {
            // YEU CAU DA TON TAI
            Get.dialog(DialogNotification(
              content: result.message,
              titleBtnAccept: AppLocalizations.current.Continue,
              actionAccept: () {
                // GET DETAIL ORDER
                OrderCertModel resp = OrderCertModel.fromJson(result.content);
                if (resp.getTypeEnum() == OrderType.changeDevice) {
                  String orderId = resp.id;
                  Get.to(() => SignBillPage(serial: serial, orderId: orderId));
                } else {
                  Get.to(() => OrderDetailScreen(orderCertModel: resp));
                }
              },
            ));
          } else {
            OrderCertModel resp = OrderCertModel.fromJson(result.content);
            Get.to(() => SignBillPage(serial: serial, orderId: resp.id));
          }
        },
      );
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  void getDetailOrder(String idCert) async {
    showProgress();
    try {
      final failureOrVerified =
          await certificateRepository.getDetailOrder(idCert);
      hideProgress();
      failureOrVerified.fold(
        (failure) => {
          showErrorModal(exceptionHandler(failure)),
        },
        (result) {
          orderCertModel.value = result;
        },
      );
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  void changeName(String idCert, String newName) async {
    showLoading();
    try {
      final failureOrVerified =
          await certificateRepository.changeName(idCert, newName);
      hideLoading();
      failureOrVerified.fold(
        (failure) => {
          showErrorModal(exceptionHandler(failure)),
        },
        (result) {
          currentName.value = newName;
        },
      );
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }
}
