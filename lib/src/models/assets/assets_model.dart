// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/assets/survey_schedule_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/models/base/serializer.dart';

import 'assets.dart';

part 'assets_model.g.dart';

@JsonSerializable()
class AssetsModel {
  String? appraisalFileId;
  String? proposalCode;
  String? reportCode;
  CustomerModel? customer;
  String? customerId;
  String? address;
  int? assetLevelOneId;
  @JsonKey(name: 'assetLevelTwoId', unknownEnumValue: AssetsTypeEnum.bds)
  AssetsTypeEnum assetType;
  int? assetLevelThreeId;
  String? brandCode;
  BranchModel? branch;
  String? surveyGuide;
  String? surveyGuidePhone;
  @JsonKey(unknownEnumValue: FileStatus.unKnown)
  FileStatus? fileStatus;
  DateTime? proposalDate;
  List<AssetCommons>? assetCommons;
  List<Attachment>? assetImages;
  List<int>? exportType;
  String? transOfficeCode;
  TransOffice? transOffice;
  String? rmName;
  String? rmPhone;
  String? resultEmail;
  String? invoiceEmail;
  DateTime? surveyTime;
  DateTime? appraisalDate;
  DateTime? approvedDate;
  String? assetName;
  int? appraisalPurposeId;
  String? assetLevelThrees;
  String? addressDetail;
  String? addressStreet;
  String? addressWard;
  String? addressDistrict;
  String? addressProvince;
  double? latitude;
  double? longitude;
  int? flowId;
  @JsonKey(defaultValue: [], toJson: lsSurveyScheduleToJson)
  List<SurveyScheduleModel> surveySchedules;
  int? typeCreated;
  dynamic customerNameByLos;
  String? description;
  int? appraisalUnit;
  String? addressCustomDetail;
  int? rePricingNumber;

  /// Map of custom channel extraData
  Map<String, Object?> extraData;

  int get pricingNumber => rePricingNumber ?? 0;

  AssetsModel({
    this.appraisalFileId,
    this.proposalCode,
    this.reportCode,
    this.customer,
    this.customerId,
    this.address,
    this.assetLevelOneId,
    required this.assetType,
    this.assetLevelThreeId,
    this.brandCode,
    this.branch,
    this.surveyGuide,
    this.surveyGuidePhone,
    this.fileStatus,
    this.proposalDate,
    this.assetCommons,
    this.assetImages,
    this.exportType,
    this.transOfficeCode,
    this.transOffice,
    this.rmName,
    this.rmPhone,
    this.resultEmail,
    this.invoiceEmail,
    this.surveyTime,
    this.appraisalDate,
    this.approvedDate,
    this.assetName,
    this.appraisalPurposeId,
    this.assetLevelThrees,
    this.addressDetail,
    this.addressStreet,
    this.addressWard,
    this.addressDistrict,
    this.addressProvince,
    this.latitude,
    this.longitude,
    this.flowId,
    required this.surveySchedules,
    this.typeCreated,
    this.customerNameByLos,
    this.description,
    this.appraisalUnit,
    this.addressCustomDetail,
    this.rePricingNumber,
    this.extraData = const {},
  });

  factory AssetsModel.fromJson(Map<String, dynamic> json) =>
      _$AssetsModelFromJson(
          Serializer.moveToExtraDataFromRoot(json, topLevelFields));

  Map<String, dynamic> toJson() => Serializer.moveFromExtraDataToRoot(
        _$AssetsModelToJson(this),
      );

  String titleItem() {
    return proposalCode ?? '';
  }

  String get customerName {
    return typeCreated == 0
        ? (customer?.customerName ?? '')
        : (customerNameByLos ?? '');
  }

  List<String> get assetCodes {
    return (assetCommons ?? []).map((e) => e.assetCode ?? '').toList();
  }

  int get assetLevelTwoId => assetType.assetsLevel2Id;

  static const topLevelFields = [
    'appraisalFileId',
    'proposalCode',
    'reportCode',
    'customer',
    'customerId',
    'address',
    'assetLevelOneId',
    'assetLevelTwoId',
    'assetLevelThreeId',
    'brandCode',
    'branch',
    'surveyGuide',
    'surveyGuidePhone',
    'fileStatus',
    'proposalDate',
    'assetCommons',
    'assetImages',
    'exportType',
    'transOfficeCode',
    'rmName',
    'rmPhone',
    'resultEmail',
    'invoiceEmail',
    'surveyTime',
    'appraisalDate',
    'approvedDate',
    'assetName',
    'appraisalPurposeId',
    'assetLevelThrees',
    'addressDetail',
    'addressStreet',
    'addressWard',
    'addressDistrict',
    'addressProvince',
    'latitude',
    'longitude',
    'flowId',
    'surveySchedules',
    'typeCreated',
    'customerNameByLos',
    'description',
    'appraisalUnit',
    'transOffice',
    'addressCustomDetail',
    'rePricingNumber',
  ];
}

@JsonSerializable()
class AssetCommons {
  int? assetCommonId;
  String? appraisalFileId;
  String? assetCode;
  String? climsCode;
  int? assetLevelThreeId;

  String? addressWard;
  // Wards? wards;
  String? addressDistrict;
  // Districts? districts;
  String? addressProvince;
  // Provinces? provinces;
  String? description;

  /// Map of custom channel extraData
  Map<String, Object?>? extraData;

  AssetCommons({
    this.assetCommonId,
    this.appraisalFileId,
    this.assetCode,
    this.climsCode,
    this.assetLevelThreeId,
    this.extraData,
    this.addressWard,
    this.addressDistrict,
    this.addressProvince,
    this.description,
  });

  factory AssetCommons.fromJson(Map<String, dynamic> json) =>
      _$AssetCommonsFromJson(
          Serializer.moveToExtraDataFromRoot(json, topLevelFields));
  Map<String, dynamic> toJson() => Serializer.moveFromExtraDataToRoot(
        _$AssetCommonsToJson(this),
      );

  static const topLevelFields = [
    'assetCommonId',
    'appraisalFileId',
    'assetCode',
    'climsCode',
    'assetLevelThreeId',
    'addressWard',
    'addressDistrict',
    'addressProvince',
    'description',
  ];
}

@JsonSerializable()
class TransOffice {
  String? transOfficeCode;
  String? transOfficeName;
  String? address;
  String? email;
  String? phoneNumber;
  String? branchCode;
  String? createdDate;
  String? taxCode;
  dynamic hibernate;
  TransOffice({
    this.transOfficeCode,
    this.transOfficeName,
    this.address,
    this.email,
    this.phoneNumber,
    this.branchCode,
    this.createdDate,
    this.taxCode,
    required this.hibernate,
  });

  factory TransOffice.fromJson(Map<String, dynamic> json) =>
      _$TransOfficeFromJson(json);
  Map<String, dynamic> toJson() => _$TransOfficeToJson(this);
}

List<Map<String, dynamic>> lsSurveyScheduleToJson(
    List<SurveyScheduleModel> lsData) {
  final result = lsData
      .where((element) => element.timeStart != null)
      .map((e) => e.toJson())
      .toList();

  ///có item không đủ điều kiện nhập liệu nên bị xóa, revert checkbox
  if (result.length != lsData.length) {
    for (var element in result) {
      element['isMetCustomer'] = false;
    }
  }
  return result;
}
