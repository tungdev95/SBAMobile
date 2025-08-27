// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:sba/src/utils/uuid.dart';

part 'risk_factor_model.g.dart';

@JsonSerializable()
class RiskFactorModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;
  int? riskDetailId;
  String? assetId;
  int? riskAssetId;
  int? riskTypeId;
  String? description;
  RiskAssetModel? riskAsset;

  RiskFactorModel({
    this.id,
    this.riskDetailId,
    this.assetId,
    this.riskAssetId,
    this.riskTypeId,
    this.description,
    this.riskAsset,
  }) {
    id ??= Uuid().generateV4();
    riskAsset ??= RiskAssetModel();
  }

  factory RiskFactorModel.fromJson(dynamic json) =>
      _$RiskFactorModelFromJson(json);
  Map<String, dynamic> toJson() => _$RiskFactorModelToJson(this);
}

@JsonSerializable()
class RiskAssetModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;
  int? riskAssetId;
  String? riskContent;
  int? assetLevelTwoId;
  String? description;
  int? riskLevel;
  RiskAssetModel({
    this.id,
    this.riskAssetId,
    this.riskContent,
    this.assetLevelTwoId,
    this.description,
    this.riskLevel,
  }) {
    id ??= Uuid().generateV4();
  }

  factory RiskAssetModel.fromJson(dynamic json) =>
      _$RiskAssetModelFromJson(json);
  Map<String, dynamic> toJson() => _$RiskAssetModelToJson(this);
}
