// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_factor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RiskFactorModel _$RiskFactorModelFromJson(Map<String, dynamic> json) =>
    RiskFactorModel(
      riskDetailId: json['riskDetailId'] as int?,
      assetId: json['assetId'] as String?,
      riskAssetId: json['riskAssetId'] as int?,
      riskTypeId: json['riskTypeId'] as int?,
      description: json['description'] as String?,
      riskAsset: json['riskAsset'] == null
          ? null
          : RiskAssetModel.fromJson(json['riskAsset']),
    );

Map<String, dynamic> _$RiskFactorModelToJson(RiskFactorModel instance) =>
    <String, dynamic>{
      'riskDetailId': instance.riskDetailId,
      'assetId': instance.assetId,
      'riskAssetId': instance.riskAssetId,
      'riskTypeId': instance.riskTypeId,
      'description': instance.description,
      'riskAsset': instance.riskAsset,
    };

RiskAssetModel _$RiskAssetModelFromJson(Map<String, dynamic> json) =>
    RiskAssetModel(
      riskAssetId: json['riskAssetId'] as int?,
      riskContent: json['riskContent'] as String?,
      assetLevelTwoId: json['assetLevelTwoId'] as int?,
      description: json['description'] as String?,
      riskLevel: json['riskLevel'] as int?,
    );

Map<String, dynamic> _$RiskAssetModelToJson(RiskAssetModel instance) =>
    <String, dynamic>{
      'riskAssetId': instance.riskAssetId,
      'riskContent': instance.riskContent,
      'assetLevelTwoId': instance.assetLevelTwoId,
      'description': instance.description,
      'riskLevel': instance.riskLevel,
    };
