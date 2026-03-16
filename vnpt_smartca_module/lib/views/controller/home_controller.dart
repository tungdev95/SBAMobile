// ignore_for_file: prefer_is_empty

import 'package:get/get.dart';
import 'package:vnpt_smartca_module/configs/app_config.dart';
import 'package:vnpt_smartca_module/views/controller/buy_certificate_controller.dart';
import 'package:vnpt_smartca_module/views/i18n/generated_locales/l10n.dart';
import 'package:vnpt_smartca_module/views/widgets/show_snackbar_widget.dart';
import '../../../configs/injector/injector.dart';
import '../../../core/models/response/certificate_model.dart';
import '../../../data/repository/certificate_repository.dart';
import '../../../views/controller/app_controller.dart';
import '../../../views/controller/auth_controller.dart';
import '../../../views/controller/transaction_controller.dart';
import '../../../views/widgets/app_refresh.dart';

import '../../core/models/response/order_cert_model.dart';
import '../../core/services/secure_local_storage.dart';
import '../../data/repository/order_cert_repository.dart';
import '../pages/certificate/common_action.dart';
import '../pages/certificate/setup_pin_code/index.dart';
import '../pages/register_account/certificate_pack_screen.dart';
import '../utils/color.dart';
import '../utils/enums.dart';
import '../utils/exception_handler.dart';
import 'enter_info_controller.dart';
// import 'firebase_controller.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;

  final _certificateRepository = getIt<CertificateRepository>();
  final transactionRequestController =
      Get.put(TransactionController(), permanent: true);
  final authController = Get.find<AuthController>();
  final appController = Get.find<AppController>();
  final AppRefreshController appRefreshController = AppRefreshController();
  // final firebaseController = Get.find<FirebaseController>();

  final orderCertRepository = getIt<OrderCertRepository>();
  final secureStorage = getIt<SecureLocalStorageService>();
  final listCertificate = Rx<List<CertificateModel>?>(null);
  final listOrder = Rx<List<OrderCertModel>?>(null);
  final allOrder = Rx<List<OrderCertModel>?>(null);
  final orderCertList = Rx<OrderCertListModel?>(null);

  RxBool isShowCertNotification = true.obs;
  RxBool isShowOrderNotification = true.obs;
  RxBool isShowCertNeedExtendNotification = true.obs;
  RxBool isShowCertOvertime = false.obs;

  bool get isShowOrderList {
    // Nếu có đơn hàng hoặc chứng thư chờ duyệt thì hiển thị danh sách đơn hàng
    return (listOrder.value != null &&
            listOrder.value?.length != 0 &&
            listCertificate.value?.length == 0) ||
        (listCertificate.value != null &&
            listCertificate.value?.length == 1 &&
            listCertificate.value?.first.status ==
                StatusCertEnum.WAITING_APPROVE.index);
  }

  bool get isShowBuyCert {
    // Nếu ko có đơn hàng và chứng thư nào
    return listOrder.value != null &&
        listOrder.value?.length == 0 &&
        listCertificate.value != null &&
        listCertificate.value?.length == 0;
  }

  bool get haveVaidCert {
    // Có cert đang hoạt động
    return (listCertificate.value != null &&
        listCertificate.value!
            .where((element) => element.status == StatusCertEnum.VALID.index)
            .isNotEmpty);
  }

  @override
  void onReady() {
    super.onReady();

    transactionRequestController.getTransactionRequests();
    getCertificateListWaitingActive();
    getListOrder();
    getAllOrder();
  }

  getCertificateListWaitingActive() async {
    try {
      final failureOrCertList =
          await _certificateRepository.getCertificateList();
      failureOrCertList.fold(
        (failure) {},
        (res) {
          var list = CertificateListModel.fromMap(res.content);

          listCertificate.value = list.items;
          if (list.items.length == 1 &&
              list.items
                      .where((element) =>
                          element.status == StatusCertEnum.VALID.index)
                      .length ==
                  0 &&
              list.items.first.status ==
                  StatusCertEnum.WAITING_ASSIGNED_TO_SIGNER.index) {
            final certificateModel = list.items.first;

            if (certificateModel.isWaitingActive) {
              if (certificateModel.isNeedAssignKey) {
                Get.to(() => SetupPinCodePage(
                      certificateModel: certificateModel,
                    ))?.then((value) async {});
              } else {
                CommonActionCertificate.goActiveCer(certificateModel,
                    callBackGetTo: () {});
              }
            }
          }
        },
      );
    } catch (e) {}
  }

  getListOrder() async {
    try {
      final failureOrVerified = await orderCertRepository.getOrderList();
      failureOrVerified.fold(
        (failure) => {exceptionHandler(failure)},
        (result) async {
          OrderCertListModel orderCertListModel =
              OrderCertListModel.fromMap(result.content);
          listOrder.value = orderCertListModel.items;
          orderCertList.value = orderCertListModel;
          if (AppConfig.packageDefault != "") {
            final buyCertController =
                Get.isRegistered<BuyCertificateController>()
                    ? Get.find<BuyCertificateController>()
                    : Get.put(BuyCertificateController());

            if (listOrder.value?.length == 1 &&
                listCertificate.value?.length == 0 &&
                listOrder.value?.first.status ==
                    OrderCertModel.PAYMENT_WATING) {
              buyCertController
                  .handleOrderModelByStatus(listOrder.value!.first);
            } else if (isShowBuyCert == true) {
              final enterInfoController =
                  Get.isRegistered<EnterInfoController>()
                      ? Get.find<EnterInfoController>()
                      : Get.put(EnterInfoController());

              await enterInfoController.fetchItems();

              await buyCertController.createOrder(enterInfoController
                  .listCertPacks.value.first.pricingCode
                  ?.toString());

              await getListOrder();
            }
          }
        },
      );
    } catch (e) {}
  }

  getAllOrder() async {
    try {
      final failureOrVerified = await orderCertRepository.getAllOrder();
      failureOrVerified.fold(
        (failure) => {},
        (result) async {
          OrderCertListModel orderCertListModel =
              OrderCertListModel.fromMap(result.content);
          allOrder.value = orderCertListModel.items;
          print("===== ${orderCertListModel.items.length}");
        },
      );
    } catch (e) {}
  }
}
