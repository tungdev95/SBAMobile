// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combobox_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LegalComboModel _$LegalComboModelFromJson(Map<String, dynamic> json) =>
    LegalComboModel(
      legalInformationTypeId: json['legalInformationTypeId'] as int,
      legalInformationTypeName: json['legalInformationTypeName'] as String,
    );

Map<String, dynamic> _$LegalComboModelToJson(LegalComboModel instance) =>
    <String, dynamic>{
      'legalInformationTypeId': instance.legalInformationTypeId,
      'legalInformationTypeName': instance.legalInformationTypeName,
    };

RoadContiguousType _$RoadContiguousTypeFromJson(Map<String, dynamic> json) =>
    RoadContiguousType(
      roadContiguousTypeId: json['roadContiguousTypeId'] as int?,
      roadContiguousTypeName: json['roadContiguousTypeName'] as String?,
    );

Map<String, dynamic> _$RoadContiguousTypeToJson(RoadContiguousType instance) =>
    <String, dynamic>{
      'roadContiguousTypeId': instance.roadContiguousTypeId,
      'roadContiguousTypeName': instance.roadContiguousTypeName,
    };

PositionModel _$PositionModelFromJson(Map<String, dynamic> json) =>
    PositionModel(
      positionId: json['positionId'] as int?,
      positionName: json['positionName'] as String?,
    );

Map<String, dynamic> _$PositionModelToJson(PositionModel instance) =>
    <String, dynamic>{
      'positionId': instance.positionId,
      'positionName': instance.positionName,
    };

ZoneModel _$ZoneModelFromJson(Map<String, dynamic> json) => ZoneModel(
      zoneId: json['zoneId'] as int?,
      zone: json['zone'] as String?,
    );

Map<String, dynamic> _$ZoneModelToJson(ZoneModel instance) => <String, dynamic>{
      'zoneId': instance.zoneId,
      'zone': instance.zone,
    };

PositionInPriceRange _$PositionInPriceRangeFromJson(
        Map<String, dynamic> json) =>
    PositionInPriceRange(
      positionInPriceRangeId: json['positionInPriceRangeId'] as int?,
      positionInPriceRangeName: json['positionInPriceRangeName'] as String?,
    );

Map<String, dynamic> _$PositionInPriceRangeToJson(
        PositionInPriceRange instance) =>
    <String, dynamic>{
      'positionInPriceRangeId': instance.positionInPriceRangeId,
      'positionInPriceRangeName': instance.positionInPriceRangeName,
    };

