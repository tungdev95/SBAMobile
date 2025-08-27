// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DuAnModel _$DuAnModelFromJson(Map<String, dynamic> json) => DuAnModel(
      haveApartment: json['haveApartment'] as bool?,
      apartmentNote: json['apartmentNote'] as String?,
      haveLandForRent: json['haveLandForRent'] as bool?,
      landForRentNote: json['landForRentNote'] as String?,
      typeService: json['typeService'] as String?,
      haveGround: json['haveGround'] as bool?,
      groundNote: json['groundNote'] as String?,
      assetProjectInfor: json['assetProjectInfor'] == null
          ? null
          : AssetProjectInfo.fromJson(
              json['assetProjectInfor'] as Map<String, dynamic>),
      assetId: json['assetId'] as String? ?? '',
      assetCode: json['assetCode'] as String? ?? '',
      riskDetails: (json['riskDetails'] as List<dynamic>?)
              ?.map(RiskFactorModel.fromJson)
              .toList() ??
          [],
      legalInformations: json['legalInformations'] == null
          ? []
          : legalInformationsFromJson(json['legalInformations'] as List?),
    )
      ..whoCreate = json['whoCreate'] as String?
      ..rmName = json['rmName'] as String?
      ..rmPhone = json['rmPhone'] as String?
      ..dateCreate = json['dateCreate'] == null
          ? null
          : DateTime.parse(json['dateCreate'] as String)
      ..dateModify = json['dateModify'] == null
          ? null
          : DateTime.parse(json['dateModify'] as String)
      ..surveyTime = json['surveyTime'] == null
          ? null
          : DateTime.parse(json['surveyTime'] as String)
      ..businessAdvantage = json['businessAdvantage'] as String?
      ..liquidity = json['liquidity'] as String?
      ..currentUseSituation = json['currentUseSituation'] as String?
      ..disputeInfor = json['disputeInfor'] as String?
      ..note = json['note'] as String?
      ..planningInfor = json['planningInfor'] as String?
      ..extraData = json['extraData'] as Map<String, dynamic>?;

Map<String, dynamic> _$DuAnModelToJson(DuAnModel instance) => <String, dynamic>{
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
      'apartmentNote': instance.apartmentNote,
      'landForRentNote': instance.landForRentNote,
      'typeService': instance.typeService,
      'groundNote': instance.groundNote,
      'assetProjectInfor': instance.assetProjectInfor,
      'haveApartment': instance.haveApartment,
      'haveLandForRent': instance.haveLandForRent,
      'haveGround': instance.haveGround,
    };

AssetProjectInfo _$AssetProjectInfoFromJson(Map<String, dynamic> json) =>
    AssetProjectInfo(
      assetProjectInforId: json['assetProjectInforId'] as int?,
      assetId: json['assetId'] as String?,
      provinceCode: json['provinceCode'] as String?,
      provinceName: json['provinceName'] as String?,
      districtCode: json['districtCode'] as String?,
      districtName: json['districtName'] as String?,
      wardCode: json['wardCode'] as String?,
      wardName: json['wardName'] as String?,
      appraisalLocation: json['appraisalLocation'] as String?,
      areaWidth: (json['areaWidth'] as num?)?.toDouble(),
      currentAsset: json['currentAsset'] as String?,
      description: json['description'] as String?,
      assetLandUsingPurposes: (json['assetLandUsingPurposes'] as List<dynamic>?)
              ?.map(LandingPurposeModel.fromJson)
              .toList() ??
          [],
      assetTrees: (json['assetTrees'] as List<dynamic>?)
              ?.map(TreeModel.fromJson)
              .toList() ??
          [],
      constructions: (json['constructions'] as List<dynamic>?)
              ?.map(ConstructionModel.fromJson)
              .toList() ??
          [],
      detailDescribes: (json['detailDescribes'] as List<dynamic>?)
              ?.map((e) =>
                  DetailDescribeModel.fromJson(e as Map<String, dynamic>?))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AssetProjectInfoToJson(AssetProjectInfo instance) =>
    <String, dynamic>{
      'assetProjectInforId': instance.assetProjectInforId,
      'assetId': instance.assetId,
      'provinceCode': instance.provinceCode,
      'provinceName': instance.provinceName,
      'districtCode': instance.districtCode,
      'districtName': instance.districtName,
      'wardCode': instance.wardCode,
      'wardName': instance.wardName,
      'appraisalLocation': instance.appraisalLocation,
      'areaWidth': instance.areaWidth,
      'currentAsset': instance.currentAsset,
      'description': instance.description,
      'assetLandUsingPurposes': instance.assetLandUsingPurposes,
      'assetTrees': instance.assetTrees,
      'constructions': instance.constructions,
      'detailDescribes': instance.detailDescribes,
    };
