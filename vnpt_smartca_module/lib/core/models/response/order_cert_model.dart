import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../views/controller/order_item_controller.dart';
import '../../../views/i18n/generated_locales/l10n.dart';
import '../../../views/widgets/app_refresh.dart';

class OrderCertListModel {
  int count;
  int pageNumber;
  int pageCount;
  int totalItemCount;
  List<OrderCertModel> items;

  OrderCertListModel({
    required this.count,
    required this.pageNumber,
    required this.pageCount,
    required this.totalItemCount,
    required this.items,
  });

  factory OrderCertListModel.fromMap(Map<String, dynamic> map) {
    return OrderCertListModel(
      count: map['count']?.toInt() ?? 0,
      pageNumber: map['pageNumber']?.toInt() ?? 0,
      pageCount: map['pageCount']?.toInt() ?? 0,
      totalItemCount: map['totalItemCount']?.toInt() ?? 0,
      items: List<OrderCertModel>.from(
          map['items']?.map((x) => OrderCertModel.fromJson(x))),
    );
  }

  factory OrderCertListModel.fromJson(String source) =>
      OrderCertListModel.fromMap(json.decode(source));
}

enum OrderType { unknown, newCert, renewCert, changeDevice, changeInfo }

class OrderCertModel extends AppRefreshModel {
  OrderCertModel(
      {required this.statusDesc,
      required this.status,
      required this.requireEkyc,
      required this.requireOTP,
      required this.requirePayment,
      required this.requireContract,
      required this.createdDate,
      required this.typeDesc,
      required this.type,
      this.previousSerial,
      required this.identityId,
      required this.uid,
      this.credentialId,
      this.requestCertId,
      required this.pricing,
      required this.dhsxkdCustomerInfo,
      required this.localityCode,
      this.ekycTranId,
      required this.logs,
      required this.id,
      required this.timestamp,
      this.statusIsDone = false,
      this.fullName,
      this.isCreatedBy3rd = false,
      this.address,
      this.version,
      this.serialNumber})
      : super(id);

  late final String? statusDesc;
  late final int status;
  late final bool requireEkyc;
  late final bool requireOTP;
  late final bool requirePayment;
  late final bool requireContract;
  late final String createdDate;
  late final String typeDesc;
  late final int type;
  late final dynamic previousSerial;
  late final String? identityId;
  late final String uid;
  late final String? credentialId;
  late final dynamic requestCertId;
  late final Pricing pricing;
  late final DhsxkdCustomerInfo dhsxkdCustomerInfo;
  late final String localityCode;
  late final dynamic ekycTranId;
  late final List<dynamic> logs;
  late final String id;
  late final String timestamp;
  late final bool statusIsDone;
  late final String? fullName;
  late final bool isCreatedBy3rd;
  late final OrderAddress? address;
  late final int? version;
  late final String? serialNumber;

  int? code;

  OrderItemController? orderItemController;

