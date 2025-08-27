// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'submission_history_model.g.dart';

@JsonSerializable()
class SubmissionHistoryModel {
  int? approvalSubmissionId;
  String? appraisalFileId;
  int? level;
  int? totalLevel;
  int? status;
  List<ApprovalHistoryModel>? approvalHistoryDtos;
  SubmissionHistoryModel({
    this.approvalSubmissionId,
    this.appraisalFileId,
    this.level,
    this.totalLevel,
    this.status,
    this.approvalHistoryDtos,
  });

  factory SubmissionHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubmissionHistoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubmissionHistoryModelToJson(this);
}

@JsonSerializable()
class ApprovalHistoryModel {
  int? approvalHistoryId;
  int? approvalSubmissionId;
  String? approvalEmployeeId;
  String? approvalNextEmployeeId;
  int? status;
  String? approvalComment;
  int? level;
  int? totalLevel;
  int? assignmentId;
  DateTime? createdDate;
  int? constructionFutureValue;
  dynamic approvalHistoryValueDtos;
  dynamic approvalHistoryConstructionDtos;
  dynamic approvalHistoryConstructionFutureInfoDtos;
  ApprovalHistoryModel({
    this.approvalHistoryId,
    this.approvalSubmissionId,
    this.approvalEmployeeId,
    this.approvalNextEmployeeId,
    this.status,
    this.approvalComment,
    this.level,
    this.totalLevel,
    this.assignmentId,
    this.createdDate,
    this.constructionFutureValue,
    this.approvalHistoryValueDtos,
    this.approvalHistoryConstructionDtos,
    this.approvalHistoryConstructionFutureInfoDtos,
  });

  factory ApprovalHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$ApprovalHistoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$ApprovalHistoryModelToJson(this);
}
