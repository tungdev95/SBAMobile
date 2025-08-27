// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mmtb_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MMTBModel _$MMTBModelFromJson(Map<String, dynamic> json) => MMTBModel(
      legalInformationFull: json['legalInformationFull'] as String?,
      usingOrigin: json['usingOrigin'] as String?,
      workingPrinciple: json['workingPrinciple'] as String?,
      remainQuality: (json['remainQuality'] as num?)?.toDouble(),
      dayUse: json['dayUse'] as int?,
      productLineName: json['productLineName'] as String?,
      assetMachineInfors: (json['assetMachineInfors'] as List<dynamic>?)
              ?.map((e) => MachineInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      riskDetails: (json['riskDetails'] as List<dynamic>?)
              ?.map(RiskFactorModel.fromJson)
              .toList() ??
          [],
      legalInformations: json['legalInformations'] == null
          ? []
          : legalInformationsFromJson(json['legalInformations'] as List?),
      assetId: json['assetId'] as String? ?? '',
      assetCode: json['assetCode'] as String? ?? '',
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

Map<String, dynamic> _$MMTBModelToJson(MMTBModel instance) => <String, dynamic>{
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
      'legalInformationFull': instance.legalInformationFull,
      'usingOrigin': instance.usingOrigin,
      'workingPrinciple': instance.workingPrinciple,
      'remainQuality': instance.remainQuality,
      'dayUse': instance.dayUse,
      'productLineName': instance.productLineName,
      'assetMachineInfors': instance.assetMachineInfors,
    };

MachineInfo _$MachineInfoFromJson(Map<String, dynamic> json) => MachineInfo(
      assetMachineInforId: json['assetMachineInforId'] as int?,
      assetId: json['assetId'] as String,
      legalName: json['legalName'] as String?,
      legalBrand: json['legalBrand'] as String?,
      legalModel: json['legalModel'] as String?,
      legalColor: json['legalColor'] as String?,
      legalYearMfg: json['legalYearMfg'] as int?,
      legalCountryMfgId: json['legalCountryMfgId'] as int?,
      legalMfr: json['legalMfr'] as String?,
      legalPower: (json['legalPower'] as num?)?.toDouble(),
      legalControlType: json['legalControlType'] as String?,
      legalSize: json['legalSize'] as String?,
      legalSpecs: json['legalSpecs'] as String?,
      legalEngine: json['legalEngine'] as String?,
      legalElectricEngine: json['legalElectricEngine'] as String?,
      legalMainEngine: json['legalMainEngine'] as String?,
      legalEngineSystem: json['legalEngineSystem'] as String?,
      legalCommonMachine: json['legalCommonMachine'] as int?,
      legalOtherContent: json['legalOtherContent'] as String?,
      realName: json['realName'] as String?,
      realBrand: json['realBrand'] as String?,
      realModel: json['realModel'] as String?,
      realColor: json['realColor'] as String?,
      realYearMfg: json['realYearMfg'] as int?,
      realCountryMfgId: json['realCountryMfgId'] as int?,
      realMfr: json['realMfr'] as String?,
      realPower: (json['realPower'] as num?)?.toDouble(),
      realControlType: json['realControlType'] as String?,
      realSize: json['realSize'] as String?,
      realSpecs: json['realSpecs'] as String?,
      realEngine: json['realEngine'] as String?,
      realElectricEngine: json['realElectricEngine'] as String?,
      realMainEngine: json['realMainEngine'] as String?,
      realEngineSystem: json['realEngineSystem'] as String?,
      realCommonMachine: json['realCommonMachine'] as int?,
      realOtherContent: json['realOtherContent'] as String?,
      repairHistories: (json['repairHistories'] as List<dynamic>?)
              ?.map((e) => RepairHistory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      usingOrigin: json['usingOrigin'] as String?,
      currentUseSituation: json['currentUseSituation'] as String?,
      liquidity: json['liquidity'] as String?,
      remainQuality: (json['remainQuality'] as num?)?.toDouble(),
      disputeInfor: json['disputeInfor'] as String?,
      note: json['note'] as String?,
      dayUse: json['dayUse'] as int?,
      legalEngineNo: json['legalEngineNo'] as String?,
      realEngineNo: json['realEngineNo'] as String?,
    );

Map<String, dynamic> _$MachineInfoToJson(MachineInfo instance) =>
    <String, dynamic>{
      'assetMachineInforId': instance.assetMachineInforId,
      'assetId': instance.assetId,
      'legalName': instance.legalName,
      'legalBrand': instance.legalBrand,
      'legalModel': instance.legalModel,
      'legalColor': instance.legalColor,
      'legalYearMfg': instance.legalYearMfg,
      'legalCountryMfgId': instance.legalCountryMfgId,
      'legalMfr': instance.legalMfr,
      'legalPower': instance.legalPower,
      'legalControlType': instance.legalControlType,
      'legalSize': instance.legalSize,
      'legalSpecs': instance.legalSpecs,
      'legalEngine': instance.legalEngine,
      'legalElectricEngine': instance.legalElectricEngine,
      'legalMainEngine': instance.legalMainEngine,
      'legalEngineSystem': instance.legalEngineSystem,
      'legalEngineNo': instance.legalEngineNo,
      'legalCommonMachine': instance.legalCommonMachine,
      'legalOtherContent': instance.legalOtherContent,
      'realName': instance.realName,
      'realBrand': instance.realBrand,
      'realModel': instance.realModel,
      'realColor': instance.realColor,
      'realYearMfg': instance.realYearMfg,
      'realCountryMfgId': instance.realCountryMfgId,
      'realMfr': instance.realMfr,
      'realPower': instance.realPower,
      'realControlType': instance.realControlType,
      'realSize': instance.realSize,
      'realSpecs': instance.realSpecs,
      'realEngine': instance.realEngine,
      'realElectricEngine': instance.realElectricEngine,
      'realEngineNo': instance.realEngineNo,
      'realMainEngine': instance.realMainEngine,
      'realEngineSystem': instance.realEngineSystem,
      'realCommonMachine': instance.realCommonMachine,
      'realOtherContent': instance.realOtherContent,
      'usingOrigin': instance.usingOrigin,
      'currentUseSituation': instance.currentUseSituation,
      'liquidity': instance.liquidity,
      'remainQuality': instance.remainQuality,
      'disputeInfor': instance.disputeInfor,
      'note': instance.note,
      'dayUse': instance.dayUse,
      'repairHistories': instance.repairHistories,
    };

RepairHistory _$RepairHistoryFromJson(Map<String, dynamic> json) =>
    RepairHistory(
      repairHistoryId: json['repairHistoryId'] as int?,
      assetId: json['assetId'] as String?,
      note: json['note'] as String?,
      dateRepair: json['dateRepair'] == null
          ? null
          : DateTime.parse(json['dateRepair'] as String),
      repairStatusId: json['repairStatusId'] as int?,
      repairDocument: json['repairDocument'] as String?,
      ecmId: json['ecmId'] as String?,
      filename: json['filename'] as String?,
      mediaType: json['mediaType'] as String?,
      dateUpload: json['dateUpload'] == null
          ? null
          : DateTime.parse(json['dateUpload'] as String),
      whoUpload: json['whoUpload'] as String?,
    );

Map<String, dynamic> _$RepairHistoryToJson(RepairHistory instance) =>
    <String, dynamic>{
      'repairHistoryId': instance.repairHistoryId,
      'assetId': instance.assetId,
      'note': instance.note,
      'dateRepair': instance.dateRepair?.toIso8601String(),
      'repairStatusId': instance.repairStatusId,
      'repairDocument': instance.repairDocument,
      'ecmId': instance.ecmId,
      'filename': instance.filename,
      'mediaType': instance.mediaType,
      'dateUpload': instance.dateUpload?.toIso8601String(),
      'whoUpload': instance.whoUpload,
    };
