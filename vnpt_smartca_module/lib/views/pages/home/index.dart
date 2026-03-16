// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_is_empty

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scale_size/scale_size.dart';
import 'package:vnpt_smartca_module/views/pages/notify/extend_cert_detail.dart';
import '../../../core/models/request/history_request_model.dart';
import '../../../core/models/response/certificate_model.dart';
import '../../../core/models/response/order_cert_model.dart';
import '../../../core/models/response/transaction_model.dart';
import '../../../gen/assets.gen.dart';
import '../../controller/app_controller.dart';
import '../../controller/auth_controller.dart';
import '../../controller/certificate_controller.dart';
import '../../controller/extend_certificate_controller.dart';
import '../../controller/home_controller.dart';
import '../../i18n/generated_locales/l10n.dart';
import '../../pages/account_information/index.dart';
import '../../pages/certificate/common_action.dart';
import '../../pages/doc_sign_history/index.dart';
import '../../pages/transaction_request/index.dart';
import '../../widgets/app_refresh.dart';
import '../../widgets/dialog/modal_bottom_sheet.dart';
import '../../widgets/widget.dart';

import '../certificate/buy/order_detail_screen.dart';
import '../certificate/buy/order_list_screen.dart';
import '../certificate/extend/select_cert_to_extend_screen.dart';
import '../certificate/select_cert_screen.dart';
import '../certificate/setup_pin_code/index.dart';
import '../register_account/certificate_pack_screen.dart';
import 'widgets/biometric_auth.dart';
import 'widgets/doc_sign_history.dart';

class HomePage extends StatelessWidget {
  final controller = Get.isRegistered<HomeController>()
      ? Get.find<HomeController>()
      : Get.put(HomeController(), permanent: true);

  final authController = Get.find<AuthController>();

  HomePage({super.key}) {
    Timer(
      Duration(milliseconds: 500),
      () async {
        if (authController.currentUser.value?.useBiometric == null &&
            (await authController.biometricsService.getAvailableBiometrics())
                .isNotEmpty &&
            authController.canCheckBiometrics.value == true) {
          CustomBottomSheetDialog.show(
            isScrollControlled: true,
            title: AppLocalizations.current.biometricAuthentication,
            childBuilder: (context) => BiometricAuthWidget(),
          );
        }
      },
    );
  }

  recentHistory() {
    return [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.to(() => TransactionRequests()),
              child: BaseText(
                AppLocalizations.current.recentTransactions,
                color: Color(0xff08285C),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => const ListDocSignHistoryPage());
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: BaseText(
                  AppLocalizations.current.viewMore,
                  color: Color(0xff0D75D6),
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: AppRefresh<TransactionModel>(
          path: "/csc/signature/his",
          keyController: "/csc/signature/his",
          fromMap: TransactionModel.fromMap,
          params:
              HistoryRequestModel(order: 'InitialDate', isDesc: true).toMap(),
          appRefreshController: controller.appRefreshController,
          itemWidgetBuilder: (value, index) {
            return DocSignatureHistoryWidget(value: value);
          },
          // filter: (value) {
          //   final currentUser = Get.find<AuthController>().currentUser;
          //   if (currentUser.value?.accType == 1) {
          //     try {
          //       final deviceId =
          //           Get.find<AppController>().deviceInfo.value?.deviceId;
          //       final listCertActivedOnDevice = Get.find<HomeController>()
          //               .listCertificate
          //               .value
          //               ?.where(
          //                   (element) => element.device?.deviceID == deviceId)
          //               .map((e) => e.id) ??
          //           [];

          //       return listCertActivedOnDevice.contains(value.credentialId);
          //     } catch (e) {}
          //   }
          //   return true;
          // },
          isLoadMore: false,
          itemSpace: 8,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          _UserProfileWidget(),
          NotificationWidget(),
          if (controller.isShowOrderList &&
              controller
                  .transactionRequestController.transactionRequestList.isEmpty)
            Expanded(
                child: OrderListScreen(
              hiddenBack: true,
              hiddenFiltter: true,
              appBarColor: const Color.fromRGBO(241, 244, 250, 1),
              appBarBoxShadowColor: Colors.transparent,
            )),
          if (controller.isShowBuyCert)
            Expanded(
                child: CertificatePackScreen(
              hideAppBar: true,
            )),
          if (!controller.isShowOrderList &&
              !controller.isShowBuyCert &&
              controller.transactionRequestController.transactionRequestList
                  .isEmpty) ...[
            if (controller.haveVaidCert) ...recentHistory(),
          ],
          if (controller.transactionRequestController.transactionRequestList
              .isNotEmpty) ...[
            Expanded(child: TransactionRequests()),
          ],
        ],
      );
    });
  }
}

