import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/configs/injector/injector.dart';
import 'package:vnpt_smartca_module/views/controller/app_controller.dart';
import 'package:vnpt_smartca_module/views/controller/base_controler.dart';
import 'package:vnpt_smartca_module/views/controller/register_account_controller.dart';
import '../../core/models/app/exceptions.dart';
import '../../core/models/response/policy_data_response.dart';
import '../../data/network/auth_api.dart';
import '../../data/repository/policy_data_repository.dart';
import '../utils/enums.dart';
import '../utils/exception_handler.dart';
import '../widgets/dialog/common_dialog.dart';
import 'auth_controller.dart';

class PolicyDataController extends BaseController {
  AuthRemoteApi authenService = getIt<AuthRemoteApi>();
  final policyDataRepository = getIt<PolicyDataRepository>();
  final appController = Get.find<AppController>();
  final RxList<bool> checkPolicyList = RxList.filled(5, true);
  String? token;
  // final checkPolicy = false.obs;
  final scrollController = ScrollController();
  List<ND13Content>? resultGetPolicy = [];

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  getPolicy() async {
    showLoading();
    try {
      // token = await getAppAccessToken();
      // if (token == null) {
      //   return;
      // }
      final failureOrVerified = await policyDataRepository.getPolicy(getUID());
      hideLoading();
      failureOrVerified.fold(
        (failure) => {
          showErrorModal(exceptionHandler(failure)),
        },
        (result) {
          if (result == null) {
            resultGetPolicy = null;
            return;
          }
          resultGetPolicy = result.nD13Content;
          checkPolicyList.value =
              result.nD13Content?.map((e) => e.checked!).toList() ?? [];
        },
      );
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  Future<void> updatePolicy(List<bool> valueUpdate) async {
    showLoading();
    try {
      List<ND13Content> listND13Content = [];
      for (int i = 1; i < thirdPolicy.subPolicy.length; i++) {
        ND13Content nd13Content = ND13Content(
            key: i,
            code: "MUC_$i",
            description: thirdPolicy.subPolicy[i].title,
            checked: valueUpdate[i - 1]);
        listND13Content.add(nd13Content);
      }
      // token = await getAppAccessToken();
      // if (token == null) {
      //   return;
      // }
      final failureOrVerified =
          await policyDataRepository.updatePolicy(getUID(), listND13Content);
      hideLoading();
      failureOrVerified.fold(
        (failure) => {
          showErrorModal(exceptionHandler(failure)),
        },
        (result) {
          checkPolicyList.value = valueUpdate;
          Get.until((route) => route.isFirst);
        },
      );
    } catch (e, s) {
      showErrorModal(exceptionHandler(GenericException(error: e, stack: s)));
    }
  }

  getUID() {
    final authController = Get.find<AuthController>();
    if (authController.authStatus.value == AuthenticationStatus.authenticated) {
      return authController.currentUser.value!.uid;
    } else {
      final registerAccountController = Get.find<RegisterAccountController>();
      return registerAccountController.identifierTEC.value.text;
    }
  }

  // Future<String> getAppAccessToken() async {
  //   var token = await authenService.getAppAccessToken();
  //   return token.accessToken;
  // }
}

class Policy {
  final bool required;
  final int? index;
  final String title;
  final List<Policy> subPolicy;

  const Policy({
    required this.title,
    this.index,
    this.required = true,
    this.subPolicy = const [],
  });
}

const Policy thirdPolicy =
    Policy(title: "Điều 3. Mục đích xử lý Dữ liệu cá nhân ", subPolicy: [
  Policy(
      index: 0,
      required: false,
      title:
          "Mục đích/Phạm vi sử dụng Thông tin Khách hàng (Quy định chi tiết tại Điều 3 và Điều 6 Chính sách bảo vệ thông tin khách hàng của Tổng công ty Dịch vụ Viễn thông)"),
  Policy(
      index: 1,
      required: false,
      title:
          "a, VNPT sử dụng Thông tin Khách hàng phục vụ mục đích kinh doanh các dịch vụ phân tích dữ liệu, dịch vụ xác thực, dịch vụ định danh."),
  Policy(
      index: 2,
      required: false,
      title:
          "b, VNPT sử dụng Thông tin Khách hàng phục vụ mục đích kinh doanh các dịch vụ quảng cáo, dịch vụ tiếp thị, nghiên cứu thị trường, thăm dò dư luận, môi giới."),
  Policy(
      index: 3,
      required: false,
      title:
          "c, VNPT sử dụng Thông tin Khách hàng phục vụ mục đích tổ chức chương trình quảng cáo, giới thiệu sản phẩm, hàng hóa, dịch vụ và thực hiện các hoạt động xúc tiến thương mại đối với sản phẩm, hàng hóa, dịch vụ do VNPT cung cấp cho Khách hàng."),
  Policy(
      index: 4,
      required: false,
      title:
          "d, VNPT chia sẻ Thông tin Khách hàng cho bên thứ ba không thuộc các trường hợp theo quy định của pháp luật."),
  Policy(
      index: 5,
      required: false,
      title:
          "e, VNPT chia sẻ Thông tin Khách hàng với VNPT, Công ty con của VNPT, công ty liên kết của VNPT, công ty liên kết của Công ty con của VNPT."),
]);
