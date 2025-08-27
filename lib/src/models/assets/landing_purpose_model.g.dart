// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landing_purpose_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LandingPurposeModel _$LandingPurposeModelFromJson(Map<String, dynamic> json) =>
    LandingPurposeModel(
      usingPurposeId: json['usingPurposeId'] as int?,
      usingOrigin: json['usingOrigin'] as String?,
      usingPeriod: json['usingPeriod'] as String?,
      legalAreaWidth: (json['legalAreaWidth'] as num?)?.toDouble(),
      legalAreaInPlan: (json['legalAreaInPlan'] as num?)?.toDouble() ?? 0,
      legalAreaUnPlan: (json['legalAreaUnPlan'] as num?)?.toDouble(),
      legalPrivateArea: (json['legalPrivateArea'] as num?)?.toDouble(),
      legalCommonArea: (json['legalCommonArea'] as num?)?.toDouble(),
      realAreaWidth: (json['realAreaWidth'] as num?)?.toDouble(),
      realAreaInPlan: (json['realAreaInPlan'] as num?)?.toDouble() ?? 0,
      realAreaUnPlan: (json['realAreaUnPlan'] as num?)?.toDouble(),
      realPrivateArea: (json['realPrivateArea'] as num?)?.toDouble(),
      realCommonArea: (json['realCommonArea'] as num?)?.toDouble(),
      isConsolidationPurposeParent:
          json['isConsolidationPurposeParent'] as bool?,
      orderBy: json['orderBy'] as int?,
      legalAreaNotConsiderValue:
          (json['legalAreaNotConsiderValue'] as num?)?.toDouble(),
      realAreaNotConsiderValue:
          (json['realAreaNotConsiderValue'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LandingPurposeModelToJson(
        LandingPurposeModel instance) =>
    <String, dynamic>{
      'usingPurposeId': instance.usingPurposeId,
      'usingOrigin': instance.usingOrigin,
      'usingPeriod': instance.usingPeriod,
      'legalAreaWidth': instance.legalAreaWidth,
      'legalAreaInPlan': instance.legalAreaInPlan,
      'legalAreaNotConsiderValue': instance.legalAreaNotConsiderValue,
      'legalAreaUnPlan': instance.legalAreaUnPlan,
      'legalPrivateArea': instance.legalPrivateArea,
      'legalCommonArea': instance.legalCommonArea,
      'realAreaWidth': instance.realAreaWidth,
      'realAreaInPlan': instance.realAreaInPlan,
      'realAreaUnPlan': instance.realAreaUnPlan,
      'realPrivateArea': instance.realPrivateArea,
      'realCommonArea': instance.realCommonArea,
      'realAreaNotConsiderValue': instance.realAreaNotConsiderValue,
      'isConsolidationPurposeParent': instance.isConsolidationPurposeParent,
      'orderBy': instance.orderBy,
    };
