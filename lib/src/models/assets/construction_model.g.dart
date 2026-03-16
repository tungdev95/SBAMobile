// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConstructionModel _$ConstructionModelFromJson(Map<String, dynamic> json) =>
    ConstructionModel(
      constructionTypeId: (json['constructionTypeId'] as num?)?.toInt(),
      constructionLegalTypeId:
          (json['constructionLegalTypeId'] as num?)?.toInt(),
      constructionNameId: (json['constructionNameId'] as num?)?.toInt(),
      constructionArea: (json['constructionArea'] as num?)?.toDouble(),
      legalInformationTypeId: (json['legalInformationTypeId'] as num?)?.toInt(),
      floors: (json['floors'] as num?)?.toDouble(),
      baseFloors: (json['baseFloors'] as num?)?.toDouble(),
      constructionYear: (json['constructionYear'] as num?)?.toInt(),
      repairYear: (json['repairYear'] as num?)?.toInt(),
      remainingQuality: (json['remainingQuality'] as num?)?.toDouble(),
      describe: json['describe'] as String?,
      furnitures: json['furnitures'] as String?,
      mdht: (json['mdht'] as num?)?.toDouble(),
      orderBy: (json['orderBy'] as num?)?.toInt(),
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