// class _UserNotificationWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return _CardWrapperWidget(
//       child: Container(
//         padding: EdgeInsets.all(8),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Assets.images.icHomeNotification
//                 .image(width: 24, height: 24, fit: BoxFit.fill),
//             SizedBox(width: 8),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   BaseText(
//                     "Chứng thư số 01",
//                     color: Color(0xff0D75D6),
//                     fontWeight: FontWeight.w700,
//                     height: 21 / 14,
//                   ),
//                   SizedBox(height: 4),
//                   BaseText(
//                     "Nhấn để hiển thị mã OTP của chứng thư số",
//                     color: Color(0xff08285C),
//                     height: 21 / 14,
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class _UserProfileWidget extends StatelessWidget {
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 1.top + 6, bottom: 9),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Color(0xffe9ecf4), blurRadius: 20, spreadRadius: 1)
      ]),
      child: InkWell(
        onTap: () {
          Get.to(() => AccountInformationPage());
        },
        child: Row(
          children: [
            Assets.images.icHomeLogo
                .image(fit: BoxFit.fill, width: 50, height: 50),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => BaseText(
                      (controller.currentUser.value?.displayName ?? "")
                          .capitalize,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.5,
                      color: Color(0xff08285C),
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(height: 3),
                  Obx(
                    () => BaseText(
                      AppLocalizations.current
                          .citizenId(controller.currentUser.value?.uid ?? ""),
                      // fontSize: 15.sw,
                      color: Color(0xff5768A5),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  final controller = Get.find<HomeController>();
  final appController = Get.find<AppController>();
  final ExtendCertificateController extendCertificateController =
      Get.put(ExtendCertificateController());
  bool _isShowCert = true;
  bool _isShowOrder = true;
  bool _isShowCertNeedExtend = true;
  List<CertificateModel> _listCert = [];
  List<CertificateModel> _listCertNeedExtend = [];
  List<OrderCertModel>? _listOrder = [];
  List<CertificateModel> _listCertOvertime = [];

  int _orderCount = 0;
  int _currentPage = 0;

  @override
  void initState() {
    // debugPrint(">>>>controller.getCertificateListWaitingActive();");
    // controller.getCertificateListWaitingActive();
    _isShowCert = controller.isShowCertNotification.value;
    _isShowOrder = controller.isShowOrderNotification.value;
    _isShowCertNeedExtend = controller.isShowCertNeedExtendNotification.value;

    // ever(controller.listCertificate, (p0) {
    //   if (mounted) {
    //     if (p0 == null) {
    //       _listCert = [];
    //       _listCertNeedExtend = [];
    //     } else {
    //       _listCert = p0
    //           .where((element) => element.countCertNotificationInHome())
    //           .toList();
    //       _listCertNeedExtend = p0
    //           .where(
    //               (element) => element.countCertNeedNotificationExtendInHome())
    //           .toList();
    //     }

    //     setState(() {});
    //   }
    // });

    // ever(controller.orderCertList, (p0) {
    //   if (mounted) {
    //     if (p0 != null) {
    //       setState(() {
    //         _listOrder = p0.items;
    //         _orderCount = p0.totalItemCount;
    //       });
    //     }
    //   }
    // });

    super.initState();
  }

  _renderViewV2() {
    List<Widget> widgets = [];
    // cert active
    if (_isShowCert == true && _listCert.isNotEmpty) {
      widgets.add(_renderCertView());
    }
    // cert need extend
    if (_isShowCertNeedExtend == true && _listCertNeedExtend.isNotEmpty) {
      widgets.add(_renderCertNeedExtendView());
    }
    // order
    if (_isShowOrder == true && _listOrder != null && _listOrder!.isNotEmpty) {
      var orderView = _renderOrderView();
      if (orderView != null) {
        widgets.add(orderView);
      }
    }
    
    if (controller.isShowCertOvertime.value == true &&
        _listCertOvertime.isNotEmpty == true) {
      widgets.add(_renderCertOvertime());
    }

    if (widgets.isEmpty) {
      return const SizedBox();
    }

    return _renderOrderAndCertView(widgets);
  }

  _renderView() {
    // chỉ có thông báo về cert
    if (_isShowCert == true &&
        _listCert.isNotEmpty &&
        (_isShowOrder == false || _orderCount == 0)) {
      return Container(
        margin: EdgeInsets.only(top: 16.sw, right: 16.sw, left: 16.sw),
        child: _renderCertView(),
      );
    }
    // chỉ có thông báo về order
    if (_isShowOrder == true &&
        _orderCount > 0 &&
        _listOrder != null &&
        _listOrder!.isNotEmpty &&
        (_isShowCert == false || _listCert.isEmpty)) {
      return Container(
        margin: EdgeInsets.only(top: 16.sw, right: 16.sw, left: 16.sw),
        child: _renderOrderView(),
      );
    }
    // có cả hai
    if (_isShowOrder == true &&
        _orderCount > 0 &&
        _listOrder != null &&
        _listOrder!.isNotEmpty &&
        _isShowCert == true &&
        _listCert.isNotEmpty) {
      return _renderOrderAndCertView([_renderCertView(), _renderOrderView()]);
    }
    // không có cả hai
    return const SizedBox();
  }

  _renderOrderAndCertView(List<Widget> widgets) {
    return Column(
      children: [
        const SizedBox(height: 15),
        CarouselSlider(
            items: widgets,
            options: CarouselOptions(
              onPageChanged: (int index, CarouselPageChangedReason reason) {
                setState(() {
                  _currentPage = index;
                });
              },
              autoPlay: widgets.length > 1,
              aspectRatio: 16 / 9,
              height: 100.sw,
              viewportFraction: 0.9,
              enlargeFactor: 0.2,
              enlargeCenterPage: true,
            )),
        Visibility(
            visible: widgets.length > 1, child: const SizedBox(height: 15)),
        Visibility(
          visible: widgets.length > 1,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgets.map((e) {
                int index = widgets.indexOf(e);
                Color color = const Color(0xffCFE3F7);
                if (index == _currentPage) {
                  color = const Color(0xff0D75D6);
                }
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: color),
                );
              }).toList()),
        )
      ],
    );
  }

  _renderCertView() {
    var list = _listCert;
    return _renderNotificationView(
        AppLocalizations.current.activeCer,
        AppLocalizations.current.numberWaitingActiveCer(list.length),
        AppLocalizations.current.activeNow, () {
      if (list.length == 1) {
        if (list.first.isNeedAssignKey) {
          Get.to(() => SetupPinCodePage(certificateModel: list.first));
        } else {
          CommonActionCertificate.goActiveCer(list.first, callBackGetTo: () {
            controller.getCertificateListWaitingActive();
          });
        }
      } else {
        appController.selectTab(1);
      }
    }, () {
      setState(() {
        _isShowCert = false;
        controller.isShowCertNotification.value = false;
      });
    });
  }

  _renderCertNeedExtendView() {
    var list = _listCertNeedExtend;
    var listValidNeedExtend =
        _listCertNeedExtend.where((element) => element.isValid()).toList();
    return _renderNotificationView(
        AppLocalizations.current.renewCertOrder,
        // AppLocalizations.current.yourCertNeedExtend,
        listValidNeedExtend.isEmpty
            ? AppLocalizations.current.yourCertExpiredNeedExtend(list.length)
            : (listValidNeedExtend.length == list.length
                ? AppLocalizations.current.yourCertValidNeedExtend(list.length)
                : AppLocalizations.current.yourCertExpiredAndValidNeedExtend(
                    list.length - listValidNeedExtend.length,
                    listValidNeedExtend.length)),
        list.length > 1
            ? AppLocalizations.current.view_detail
            : (list.first.isPersonalCert()
                ? AppLocalizations.current.extend_now
                : AppLocalizations.current.view_detail), () async {
      // kiem tra tai khoan nhan vien hay doanh nghiep
      // bool isCheck = await extendCertificateController
      //     .checkBusinessesAccount(AppLocalizations.current.extend);
      // if (!isCheck) {
      //   return;
      // }
      // // trang thai hoat dong va khong phai la cert Ca nhan trong DN
      // List<CertificateModel> listCertOK = [];
      // try {
      //   listCertOK = list
      //       .where((i) => i.isValidOrExpired() && i.isIndividualCert())
      //       .toList();
      // } catch (e) {
      //   listCertOK = [];
      // }

      // if (listCertOK.isEmpty) {
      //   // khong the gia han vi khong co CTS hop le
      //   Get.dialog(
      //     DialogNotification(
      //       title: AppLocalizations.current.can_not_extend_cert,
      //       content: AppLocalizations.current.can_not_extend_cert_description,
      //       // image: image,
      //       onlyActionAccept: true,
      //       titleBtnAccept: AppLocalizations.current.agree,
      //     ),
      //   );
      //   return;
      // }

      if (list.length == 1) {
        if (list.first.isPersonalCert()) {
          // chuyen sang man chon goi cuoc luon
          extendCertificateController.handleCert(list.first);
        } else {
          Get.to(() => ExtendCertDetailNotify(certificateModel: list.first));
        }
      } else {
        Get.to(() => SelectCertToExtendScreen());
      }
    }, () {
      setState(() {
        _isShowCertNeedExtend = false;
        controller.isShowCertNeedExtendNotification.value = false;
      });
    });
  }

  _renderOrderView() {
    String title = "";
    String formatOrderCount =
        _orderCount < 10 ? "0$_orderCount" : "$_orderCount";
    if (_orderCount == 1) {
      OrderCertModel firstOrder = _listOrder!.first;
      if (firstOrder.isWaitingEKYC()) {
        title =
            AppLocalizations.current.numberEKYCNotComplete(formatOrderCount);
      } else if (firstOrder.isWaitingPayment()) {
        title =
            AppLocalizations.current.numberPaymentNotComplete(formatOrderCount);
      } else if (firstOrder.isWaitingContract()) {
        title = AppLocalizations.current
            .numberContractNotComplete(formatOrderCount);
      } else if (firstOrder.isOrderError()) {
        title =
            AppLocalizations.current.numberActionNotComplete(formatOrderCount);
      } else {
        return null;
      }
    } else {
      title =
          AppLocalizations.current.numberRegisterNotComplete(formatOrderCount);
    }
    return _renderNotificationView(
        title, "", AppLocalizations.current.view_detail, () {
      if (_listOrder != null) {
        if (_listOrder!.isNotEmpty) {
          if (_orderCount == 1) {
            Get.to(() => OrderDetailScreen(orderCertModel: _listOrder!.first));
          } else {
            Get.to(() => OrderListScreen());
          }
        }
      }
    }, () {
      setState(() {
        _isShowOrder = false;
        controller.isShowOrderNotification.value = false;
      });
    });
  }

  _renderNotificationView(String title, String description, String actionText,
      Function? onTap, Function? onClose) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange.shade100),
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: Assets.images.bgNotificaion.provider()),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _renderContent(title, description, actionText),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child:
                      Assets.images.icNotification.image(width: 60, height: 60),
                )
              ],
            ),
          ),
          Positioned(
            top: -4,
            right: -4,
            child: InkWell(
              onTap: () {
                onClose?.call();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Assets.images.icQrClose
                    .image(width: 14, height: 14, color: Color(0xff5768A5)),
              ),
            ),
          )
        ],
      ),
    );
  }

  _renderContent(String title, String description, String actionText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BaseText(
          title,
          color: Color(0xff08285C),
          fontWeight: FontWeight.w600,
          fontSize: 15.sw,
        ),
        SizedBox(height: 1.sw),
        if (description.isNotEmpty) ...[
          BaseText(
            description,
            color: Color(0xff5768A5),
            fontSize: 12.5,
            maxLines: 3,
            textOverflow: TextOverflow.ellipsis,
          )
        ],
        Container(
            width: 160,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            margin: EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffdcdcdc)),
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                BaseText(
                  actionText,
                  color: const Color(0xffFF9900),
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(width: 10),
                Assets.images.icArrowRight.image(
                  width: 16,
                  height: 16,
                  fit: BoxFit.fill,
                  color: Color(0xffFF9900),
                )
              ],
            ))
      ],
    );
  }

  _renderCertOvertime() {
    return _renderNotificationView(
        AppLocalizations.current.activeCer,
        AppLocalizations.current.certOvertimeDesc,
        AppLocalizations.current.activeNow, () async {
      if (_listCertOvertime.length == 1) {
        final controller = Get.find<CertificateController>();
        controller.requestChangeDevice(
            id: _listCertOvertime.first.id,
            serial: _listCertOvertime.first.serial ?? "");
        // Get.to(() => CertificateDetail(
        //       title: AppLocalizations.current.certDetail,
        //       certificateModel: _listCertOvertime.first,
        //     ));
      } else {
        Get.to(() => SelectCertScreen(
            isSystemLink: false,
            onCertSelected: (idCert, serial) {
              final controller = Get.find<CertificateController>();
              controller.requestChangeDevice(id: idCert, serial: serial ?? "");
            },
            isFromOverTime: true));
      }
    }, () {
      setState(() {
        controller.isShowCertOvertime.value = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      _isShowCert = controller.isShowCertNotification.value;
      _isShowOrder = controller.isShowOrderNotification.value;
      _isShowCertNeedExtend = controller.isShowCertNeedExtendNotification.value;

      if (controller.listCertificate.value == null) {
        _listCert = [];
        _listCertNeedExtend = [];
      } else {
        _listCert = controller.listCertificate.value!
            .where((element) => element.countCertNotificationInHome())
            .toList();
        _listCertNeedExtend = controller.listCertificate.value!
            .where((element) => element.countCertNeedNotificationExtendInHome())
            .toList();

        _listCertOvertime = controller.listCertificate.value!
            .where((element) =>
                (element.overTime ?? 0) > 0 && element.identity?.source != 8)
            .toList();
      }

      if (controller.orderCertList.value != null) {
        _listOrder = controller.orderCertList.value!.items;
        _orderCount = controller.orderCertList.value!.totalItemCount;
      }
      return _renderViewV2();
    });
  }
}