  factory OrderCertModel.fromJson(Map<String, dynamic> json) {
    OrderCertModel orderCertModel = OrderCertModel(
      statusDesc: json['statusDesc'],
      status: json['status'],
      requireEkyc: json['requireEkyc'],
      requireOTP: json['requireOTP'],
      requirePayment: json['requirePayment'],
      requireContract: json['requireContract'],
      createdDate: json['createdDate'],
      typeDesc: json['typeDesc'],
      type: json['type'],
      previousSerial: json['previousSerial'],
      identityId: json['identityId'],
      uid: json['uid'],
      credentialId: json['credentialId'],
      requestCertId: null,
      pricing: json['pricing'] == null
          ? Pricing.emptyPricing()
          : Pricing.fromJson(json['pricing']),
      dhsxkdCustomerInfo:
          DhsxkdCustomerInfo.fromJson(json['dhsxkdCustomerInfo']),
      localityCode: json['localityCode'],
      ekycTranId: null,
      logs: List.castFrom<dynamic, dynamic>(json['logs']),
      id: json['id'],
      timestamp: json['timestamp'],
      statusIsDone: json['status'] == DONE,
      fullName: json["fullName"],
      isCreatedBy3rd: json["isCreatedBy3rd"],
      address: json['address'] == null
          ? null
          : OrderAddress.fromJson(json['address']),
      version: json['version'],
      serialNumber: json['serialNumber'],
    );
    orderCertModel.orderItemController =
        Get.put(OrderItemController(orderCertModel), tag: orderCertModel.id);
    orderCertModel.orderItemController?.currentOrderCertModel.value =
        orderCertModel;
    return orderCertModel;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusDesc'] = statusDesc;
    _data['status'] = status;
    _data['requireEkyc'] = requireEkyc;
    _data['requireOTP'] = requireOTP;
    _data['requirePayment'] = requirePayment;
    _data['requireContract'] = requireContract;
    _data['createdDate'] = createdDate;
    _data['typeDesc'] = typeDesc;
    _data['type'] = type;
    _data['previousSerial'] = previousSerial;
    _data['identityId'] = identityId;
    _data['uid'] = uid;
    _data['credentialId'] = credentialId;
    _data['requestCertId'] = requestCertId;
    _data['pricing'] = pricing?.toJson();
    _data['dhsxkdCustomerInfo'] = dhsxkdCustomerInfo.toJson();
    _data['localityCode'] = localityCode;
    _data['ekycTranId'] = ekycTranId;
    _data['logs'] = logs;
    _data['id'] = id;
    _data['timestamp'] = timestamp;
    _data["fullName"] = fullName;
    _data["isCreatedBy3rd"] = isCreatedBy3rd;
    _data["address"] = address?.toJson();
    _data["version"] = version;
    _data["serialNumber"] = serialNumber;
    return _data;
  }

  getTypeLabel() {
    switch (type) {
      case 0:
        return AppLocalizations.current.newCertOrder;
      case 1:
        return AppLocalizations.current.renewCertOrder;
      case 2:
        return AppLocalizations.current.changeDeviceOrder;
      case 3:
        return AppLocalizations.current.change_info;
      default:
        return "";
    }
  }

  getTypeEnum() {
    switch (type) {
      case 0:
        return OrderType.newCert;
      case 1:
        return OrderType.renewCert;
      case 2:
        return OrderType.changeDevice;
      case 3:
        return OrderType.changeInfo;
      default:
        return OrderType.unknown;
    }
  }

  canContinue() {
    return [
      EKYC_WAITING,
      OTP_WAITING,
      PAYMENT_WATING,
      PAYMENT_ERROR,
      CONTRACT_SIGN_WAITING,
      KEY_ASSIGN_WATING,
    ].contains(status);
  }

  canCancel() {
    return [
          CANCELED,
          CANCELING,
          CANCEL_ERROR,
          DONE,
          REQUESTCERT_WATING,
          ONEBSS_SUBMIT_WAITING,
          APPROVE_REQUEST_CERT_WAITING,
          KEY_ASSIGN_WATING,
        ].contains(status) ==
        false;
  }

  bool isWaitingEKYC() {
    return EKYC_WAITING == status;
  }

  bool isWaitingPayment() {
    return PAYMENT_WATING == status;
  }

  bool isWaitingContract() {
    return [CONTRACT_CREATE_WAITING, OrderCertModel.CONTRACT_SIGN_WAITING]
        .contains(status);
  }

  bool isOrderError() {
    return [
      EKYC_ERROR,
      OTP_ERROR,
      PAYMENT_ERROR,
      CONTRACT_CREATE_ERROR,
      CONTRACT_SIGN_ERROR,
      REQUESTCERT_ERROR,
      ONEBSS_SUBMIT_ERROR,
      APPROVE_REQUEST_CERT_ERROR,
      REJECT_REQUEST_CERT,
      KEY_ASSIGN_ERROR,
      EKYC_PROFILE_SYNC_ERROR,
    ].contains(status);
  }

