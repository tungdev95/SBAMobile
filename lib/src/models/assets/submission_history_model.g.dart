// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmissionHistoryModel _$SubmissionHistoryModelFromJson(
        Map<String, dynamic> json) =>
    SubmissionHistoryModel(
      approvalSubmissionId: json['approvalSubmissionId'] as int?,
      appraisalFileId: json['appraisalFileId'] as String?,
      level: json['level'] as int?,
      totalLevel: json['totalLevel'] as int?,
      status: json['status'] as int?,
      approvalHistoryDtos: (json['approvalHistoryDtos'] as List<dynamic>?)
          ?.map((e) => ApprovalHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubmissionHistoryModelToJson(
        SubmissionHistoryModel instance) =>
    <String, dynamic>{
      'approvalSubmissionId': instance.approvalSubmissionId,
      'appraisalFileId': instance.appraisalFileId,
      'level': instance.level,
      'totalLevel': instance.totalLevel,
      'status': instance.status,
      'approvalHistoryDtos': instance.approvalHistoryDtos,
    };

ApprovalHistoryModel _$ApprovalHistoryModelFromJson(
        Map<String, dynamic> json) =>
    ApprovalHistoryModel(
      approvalHistoryId: json['approvalHistoryId'] as int?,
      approvalSubmissionId: json['approvalSubmissionId'] as int?,
      approvalEmployeeId: json['approvalEmployeeId'] as String?,
      approvalNextEmployeeId: json['approvalNextEmployeeId'] as String?,
      status: json['status'] as int?,
      approvalComment: json['approvalComment'] as String?,
      level: json['level'] as int?,
      totalLevel: json['totalLevel'] as int?,
      assignmentId: json['assignmentId'] as int?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      constructionFutureValue: json['constructionFutureValue'] as int?,
      approvalHistoryValueDtos: json['approvalHistoryValueDtos'],
      approvalHistoryConstructionDtos: json['approvalHistoryConstructionDtos'],
      approvalHistoryConstructionFutureInfoDtos:
          json['approvalHistoryConstructionFutureInfoDtos'],
    );

Map<String, dynamic> _$ApprovalHistoryModelToJson(
        ApprovalHistoryModel instance) =>
    <String, dynamic>{
      'approvalHistoryId': instance.approvalHistoryId,
      'approvalSubmissionId': instance.approvalSubmissionId,
      'approvalEmployeeId': instance.approvalEmployeeId,
      'approvalNextEmployeeId': instance.approvalNextEmployeeId,
      'status': instance.status,
      'approvalComment': instance.approvalComment,
      'level': instance.level,
      'totalLevel': instance.totalLevel,
      'assignmentId': instance.assignmentId,
      'createdDate': instance.createdDate?.toIso8601String(),
      'constructionFutureValue': instance.constructionFutureValue,
      'approvalHistoryValueDtos': instance.approvalHistoryValueDtos,
      'approvalHistoryConstructionDtos':
          instance.approvalHistoryConstructionDtos,
      'approvalHistoryConstructionFutureInfoDtos':
          instance.approvalHistoryConstructionFutureInfoDtos,
    };
