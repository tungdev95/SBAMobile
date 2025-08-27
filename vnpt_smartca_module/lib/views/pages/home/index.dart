// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_is_empty

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scale_size/scale_size.dart';
import '../../../configs/app_config.dart';
import '../../../core/models/request/history_request_model.dart';
import '../../../core/models/response/certificate_model.dart';
import '../../../core/models/response/order_cert_model.dart';
import '../../../core/models/response/transaction_model.dart';
import '../../../gen/assets.gen.dart';
import '../../controller/app_controller.dart';
import '../../controller/auth_controller.dart';
import '../../controller/extend_certificate_controller.dart';
import '../../controller/home_controller.dart';
import '../../i18n/generated_locales/l10n.dart';
import '../../pages/account_information/index.dart';
import '../../pages/certificate/common_action.dart';
import '../../pages/doc_sign_history/index.dart';
import '../../pages/transaction_request/index.dart';
import '../../utils/enums.dart';
import '../../widgets/app_refresh.dart';
import '../../widgets/dialog/modal_bottom_sheet.dart';
import '../../widgets/widget.dart';

import '../certificate/buy/order_detail_screen.dart';
import '../certificate/buy/order_list_screen.dart';
import '../certificate/extend/select_cert_to_extend_screen.dart';
import '../certificate/setup_pin_code/index.dart';
import 'widgets/biometric_auth.dart';
import 'widgets/buy_cert.dart';
import 'widgets/doc_sign_history.dart';

class HomePage extends StatelessWidget {
  final controller = Get.find<HomeController>();
  final authController = Get.find<AuthController>();

  HomePage({Key? key}) : super(key: key) {
    Timer(
      Duration(milliseconds: 400),
      () {
        if (authController.currentUser.value?.useBiometric == null) {
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
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.to(() => TransactionRequests()),
              child: BaseText(
                AppLocalizations.current.recentTransactions,
                color: Color(0xff08285C),
                fontSize: 15,
                fontWeight: FontWeight.w700,
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
          isLoadMore: false,
          itemSpace: 8,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var listCert = controller.listCertificate.value;
      var listOrder = controller.listOrder.value;

      final isShowOrderList = (listOrder != null &&
              listOrder.length != 0 &&
              listCert?.length == 0) ||
          (listCert != null &&
              listCert.length == 1 &&
              listCert.first.status == StatusCertEnum.WAITING_APPROVE.index);

      final isShowBuyCert =
          listOrder != null && listOrder.length == 0 && listCert?.length == 0;

      return Column(
        children: [
          _UserProfileWidget(),
          NotificationWidget(),
          if (isShowOrderList &&
              controller
                  .transactionRequestController.transactionRequestList.isEmpty)
            Expanded(
                child: OrderListScreen(
              hiddenBack: true,
              appBarColor: const Color.fromRGBO(241, 244, 250, 1),
              appBarBoxShadowColor: Colors.transparent,
            )),
          if (isShowBuyCert) Expanded(child: BuyCertWidget()),
          if (controller
              .transactionRequestController.transactionRequestList.isNotEmpty)
            Expanded(child: TransactionRequests()),
          if (!isShowOrderList &&
              !isShowBuyCert &&
              controller.transactionRequestController.transactionRequestList
                  .isEmpty) ...[
            // _UserNotificationWidget(),
            SizedBox(height: 15),
            ...recentHistory()
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
          Get.to(AccountInformationPage());
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
  int _orderCount = 0;
  int _currentPage = 0;

  @override
  void initState() {
    // debugPrint(">>>>controller.getCertificateListWaitingActive();");
    // controller.getCertificateListWaitingActive();
    _isShowCert = controller.isShowCertNotification.value;
    _isShowOrder = controller.isShowOrderNotification.value;
    _isShowCertNeedExtend = controller.isShowCertNeedExtendNotification.value;

    ever(controller.listCertificate, (p0) {
      if (mounted) {
        if (p0 == null) {
          _listCert = [];
          _listCertNeedExtend = [];
        } else {
          _listCert = p0
              .where((element) => element.countCertNotificationInHome())
              .toList();
          _listCertNeedExtend = p0
              .where(
                  (element) => element.countCertNeedNotificationExtendInHome())
              .toList();
        }

        setState(() {});
      }
    });

    ever(controller.orderCertList, (p0) {
      if (mounted) {
        if (p0 != null) {
          setState(() {
            _listOrder = p0.items;
            _orderCount = p0.totalItemCount;
          });
        }
      }
    });

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
      widgets.add(_renderOrderView());
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
              height: 83.sw,
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
    return _renderNotificationView(
        AppLocalizations.current.renewCertOrder,
        AppLocalizations.current.yourCertNeedExtend,
        AppLocalizations.current.extend_now, () async {
      // kiem tra tai khoan nhan vien hay doanh nghiep
      bool isCheck = await extendCertificateController
          .checkStaffOrBusinessesAccount(AppLocalizations.current.extend);
      if (isCheck) {
        return;
      }
      if (list.length == 1) {
        // chuyen sang man chon goi cuoc luon
        extendCertificateController.handleCert(list.first);
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
    return _renderNotificationView(
        AppLocalizations.current.numberWaitingOrder(
            _orderCount < 10 ? "0$_orderCount" : _orderCount),
        "",
        AppLocalizations.current.view_detail, () {
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
    return Stack(
      children: [
        InkWell(
          onTap: () {
            onTap?.call();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
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
        ),
        if (description.isNotEmpty) ...[
          BaseText(
            description,
            color: Color(0xff5768A5),
            fontSize: 12.5,
            textOverflow: TextOverflow.ellipsis,
          )
        ],
        BaseText(
          actionText,
          color: const Color(0xff5768A5),
          fontWeight: FontWeight.w600,
          fontSize: 12.5,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _renderViewV2();
  }
}
