// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:sba/src/models/base/base.dart';

part 'approval_submission_model.g.dart';

@JsonSerializable()
class ApprovalSubmissionInfo {
  int approvalSubmissionId;
  String appraisalFileId;
  int level;
  int totalLevel;
  int status;
  @JsonKey(defaultValue: [])
  List<ApprovalHistory> approvalHistoryDtos;

  ApprovalSubmissionInfo({
    this.approvalSubmissionId = 0,
    this.appraisalFileId = '',
    this.level = 0,
    this.totalLevel = 0,
    this.status = 0,
    required this.approvalHistoryDtos,
  });

  bool get laCapDuyetCuoi {
    return level + 1 == totalLevel;
  }

  int get total {
    int result = 0;

    for (ApprovalHistoryValue approvalHistoryValue
        in (approvalHistoryDtos.lastOrNull?.approvalHistoryValueDtos ?? [])) {
      result += approvalHistoryValue.totalValue ?? 0;
    }
    return result;
  }

  factory ApprovalSubmissionInfo.fromJson(Map<String, dynamic> json) =>
      _$ApprovalSubmissionInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ApprovalSubmissionInfoToJson(this);
}

@JsonSerializable()
class ApprovalHistory {
  int? approvalHistoryId;
  int? approvalSubmissionId;
  String? approvalEmployeeId;
  String? tenNguoiPheDuyet;
  String? approvalNextEmployeeId;
  String? tenNguoiPheDuyetTiepTheo;
  int? status;
  String? approvalComment;
  int? level;
  int? totalLevel;
  int? assignmentId;
  DateTime? createdDate;
  @JsonKey(defaultValue: [])
  List<ApprovalHistoryValue> approvalHistoryValueDtos;
  @JsonKey(defaultValue: [])
  List<ApprovalHistoryConstruction> approvalHistoryConstructionDtos;
  double? constructionFutureValue;
  @JsonKey(includeToJson: false, includeFromJson: false)
  AssetsTypeEnum? assetType;
  ApprovalHistory({
    this.createdDate,
    this.approvalHistoryId,
    this.approvalSubmissionId,
    this.approvalEmployeeId,
    this.approvalNextEmployeeId,
    this.status,
    this.approvalComment,
    this.level,
    this.totalLevel,
    this.assignmentId,
    required this.approvalHistoryValueDtos,
    required this.approvalHistoryConstructionDtos,
    this.constructionFutureValue,
    this.assetType,
  });

  factory ApprovalHistory.fromJson(Map<String, dynamic> json) =>
      _$ApprovalHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$ApprovalHistoryToJson(this);

  String get trangThaiPheDuyet {
    if (status == 0) {
      return 'Chờ phê duyệt';
    } else if (status == 1) {
      return 'Đang duyệt';
    } else if (status == 2) {
      return 'Đã từ chối, Chờ điều chỉnh';
    } else if (status == 3) {
      return 'Đã phê duyệt';
    }
    return '';
  }
}

@JsonSerializable(includeIfNull: false)
class ApproveSubmission {
  int? approvalSubmissionId;
  int? constructionFutureValue;
  String? approvalEmployeeId;
  String? approvalNextEmployeeId;
  String? approvalComment;
  @JsonKey(defaultValue: [])
  List<ApprovalHistoryValue> approvalHistoryValues;
  @JsonKey(defaultValue: [])
  List<ApprovalHistoryConstruction> approvalHistoryConstructionDtos;

  ApproveSubmission({
    this.approvalSubmissionId,
    this.approvalEmployeeId,
    this.approvalNextEmployeeId,
    this.approvalComment,
    this.constructionFutureValue,
    required this.approvalHistoryValues,
    required this.approvalHistoryConstructionDtos,
  });

  factory ApproveSubmission.fromJson(Map<String, dynamic> json) =>
      _$ApproveSubmissionFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveSubmissionToJson(this);
}

@JsonSerializable()
class ApprovalHistoryValue {
  int? approvalHistoryValueId;
  int? approvalHistoryId;
  int? assetChildId;
  int? assetGrandChildId;
  int? valuationResultLandEstateId;
  String? name;
  int? type;
  double? totalArea;
  double? totalAreaApprovaled;
  int? unitPrice;
  int? totalValue;
  int? unitPriceApprovaled;
  int? totalValueApprovaled;
  int? realCommonMachine;
  String? productLineName;
  String? appraisalFileId;
  int? valuationResultWaterwayVehicleId;
  int? valuationResultRoadVehicleId;
  ApprovalHistoryValue({
    this.approvalHistoryValueId,
    this.approvalHistoryId,
    this.assetChildId,
    this.assetGrandChildId,
    this.valuationResultLandEstateId,
    this.name,
    this.type,
    this.totalArea,
    this.totalAreaApprovaled,
    this.unitPrice,
    this.totalValue,
    this.unitPriceApprovaled,
    this.totalValueApprovaled,
    this.realCommonMachine,
    this.productLineName,
    this.appraisalFileId,
    this.valuationResultWaterwayVehicleId,
    this.valuationResultRoadVehicleId,
  });

  factory ApprovalHistoryValue.fromJson(Map<String, dynamic> json) =>
      _$ApprovalHistoryValueFromJson(json);
  Map<String, dynamic> toJson() => _$ApprovalHistoryValueToJson(this);

  String get typeString => switch (type) {
        1 => 'PHQH',
        2 => 'KPHQH',
        _ => '',
      };
}

@JsonSerializable()
class ApprovalHistoryConstruction {
  int? approvalHistoryConstructionId;
  int? approvalHistoryId;
  int? constructionId;
  int? assetLandInforId;
  String? constructionTypeName;
  String? constructionName;
  double? constructionArea;
  double? remainingQuality;
  double? mdht;
  int? unitPrice;
  int? unitPriceApprovaled;
  int? totalValue;
  int? totalValueApprovaled;
  ApprovalHistoryConstruction({
    this.approvalHistoryConstructionId,
    this.approvalHistoryId,
    this.constructionId,
    this.assetLandInforId,
    this.constructionTypeName,
    this.constructionName,
    this.constructionArea,
    this.remainingQuality,
    this.mdht,
    this.unitPrice,
    this.totalValue,
    this.unitPriceApprovaled,
    this.totalValueApprovaled,
  });

  factory ApprovalHistoryConstruction.fromJson(Map<String, dynamic> json) =>
      _$ApprovalHistoryConstructionFromJson(json);
  Map<String, dynamic> toJson() => _$ApprovalHistoryConstructionToJson(this);
}