  showWaitingApproveScreen() {
    // REQUESTCERT_ERROR = 55,
    // ONEBSS_SUBMIT_ERROR = 56,
    // APPROVE_REQUEST_CERT_ERROR = 57
    // APPROVE_REQUEST_CERT_WAITING = 7
    return [
      REQUESTCERT_ERROR,
      ONEBSS_SUBMIT_ERROR,
      APPROVE_REQUEST_CERT_ERROR,
      APPROVE_REQUEST_CERT_WAITING,
      DONE
    ].contains(status);
  }

  static const EKYC_WAITING = 0;
  static const OTP_WAITING = 1;
  static const PAYMENT_WATING = 2;
  static const CONTRACT_CREATE_WAITING = 3;
  static const CONTRACT_SIGN_WAITING = 4;
  static const REQUESTCERT_WATING = 5;
  static const ONEBSS_SUBMIT_WAITING = 6;
  static const APPROVE_REQUEST_CERT_WAITING = 7;
  static const KEY_ASSIGN_WATING = 8;
  // error
  static const EKYC_ERROR = 50;
  static const OTP_ERROR = 51;
  static const PAYMENT_ERROR = 52;
  static const CONTRACT_CREATE_ERROR = 53;
  static const CONTRACT_SIGN_ERROR = 54;
  static const REQUESTCERT_ERROR = 55;
  static const ONEBSS_SUBMIT_ERROR = 56;
  static const APPROVE_REQUEST_CERT_ERROR = 57;
  static const REJECT_REQUEST_CERT = 58;
  static const KEY_ASSIGN_ERROR = 59;

  static const CANCELED = 99;
  static const CANCELING = 97;
  static const CANCEL_ERROR = 98;
  // done
  static const DONE = 100;
  static const EKYC_PROFILE_SYNC_ERROR = 60;

  getStateText() {
    switch (status) {
      case 0:
        return AppLocalizations.current.orderEKYC_WAITING;
      case 1:
        return AppLocalizations.current.orderOTP_WAITING;
      case 2:
        return AppLocalizations.current.orderPAYMENT_WAITING;
      case 3:
        return AppLocalizations.current.orderCONTRACT_CREATE_WAITING;
      case 4:
        return AppLocalizations.current.orderCONTRACT_SIGN_WAITING;
      case 5:
        return AppLocalizations.current.orderREQUESTCERT_WATING;
      case 6:
        return AppLocalizations.current.orderONEBSS_SUBMIT_WAITING;
      case 7:
        return AppLocalizations.current.orderAPPROVE_REQUEST_CERT_WAITING;
      case 8:
        return AppLocalizations.current.orderKEY_ASSIGN_WATING;
      case 50:
        return AppLocalizations.current.orderEKYC_ERROR;
      case 51:
        return AppLocalizations.current.orderOTP_ERROR;
      case 52:
        return AppLocalizations.current.orderPAYMENT_ERROR;
      case 53:
        return AppLocalizations.current.orderCONTRACT_CREATE_ERROR;
      case 54:
        return AppLocalizations.current.orderCONTRACT_SIGN_ERROR;
      case 55:
        return AppLocalizations.current.orderAPPROVE_REQUEST_CERT_ERROR;
      case 56:
        return AppLocalizations.current.orderONEBSS_SUBMIT_ERROR;
      case 57:
        return AppLocalizations.current.orderAPPROVE_REQUEST_CERT_ERROR;
      case 58:
        return AppLocalizations.current.orderREJECT_REQUEST_CERT;
      case 59:
        return AppLocalizations.current.orderKEY_ASSIGN_ERROR;
      case 99:
        return AppLocalizations.current.orderCANCELED;
      case 97:
        return AppLocalizations.current.orderCanceling;
      case 98:
        return AppLocalizations.current.orderCANCEL_ERROR;
      case 100:
        return AppLocalizations.current.orderDONE;
      default:
        return "";
    }
  }
}

class Pricing {
  Pricing({
    required this.pricingCode,
    required this.pricingName,
    required this.timeValidity,
    required this.price,
    required this.certificateProfileName,
    required this.signType,
    required this.signTypeDesc,
    required this.initSignTurn,
  });

