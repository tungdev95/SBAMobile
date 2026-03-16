// To parse this JSON data, do
//
//     final checkClientPermissionResponse = checkClientPermissionResponseFromJson(jsonString);

import 'dart:convert';

CheckClientPermissionResponse checkClientPermissionResponseFromJson(String str) => CheckClientPermissionResponse.fromJson(json.decode(str));

String checkClientPermissionResponseToJson(CheckClientPermissionResponse data) => json.encode(data.toJson());

class CheckClientPermissionResponse {
  int? code;
  String? codeDesc;
  String? message;
  CheckClientPermissionModel? content;

  CheckClientPermissionResponse({
    this.code,
    this.codeDesc,
    this.message,
    this.content,
  });

  factory CheckClientPermissionResponse.fromJson(Map<String, dynamic> json) => CheckClientPermissionResponse(
        code: json["code"],
        codeDesc: json["codeDesc"],
        message: json["message"],
        content: json["content"] == null ? null : CheckClientPermissionModel.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "codeDesc": codeDesc,
        "message": message,
        "content": content == null ? null : content!.toJson(),
      };
}

class CheckClientPermissionModel {

  String? clientId;
  String? clientName;
  bool? requireEkyc;
  bool? requireOTP;
  bool? requirePayment;
  bool? requireContract;
  bool? requireAssignKey;
  bool? requireApprove;
  bool? requireSyncEkyc;
  bool? requireOneBssSubmit;
  bool? isLimitPricing;

  CheckClientPermissionModel({
    this.clientId,
    this.clientName,
    this.requireEkyc,
    this.requireOTP,
    this.requirePayment,
    this.requireContract,
    this.requireAssignKey,
    this.requireApprove,
    this.requireSyncEkyc,
    this.requireOneBssSubmit,
    this.isLimitPricing,
  });

  factory CheckClientPermissionModel.fromJson(Map<String, dynamic> json) => CheckClientPermissionModel(
        clientId: json["clientId"],
        clientName: json["clientName"],
        requireEkyc: json["requireEkyc"],
        requireOTP: json["requireOTP"],
        requirePayment: json["requirePayment"],
        requireContract: json["requireContract"],
        requireAssignKey: json["requireAssignKey"],
        requireApprove: json["requireApprove"],
        requireSyncEkyc: json["requireSyncEkyc"],
        requireOneBssSubmit: json["requireOneBSSSubmit"],
        isLimitPricing: json["isLimitPricing"],
      );

  Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "clientName": clientName,
        "requireEkyc": requireEkyc,
        "requireOTP": requireOTP,
        "requirePayment": requirePayment,
        "requireContract": requireContract,
        "requireAssignKey": requireAssignKey,
        "requireApprove": requireApprove,
        "requireSyncEkyc": requireSyncEkyc,
        "requireOneBSSSubmit": requireOneBssSubmit,
        "isLimitPricing": isLimitPricing,
      };
}
