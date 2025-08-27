// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConstructionModel _$ConstructionModelFromJson(Map<String, dynamic> json) =>
    ConstructionModel(
      constructionTypeId: json['constructionTypeId'] as int?,
      constructionLegalTypeId: json['constructionLegalTypeId'] as int?,
      constructionNameId: json['constructionNameId'] as int?,
      constructionArea: (json['constructionArea'] as num?)?.toDouble(),
      legalInformationTypeId: json['legalInformationTypeId'] as int?,
      floors: (json['floors'] as num?)?.toDouble(),
      baseFloors: (json['baseFloors'] as num?)?.toDouble(),
      constructionYear: json['constructionYear'] as int?,
      repairYear: json['repairYear'] as int?,
      remainingQuality: (json['remainingQuality'] as num?)?.toDouble(),
      describe: json['describe'] as String?,
      furnitures: json['furnitures'] as String?,
      mdht: (json['mdht'] as num?)?.toDouble(),
      orderBy: json['orderBy'] as int?,
    );

Map<String, dynamic> _$ConstructionModelToJson(ConstructionModel instance) =>
    <String, dynamic>{
      'constructionTypeId': instance.constructionTypeId,
      'constructionLegalTypeId': instance.constructionLegalTypeId,
      'constructionNameId': instance.constructionNameId,
      'constructionArea': instance.constructionArea,
      'legalInformationTypeId': instance.legalInformationTypeId,
      'floors': instance.floors,
      'baseFloors': instance.baseFloors,
      'constructionYear': instance.constructionYear,
      'repairYear': instance.repairYear,
      'remainingQuality': instance.remainingQuality,
      'describe': instance.describe,
      'furnitures': instance.furnitures,
      'mdht': instance.mdht,
      'orderBy': instance.orderBy,
    };