  late final String pricingCode;
  late final String pricingName;
  late final int timeValidity;
  late final int price;
  late final String certificateProfileName;
  late final int signType;
  late final String signTypeDesc;
  late final int initSignTurn;

  static emptyPricing() {
    return Pricing(
        pricingCode: "",
        pricingName: "",
        timeValidity: 0,
        price: 0,
        certificateProfileName: "",
        signType: 0,
        initSignTurn: 0,
        signTypeDesc: "");
    // return Pricing(pricingCode: "", pricingName: "", 0, 0, "", 0, "");
  }

  Pricing.fromJson(Map<String, dynamic> json) {
    pricingCode = json['pricingCode'];
    pricingName = json['pricingName'];
    timeValidity = json['timeValidity'];
    price = json['price'];
    certificateProfileName = json['certificateProfileName'];
    signType = json['signType'];
    signTypeDesc = json['signTypeDesc'];
    initSignTurn = json['initSignTurn'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pricingCode'] = pricingCode;
    _data['pricingName'] = pricingName;
    _data['timeValidity'] = timeValidity;
    _data['price'] = price;
    _data['certificateProfileName'] = certificateProfileName;
    _data['signType'] = signType;
    _data['signTypeDesc'] = signTypeDesc;
    _data['initSignTurn'] = initSignTurn ?? 0;
    return _data;
  }

  String get timeValidityStr {
    if (timeValidity! <= 0) return 'N/A';
    return '$timeValidity ${AppLocalizations.current.month_text}';
  }

  String get priceStr {
    if (price! <= 0) return AppLocalizations.current.order_free;
    return NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
        .format(price);
  }

  String get amountStr {
    if (price == 0) return '0 đ';
    return NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
        .format(price);
  }

  String get amountStrVND {
    if (price == 0) return AppLocalizations.current.vnd(0);
    return NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
        .format(price)
        .replaceAll("₫", "VNĐ");
  }
}

class DhsxkdCustomerInfo {
  DhsxkdCustomerInfo({
    required this.maGd,
    required this.maKh,
    required this.maHd,
    required this.maHrm,
    required this.maTb,
  });
  late final String maGd;
  late final String maKh;
  late final String maHd;
  late final String maHrm;
  late final String maTb;

  DhsxkdCustomerInfo.fromJson(Map<String, dynamic> json) {
    maGd = json['ma_gd'] ?? "";
    maKh = json['ma_kh'] ?? "";
    maHd = json['ma_hd'] ?? "";
    maHrm = json['ma_hrm'] ?? "";
    maTb = json['ma_tb'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ma_gd'] = maGd;
    _data['ma_kh'] = maKh;
    _data['ma_hd'] = maHd;
    _data['ma_hrm'] = maHrm;
    _data['ma_tb'] = maTb;
    return _data;
  }
}

class OrderAddress {
  OrderAddress(
      {this.provinceId,
      this.provinceName,
      this.districtId,
      this.districtName,
      this.wardId,
      this.wardName,
      this.streetName,
      this.address});
  String? provinceId;
  String? provinceName;
  String? districtId;
  String? districtName;
  String? wardId;
  String? wardName;
  String? streetName;
  String? address;

  OrderAddress.fromJson(Map<String, dynamic> json) {
    provinceId = json['provinceId'] ?? "";
    provinceName = json['provinceName'] ?? "";
    districtId = json['districtId'] ?? "";
    districtName = json['districtName'] ?? "";
    wardId = json['wardId'] ?? "";
    wardName = json['wardName'] ?? "";
    streetName = json['streetName'] ?? "";
    address = json['address'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['provinceId'] = provinceId;
    data['provinceName'] = provinceName;
    data['districtId'] = districtId;
    data['districtName'] = districtName;
    data['wardId'] = wardId;
    data['wardName'] = wardName;
    data['streetName'] = streetName;
    data['address'] = address;
    return data;
  }
}
