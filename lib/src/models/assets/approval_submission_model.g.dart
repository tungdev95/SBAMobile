// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_submission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalSubmissionInfo _$ApprovalSubmissionInfoFromJson(
        Map<String, dynamic> json) =>
    ApprovalSubmissionInfo(
      approvalSubmissionId: json['approvalSubmissionId'] as int? ?? 0,
      appraisalFileId: json['appraisalFileId'] as String? ?? '',
      level: json['level'] as int? ?? 0,
      totalLevel: json['totalLevel'] as int? ?? 0,
      status: json['status'] as int? ?? 0,
      approvalHistoryDtos: (json['approvalHistoryDtos'] as List<dynamic>?)
              ?.map((e) => ApprovalHistory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ApprovalSubmissionInfoToJson(
        ApprovalSubmissionInfo instance) =>
    <String, dynamic>{
      'approvalSubmissionId': instance.approvalSubmissionId,
      'appraisalFileId': instance.appraisalFileId,
      'level': instance.level,
      'totalLevel': instance.totalLevel,
      'status': instance.status,
      'approvalHistoryDtos': instance.approvalHistoryDtos,
    };

ApprovalHistory _$ApprovalHistoryFromJson(Map<String, dynamic> json) =>
    ApprovalHistory(
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      approvalHistoryId: json['approvalHistoryId'] as int?,
      approvalSubmissionId: json['approvalSubmissionId'] as int?,
      approvalEmployeeId: json['approvalEmployeeId'] as String?,
      approvalNextEmployeeId: json['approvalNextEmployeeId'] as String?,
      status: json['status'] as int?,
      approvalComment: json['approvalComment'] as String?,
      level: json['level'] as int?,
      totalLevel: json['totalLevel'] as int?,
      assignmentId: json['assignmentId'] as int?,
      approvalHistoryValueDtos:
          (json['approvalHistoryValueDtos'] as List<dynamic>?)
                  ?.map((e) =>
                      ApprovalHistoryValue.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
      approvalHistoryConstructionDtos:
          (json['approvalHistoryConstructionDtos'] as List<dynamic>?)
                  ?.map((e) => ApprovalHistoryConstruction.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              [],
      constructionFutureValue:
          (json['constructionFutureValue'] as num?)?.toDouble(),
    )
      ..tenNguoiPheDuyet = json['tenNguoiPheDuyet'] as String?
      ..tenNguoiPheDuyetTiepTheo = json['tenNguoiPheDuyetTiepTheo'] as String?;

Map<String, dynamic> _$ApprovalHistoryToJson(ApprovalHistory instance) =>
    <String, dynamic>{
      'approvalHistoryId': instance.approvalHistoryId,
      'approvalSubmissionId': instance.approvalSubmissionId,
      'approvalEmployeeId': instance.approvalEmployeeId,
      'tenNguoiPheDuyet': instance.tenNguoiPheDuyet,
      'approvalNextEmployeeId': instance.approvalNextEmployeeId,
      'tenNguoiPheDuyetTiepTheo': instance.tenNguoiPheDuyetTiepTheo,
      'status': instance.status,
      'approvalComment': instance.approvalComment,
      'level': instance.level,
      'totalLevel': instance.totalLevel,
      'assignmentId': instance.assignmentId,
      'createdDate': instance.createdDate?.toIso8601String(),
      'approvalHistoryValueDtos': instance.approvalHistoryValueDtos,
      'approvalHistoryConstructionDtos':
          instance.approvalHistoryConstructionDtos,
      'constructionFutureValue': instance.constructionFutureValue,
    };

ApproveSubmission _$ApproveSubmissionFromJson(Map<String, dynamic> json) =>
    ApproveSubmission(
      approvalSubmissionId: json['approvalSubmissionId'] as int?,
      approvalEmployeeId: json['approvalEmployeeId'] as String?,
      approvalNextEmployeeId: json['approvalNextEmployeeId'] as String?,
      approvalComment: json['approvalComment'] as String?,
      constructionFutureValue: json['constructionFutureValue'] as int?,
      approvalHistoryValues: (json['approvalHistoryValues'] as List<dynamic>?)
              ?.map((e) =>
                  ApprovalHistoryValue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      approvalHistoryConstructionDtos:
          (json['approvalHistoryConstructionDtos'] as List<dynamic>?)
                  ?.map((e) => ApprovalHistoryConstruction.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              [],
    );

Map<String, dynamic> _$ApproveSubmissionToJson(ApproveSubmission instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('approvalSubmissionId', instance.approvalSubmissionId);
  writeNotNull('constructionFutureValue', instance.constructionFutureValue);
  writeNotNull('approvalEmployeeId', instance.approvalEmployeeId);
  writeNotNull('approvalNextEmployeeId', instance.approvalNextEmployeeId);
  writeNotNull('approvalComment', instance.approvalComment);
  val['approvalHistoryValues'] = instance.approvalHistoryValues;
  val['approvalHistoryConstructionDtos'] =
      instance.approvalHistoryConstructionDtos;
  return val;
}

ApprovalHistoryValue _$ApprovalHistoryValueFromJson(
        Map<String, dynamic> json) =>
    ApprovalHistoryValue(
      approvalHistoryValueId: json['approvalHistoryValueId'] as int?,
      approvalHistoryId: json['approvalHistoryId'] as int?,
      assetChildId: json['assetChildId'] as int?,
      assetGrandChildId: json['assetGrandChildId'] as int?,
      valuationResultLandEstateId: json['valuationResultLandEstateId'] as int?,
      name: json['name'] as String?,
      type: json['type'] as int?,
      totalArea: (json['totalArea'] as num?)?.toDouble(),
      totalAreaApprovaled: (json['totalAreaApprovaled'] as num?)?.toDouble(),
      unitPrice: json['unitPrice'] as int?,
      totalValue: json['totalValue'] as int?,
      unitPriceApprovaled: json['unitPriceApprovaled'] as int?,
      totalValueApprovaled: json['totalValueApprovaled'] as int?,
      realCommonMachine: json['realCommonMachine'] as int?,
      productLineName: json['productLineName'] as String?,
      appraisalFileId: json['appraisalFileId'] as String?,
      valuationResultWaterwayVehicleId:
          json['valuationResultWaterwayVehicleId'] as int?,
      valuationResultRoadVehicleId:
          json['valuationResultRoadVehicleId'] as int?,
    );

Map<String, dynamic> _$ApprovalHistoryValueToJson(
        ApprovalHistoryValue instance) =>
    <String, dynamic>{
      'approvalHistoryValueId': instance.approvalHistoryValueId,
      'approvalHistoryId': instance.approvalHistoryId,
      'assetChildId': instance.assetChildId,
      'assetGrandChildId': instance.assetGrandChildId,
      'valuationResultLandEstateId': instance.valuationResultLandEstateId,
      'name': instance.name,
      'type': instance.type,
      'totalArea': instance.totalArea,
      'totalAreaApprovaled': instance.totalAreaApprovaled,
      'unitPrice': instance.unitPrice,
      'totalValue': instance.totalValue,
      'unitPriceApprovaled': instance.unitPriceApprovaled,
      'totalValueApprovaled': instance.totalValueApprovaled,
      'realCommonMachine': instance.realCommonMachine,
      'productLineName': instance.productLineName,
      'appraisalFileId': instance.appraisalFileId,
      'valuationResultWaterwayVehicleId':
          instance.valuationResultWaterwayVehicleId,
      'valuationResultRoadVehicleId': instance.valuationResultRoadVehicleId,
    };

ApprovalHistoryConstruction _$ApprovalHistoryConstructionFromJson(
        Map<String, dynamic> json) =>
    ApprovalHistoryConstruction(
      approvalHistoryConstructionId:
          json['approvalHistoryConstructionId'] as int?,
      approvalHistoryId: json['approvalHistoryId'] as int?,
      constructionId: json['constructionId'] as int?,
      assetLandInforId: json['assetLandInforId'] as int?,
      constructionTypeName: json['constructionTypeName'] as String?,
      constructionName: json['constructionName'] as String?,
      constructionArea: (json['constructionArea'] as num?)?.toDouble(),
      remainingQuality: (json['remainingQuality'] as num?)?.toDouble(),
      mdht: (json['mdht'] as num?)?.toDouble(),
      unitPrice: json['unitPrice'] as int?,
      totalValue: json['totalValue'] as int?,
      unitPriceApprovaled: json['unitPriceApprovaled'] as int?,
      totalValueApprovaled: json['totalValueApprovaled'] as int?,
    );

Map<String, dynamic> _$ApprovalHistoryConstructionToJson(
        ApprovalHistoryConstruction instance) =>
    <String, dynamic>{
      'approvalHistoryConstructionId': instance.approvalHistoryConstructionId,
      'approvalHistoryId': instance.approvalHistoryId,
      'constructionId': instance.constructionId,
      'assetLandInforId': instance.assetLandInforId,
      'constructionTypeName': instance.constructionTypeName,
      'constructionName': instance.constructionName,
      'constructionArea': instance.constructionArea,
      'remainingQuality': instance.remainingQuality,
      'mdht': instance.mdht,
      'unitPrice': instance.unitPrice,
      'unitPriceApprovaled': instance.unitPriceApprovaled,
      'totalValue': instance.totalValue,
      'totalValueApprovaled': instance.totalValueApprovaled,
    };