UsingPurposeResponse _$UsingPurposeResponseFromJson(
        Map<String, dynamic> json) =>
    UsingPurposeResponse(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => UsingPurpose.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UsingPurposeResponseToJson(
        UsingPurposeResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

UsingPurpose _$UsingPurposeFromJson(Map<String, dynamic> json) => UsingPurpose(
      usingPurposeId: json['usingPurposeId'] as int?,
      usingPurposeName: json['usingPurposeName'] as String?,
      insideOutside: json['insideOutside'] as int?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$UsingPurposeToJson(UsingPurpose instance) =>
    <String, dynamic>{
      'usingPurposeId': instance.usingPurposeId,
      'usingPurposeName': instance.usingPurposeName,
      'insideOutside': instance.insideOutside,
      'status': instance.status,
    };

ConstructionType _$ConstructionTypeFromJson(Map<String, dynamic> json) =>
    ConstructionType(
      constructionTypeId: json['constructionTypeId'] as int?,
      constructionTypeName: json['constructionTypeName'] as String?,
    );

Map<String, dynamic> _$ConstructionTypeToJson(ConstructionType instance) =>
    <String, dynamic>{
      'constructionTypeId': instance.constructionTypeId,
      'constructionTypeName': instance.constructionTypeName,
    };

ConstructionName _$ConstructionNameFromJson(Map<String, dynamic> json) =>
    ConstructionName(
      constructionNameId: json['constructionNameId'] as int?,
      constructionName: json['constructionName'] as String?,
      lowPrice: (json['lowPrice'] as num?)?.toDouble(),
      highPrice: (json['highPrice'] as num?)?.toDouble(),
      constructionTypeId: json['constructionTypeId'] as int?,
    );

Map<String, dynamic> _$ConstructionNameToJson(ConstructionName instance) =>
    <String, dynamic>{
      'constructionNameId': instance.constructionNameId,
      'constructionName': instance.constructionName,
      'constructionTypeId': instance.constructionTypeId,
      'lowPrice': instance.lowPrice,
      'highPrice': instance.highPrice,
    };

TreeType _$TreeTypeFromJson(Map<String, dynamic> json) => TreeType(
      assetTreeTypeId: json['assetTreeTypeId'] as int? ?? 0,
      assetTreeTypeName: json['assetTreeTypeName'] as String? ?? '',
    );

Map<String, dynamic> _$TreeTypeToJson(TreeType instance) => <String, dynamic>{
      'assetTreeTypeId': instance.assetTreeTypeId,
      'assetTreeTypeName': instance.assetTreeTypeName,
    };

RoadInPrice _$RoadInPriceFromJson(Map<String, dynamic> json) => RoadInPrice(
      roadInPriceRangeId: json['roadInPriceRangeId'] as int? ?? 0,
      provinceCode: json['provinceCode'] as String? ?? '',
      districts: json['districts'] as String? ?? '',
      road: json['road'] as String? ?? '',
      doanDuongTu: json['doanDuongTu'] as String? ?? '',
      doanDuongDen: json['doanDuongDen'] as String? ?? '',
    );

Map<String, dynamic> _$RoadInPriceToJson(RoadInPrice instance) =>
    <String, dynamic>{
      'roadInPriceRangeId': instance.roadInPriceRangeId,
      'provinceCode': instance.provinceCode,
      'districts': instance.districts,
      'road': instance.road,
      'doanDuongTu': instance.doanDuongTu,
      'doanDuongDen': instance.doanDuongDen,
    };

RiskModel _$RiskModelFromJson(Map<String, dynamic> json) => RiskModel(
      riskTypeId: json['riskTypeId'] as int?,
      riskTypeName: json['riskTypeName'] as String?,
    );

Map<String, dynamic> _$RiskModelToJson(RiskModel instance) => <String, dynamic>{
      'riskTypeId': instance.riskTypeId,
      'riskTypeName': instance.riskTypeName,
    };

RiskContentModel _$RiskContentModelFromJson(Map<String, dynamic> json) =>
    RiskContentModel(
      riskAssetId: json['riskAssetId'] as int?,
      riskContent: json['riskContent'] as String?,
      assetLevelTwoId: json['assetLevelTwoId'] as int?,
      riskLevel: json['riskLevel'] as int?,
    );

Map<String, dynamic> _$RiskContentModelToJson(RiskContentModel instance) =>
    <String, dynamic>{
      'riskAssetId': instance.riskAssetId,
      'riskContent': instance.riskContent,
      'assetLevelTwoId': instance.assetLevelTwoId,
      'riskLevel': instance.riskLevel,
    };

DuAnChungCuModel _$DuAnChungCuModelFromJson(Map<String, dynamic> json) =>
    DuAnChungCuModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      provinceId: json['provinceId'] as String?,
      districtId: json['districtId'] as String?,
      wardId: json['wardId'] as String?,
    );

Map<String, dynamic> _$DuAnChungCuModelToJson(DuAnChungCuModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'provinceId': instance.provinceId,
      'districtId': instance.districtId,
      'wardId': instance.wardId,
    };

ToaNhaThucTeModel _$ToaNhaThucTeModelFromJson(Map<String, dynamic> json) =>
    ToaNhaThucTeModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      projectId: json['projectId'] as String?,
      provinceId: json['provinceId'] as String?,
      districtId: json['districtId'] as String?,
      wardId: json['wardId'] as String?,
    );

Map<String, dynamic> _$ToaNhaThucTeModelToJson(ToaNhaThucTeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'projectId': instance.projectId,
      'provinceId': instance.provinceId,
      'districtId': instance.districtId,
      'wardId': instance.wardId,
    };
