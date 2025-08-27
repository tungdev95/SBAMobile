// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chcc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CHCCModel _$CHCCModelFromJson(Map<String, dynamic> json) => CHCCModel(
      legalInformations: json['legalInformations'] == null
          ? []
          : legalInformationsFromJson(json['legalInformations'] as List?),
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
      businessAdvantage: json['businessAdvantage'] as String?,
      liquidity: json['liquidity'] as String?,
      currentUseSituation: json['currentUseSituation'] as String?,
      disputeInfor: json['disputeInfor'] as String?,
      note: json['note'] as String?,
      planningInfor: json['planningInfor'] as String?,
      assetApartmentInfors: (json['assetApartmentInfors'] as List<dynamic>?)
              ?.map(CHCCInfo.fromJson)
              .toList() ??
          [],
      combinePrivateArea: (json['combinePrivateArea'] as num?)?.toDouble(),
      combineNote: json['combineNote'] as String?,
      rmName: json['rmName'] as String?,
      rmPhone: json['rmPhone'] as String?,
      surveyTime: json['surveyTime'] == null
          ? null
          : DateTime.parse(json['surveyTime'] as String),
      utilities: json['utilities'] as String?,
      combineAppraisalLocation: json['combineAppraisalLocation'] as String?,
    )..extraData = json['extraData'] as Map<String, dynamic>?;

Map<String, dynamic> _$CHCCModelToJson(CHCCModel instance) => <String, dynamic>{
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
      'assetApartmentInfors': instance.assetApartmentInfors,
      'combinePrivateArea': instance.combinePrivateArea,
      'combineNote': instance.combineNote,
      'utilities': instance.utilities,
      'combineAppraisalLocation': instance.combineAppraisalLocation,
    };
