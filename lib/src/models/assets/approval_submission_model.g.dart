// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_submission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalSubmissionInfo _$ApprovalSubmissionInfoFromJson(
        Map<String, dynamic> json) =>
    ApprovalSubmissionInfo(
      approvalSubmissionId:
          (json['approvalSubmissionId'] as num?)?.toInt() ?? 0,
      appraisalFileId: json['appraisalFileId'] as String? ?? '',
      level: (json['level'] as num?)?.toInt() ?? 0,
      totalLevel: (json['totalLevel'] as num?)?.toInt() ?? 0,
      status: (json['status'] as num?)?.toInt() ?? 0,
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
      approvalHistoryId: (json['approvalHistoryId'] as num?)?.toInt(),
      approvalSubmissionId: (json['approvalSubmissionId'] as num?)?.toInt(),
      approvalEmployeeId: json['approvalEmployeeId'] as String?,
      approvalNextEmployeeId: json['approvalNextEmployeeId'] as String?,
      status: (json['status'] as num?)?.toInt(),
      approvalComment: json['approvalComment'] as String?,
      level: (json['level'] as num?)?.toInt(),
      totalLevel: (json['totalLevel'] as num?)?.toInt(),
      assignmentId: (json['assignmentId'] as num?)?.toInt(),
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
      approvalSubmissionId: (json['approvalSubmissionId'] as num?)?.toInt(),
      approvalEmployeeId: json['approvalEmployeeId'] as String?,
      approvalNextEmployeeId: json['approvalNextEmployeeId'] as String?,
      approvalComment: json['approvalComment'] as String?,
      constructionFutureValue:
          (json['constructionFutureValue'] as num?)?.toInt(),
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
      approvalHistoryValueId: (json['approvalHistoryValueId'] as num?)?.toInt(),
      approvalHistoryId: (json['approvalHistoryId'] as num?)?.toInt(),
      assetChildId: (json['assetChildId'] as num?)?.toInt(),
      assetGrandChildId: (json['assetGrandChildId'] as num?)?.toInt(),
      valuationResultLandEstateId:
          (json['valuationResultLandEstateId'] as num?)?.toInt(),
      name: json['name'] as String?,
      type: (json['type'] as num?)?.toInt(),
      totalArea: (json['totalArea'] as num?)?.toDouble(),
      totalAreaApprovaled: (json['totalAreaApprovaled'] as num?)?.toDouble(),
      unitPrice: (json['unitPrice'] as num?)?.toInt(),
      totalValue: (json['totalValue'] as num?)?.toInt(),
      unitPriceApprovaled: (json['unitPriceApprovaled'] as num?)?.toInt(),
      totalValueApprovaled: (json['totalValueApprovaled'] as num?)?.toInt(),
      realCommonMachine: (json['realCommonMachine'] as num?)?.toInt(),
      productLineName: json['productLineName'] as String?,
      appraisalFileId: json['appraisalFileId'] as String?,
      valuationResultWaterwayVehicleId:
          (json['valuationResultWaterwayVehicleId'] as num?)?.toInt(),
      valuationResultRoadVehicleId:
          (json['valuationResultRoadVehicleId'] as num?)?.toInt(),
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
          (json['approvalHistoryConstructionId'] as num?)?.toInt(),
      approvalHistoryId: (json['approvalHistoryId'] as num?)?.toInt(),
      constructionId: (json['constructionId'] as num?)?.toInt(),
      assetLandInforId: (json['assetLandInforId'] as num?)?.toInt(),
      constructionTypeName: json['constructionTypeName'] as String?,
      constructionName: json['constructionName'] as String?,
      constructionArea: (json['constructionArea'] as num?)?.toDouble(),
      remainingQuality: (json['remainingQuality'] as num?)?.toDouble(),
      mdht: (json['mdht'] as num?)?.toDouble(),
      unitPrice: (json['unitPrice'] as num?)?.toInt(),
      totalValue: (json['totalValue'] as num?)?.toInt(),
      unitPriceApprovaled: (json['unitPriceApprovaled'] as num?)?.toInt(),
      totalValueApprovaled: (json['totalValueApprovaled'] as num?)?.toInt(),
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
