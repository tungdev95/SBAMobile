// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:sba/src/utils/uuid.dart';

part 'legal_model.g.dart';

///Hồ sơ pháp lý
@JsonSerializable()
class LegalModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;

  String? assetId;

  /// Id loại hồ sơ pháp lý (thông tin pháp lý)
  int? legalInformationTypeId;

  /// Số giấy tờ
  String? legalInformationNumber;

  /// Đơn vị cấp
  String? issueUnit;

  /// Ngày cấp
  DateTime? issueDate;

  /// Chủ sở hữu
  String? owner;

  /// Chi tiết cấp
  String? details;

  /// Chủ đầu tư
  String? investor;

  @JsonKey(toJson: legalInfoToJson)
  LegalInformationType? legalDocumentType;

  int? orderBy;

  LegalModel({
    this.assetId,
    this.legalInformationTypeId,
    this.legalInformationNumber,
    this.issueUnit,
    this.issueDate,
    this.owner,
    this.details,
    this.legalDocumentType,
    this.investor,
    this.orderBy,
  }) {
    id ??= Uuid().generateV4();
  }

  factory LegalModel.fromJson(Map<String, dynamic> json) =>
      _$LegalModelFromJson(json);
  Map<String, dynamic> toJson() => _$LegalModelToJson(this);

  bool isValid() {
    return legalInformationTypeId != null ||
        legalInformationNumber != null ||
        issueUnit != null ||
        issueDate != null ||
        owner != null ||
        details != null;
  }
}

@JsonSerializable()
class LegalInformationType {
  int? legalDocumentTypeId;
  String? name;
  int? assetLevelTwoId;
  LegalInformationType({
    this.legalDocumentTypeId,
    this.name,
    this.assetLevelTwoId,
  });

  factory LegalInformationType.fromJson(Map<String, dynamic> json) =>
      _$LegalInformationTypeFromJson(json);
  Map<String, dynamic> toJson() => _$LegalInformationTypeToJson(this);
}

Map<String, dynamic>? legalInfoToJson(LegalInformationType? item) {
  if (item?.legalDocumentTypeId == null) return null;
  return item?.toJson();
}
