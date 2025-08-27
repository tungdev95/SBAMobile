// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'real_estate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealEstateModel _$RealEstateModelFromJson(Map<String, dynamic> json) =>
    RealEstateModel(
      facadeLength: (json['facadeLength'] as num?)?.toDouble(),
      totalLength: (json['totalLength'] as num?)?.toDouble(),
      combinePrivateArea: (json['combinePrivateArea'] as num?)?.toDouble(),
      combineCommonArea: (json['combineCommonArea'] as num?)?.toDouble(),
      combineAreaWidth: (json['combineAreaWidth'] as num?)?.toDouble(),
      combineAreaInPlan: (json['combineAreaInPlan'] as num?)?.toDouble(),
      combineAreaUnPlan: (json['combineAreaUnPlan'] as num?)?.toDouble(),
      combineNote: json['combineNote'] as String?,
      combineAppraisalLocation: json['combineAppraisalLocation'] as String?,
      businessAdvantage: json['businessAdvantage'] as String?,
      liquidity: json['liquidity'] as String?,
      currentUseSituation: json['currentUseSituation'] as String?,
      disputeInfor: json['disputeInfor'] as String?,
      note: json['note'] as String?,
      planningInfor: json['planningInfor'] as String?,
      legalInformations: json['legalInformations'] == null
          ? []
          : legalInformationsFromJson(json['legalInformations'] as List?),
      assetLandInfors: (json['assetLandInfors'] as List<dynamic>?)
              ?.map((e) => AssetLandInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      riskDetails: (json['riskDetails'] as List<dynamic>?)
              ?.map(RiskFactorModel.fromJson)
              .toList() ??
          [],
      assetId: json['assetId'] as String? ?? '',
      assetCode: json['assetCode'] as String? ?? '',
      whoCreate: json['whoCreate'] as String?,
      dateCreate: json['dateCreate'] == null
          ? null
          : DateTime.parse(json['dateCreate'] as String),
      dateModify: json['dateModify'] == null
          ? null
          : DateTime.parse(json['dateModify'] as String),
      rmName: json['rmName'] as String?,
      rmPhone: json['rmPhone'] as String?,
      surveyTime: json['surveyTime'] == null
          ? null
          : DateTime.parse(json['surveyTime'] as String),
      combineLandShape: json['combineLandShape'] as String?,
      combineAreaNotConsiderValue:
          (json['combineAreaNotConsiderValue'] as num?)?.toDouble(),
      combineLandAddressDetail: json['combineLandAddressDetail'] as String?,
      combineAreaWidthDetail: json['combineAreaWidthDetail'] as String?,
    )..extraData = json['extraData'] as Map<String, dynamic>?;

Map<String, dynamic> _$RealEstateModelToJson(RealEstateModel instance) =>
    <String, dynamic>{
      'assetId': instance.assetId,
      'assetCode': instance.assetCode,
      'whoCreate': instance.whoCreate,
      'rmName': instance.rmName,
      'rmPhone': instance.rmPhone,
      'dateCreate': instance.dateCreate?.toIso8601String(),
      'dateModify': instance.dateModify?.toIso8601String(),
      'surveyTime': instance.surveyTime?.toIso8601String(),
      'businessAdvantage': instance.businessAdvantage,
      'liquidity': instance.liquidity,
      'currentUseSituation': instance.currentUseSituation,
      'disputeInfor': instance.disputeInfor,
      'note': instance.note,
      'planningInfor': instance.planningInfor,
      'riskDetails': riskDetailToJson(instance.riskDetails),
      'legalInformations': legalInformationsToJson(instance.legalInformations),
      'extraData': instance.extraData,
      'facadeLength': instance.facadeLength,
      'totalLength': instance.totalLength,
      'combinePrivateArea': instance.combinePrivateArea,
      'combineCommonArea': instance.combineCommonArea,
      'combineAreaWidth': instance.combineAreaWidth,
      'combineAreaInPlan': instance.combineAreaInPlan,
      'combineAreaUnPlan': instance.combineAreaUnPlan,
      'combineNote': instance.combineNote,
      'combineAppraisalLocation': instance.combineAppraisalLocation,
      'combineLandShape': instance.combineLandShape,
      'combineAreaNotConsiderValue': instance.combineAreaNotConsiderValue,
      'combineAreaWidthDetail': instance.combineAreaWidthDetail,
      'assetLandInfors': instance.assetLandInfors,
      'combineLandAddressDetail': instance.combineLandAddressDetail,
    };
