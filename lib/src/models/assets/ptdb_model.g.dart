// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ptdb_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PTDBModel _$PTDBModelFromJson(Map<String, dynamic> json) => PTDBModel(
      legalVehicleBrand: json['legalVehicleBrand'] as String?,
      legalVehicleModel: json['legalVehicleModel'] as String?,
      legalColor: json['legalColor'] as String?,
      legalYearMfg: json['legalYearMfg'] as int?,
      legalCountryMfgId: json['legalCountryMfgId'] as int?,
      legalGearBoxId: json['legalGearBoxId'] as int?,
      legalWheelFormulaId: json['legalWheelFormulaId'] as int?,
      legalFuelId: json['legalFuelId'] as int?,
      legalVehicleIdNumber: json['legalVehicleIdNumber'] as String?,
      legalEngineNumber: json['legalEngineNumber'] as String?,
      legalPlateNumber: json['legalPlateNumber'] as String?,
      legalOverallDims: json['legalOverallDims'] as String?,
      legalWeightBase: (json['legalWeightBase'] as num?)?.toDouble(),
      legalWeightAll: json['legalWeightAll'] as String?,
      legalWheelBase: json['legalWheelBase'] as String?,
      legalPersonCarry: json['legalPersonCarry'] as String?,
      legalEngineDisp: (json['legalEngineDisp'] as num?)?.toDouble(),
      legalMaxOutputRpm: json['legalMaxOutputRpm'] as String?,
      legalNumberOfTires: json['legalNumberOfTires'] as String?,
      legalVehicleTrunkSize: json['legalVehicleTrunkSize'] as String?,
      legalVolumeOfGoodsTransported:
          json['legalVolumeOfGoodsTransported'] as String?,
      legalVolumeOfTowedGoods: json['legalVolumeOfTowedGoods'] as String?,
      legalTankCapacity: json['legalTankCapacity'] as String?,
      realVehicleBrand: json['realVehicleBrand'] as String?,
      realVehicleModel: json['realVehicleModel'] as String?,
      realColor: json['realColor'] as String?,
      realYearMfg: json['realYearMfg'] as int?,
      realCountryMfgId: json['realCountryMfgId'] as int?,
      realGearBoxId: json['realGearBoxId'] as int?,
      realWheelFormulaId: json['realWheelFormulaId'] as int?,
      realFuelId: json['realFuelId'] as int?,
      realVehicleIdNumber: json['realVehicleIdNumber'] as String?,
      realEngineNumber: json['realEngineNumber'] as String?,
      realPlateNumber: json['realPlateNumber'] as String?,
      realOverallDims: json['realOverallDims'] as String?,
      realWeightBase: (json['realWeightBase'] as num?)?.toDouble(),
      realWeightAll: json['realWeightAll'] as String?,
      realWheelBase: json['realWheelBase'] as String?,
      realPersonCarry: json['realPersonCarry'] as String?,
      realEngineDisp: (json['realEngineDisp'] as num?)?.toDouble(),
      realMaxOutputRpm: json['realMaxOutputRpm'] as String?,
      realNumberOfTires: json['realNumberOfTires'] as String?,
      realVehicleTrunkSize: json['realVehicleTrunkSize'] as String?,
      realVolumeOfGoodsTransported:
          json['realVolumeOfGoodsTransported'] as String?,
      realVolumeOfTowedGoods: json['realVolumeOfTowedGoods'] as String?,
      realTankCapacity: json['realTankCapacity'] as String?,
      usingOrigin: json['usingOrigin'] as String?,
      remainQuality: (json['remainQuality'] as num?)?.toDouble(),
      numberOfKilometersUsed:
          (json['numberOfKilometersUsed'] as num?)?.toDouble(),
      type: json['type'] as int?,
      noteLegalSBA: json['noteLegalSBA'] as String?,
      riskDetails: (json['riskDetails'] as List<dynamic>?)
              ?.map(RiskFactorModel.fromJson)
              .toList() ??
          [],
      legalInformations: json['legalInformations'] == null
          ? []
          : legalInformationsFromJson(json['legalInformations'] as List?),
      assetId: json['assetId'] as String? ?? '',
      assetCode: json['assetCode'] as String? ?? '',
      legalAdditionalContent: json['legalAdditionalContent'] as String?,
      realAdditionalContent: json['realAdditionalContent'] as String?,
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

Map<String, dynamic> _$PTDBModelToJson(PTDBModel instance) => <String, dynamic>{
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
      'noteLegalSBA': instance.noteLegalSBA,
      'legalVehicleBrand': instance.legalVehicleBrand,
      'legalVehicleModel': instance.legalVehicleModel,
      'legalColor': instance.legalColor,
      'legalYearMfg': instance.legalYearMfg,
      'legalCountryMfgId': instance.legalCountryMfgId,
      'legalGearBoxId': instance.legalGearBoxId,
      'legalWheelFormulaId': instance.legalWheelFormulaId,
      'legalFuelId': instance.legalFuelId,
      'legalVehicleIdNumber': instance.legalVehicleIdNumber,
      'legalEngineNumber': instance.legalEngineNumber,
      'legalPlateNumber': instance.legalPlateNumber,
      'legalOverallDims': instance.legalOverallDims,
      'legalWeightBase': instance.legalWeightBase,
      'legalWeightAll': instance.legalWeightAll,
      'legalWheelBase': instance.legalWheelBase,
      'legalPersonCarry': instance.legalPersonCarry,
      'legalEngineDisp': instance.legalEngineDisp,
      'legalMaxOutputRpm': instance.legalMaxOutputRpm,
      'legalNumberOfTires': instance.legalNumberOfTires,
      'legalVehicleTrunkSize': instance.legalVehicleTrunkSize,
      'legalVolumeOfGoodsTransported': instance.legalVolumeOfGoodsTransported,
      'legalVolumeOfTowedGoods': instance.legalVolumeOfTowedGoods,
      'legalTankCapacity': instance.legalTankCapacity,
      'legalAdditionalContent': instance.legalAdditionalContent,
      'realVehicleBrand': instance.realVehicleBrand,
      'realVehicleModel': instance.realVehicleModel,
      'realColor': instance.realColor,
      'realYearMfg': instance.realYearMfg,
      'realCountryMfgId': instance.realCountryMfgId,
      'realGearBoxId': instance.realGearBoxId,
      'realWheelFormulaId': instance.realWheelFormulaId,
      'realFuelId': instance.realFuelId,
      'realVehicleIdNumber': instance.realVehicleIdNumber,
      'realEngineNumber': instance.realEngineNumber,
      'realPlateNumber': instance.realPlateNumber,
      'realOverallDims': instance.realOverallDims,
      'realWeightBase': instance.realWeightBase,
      'realWeightAll': instance.realWeightAll,
      'realWheelBase': instance.realWheelBase,
      'realPersonCarry': instance.realPersonCarry,
      'realEngineDisp': instance.realEngineDisp,
      'realMaxOutputRpm': instance.realMaxOutputRpm,
      'realNumberOfTires': instance.realNumberOfTires,
      'realVehicleTrunkSize': instance.realVehicleTrunkSize,
      'realVolumeOfGoodsTransported': instance.realVolumeOfGoodsTransported,
      'realVolumeOfTowedGoods': instance.realVolumeOfTowedGoods,
      'realTankCapacity': instance.realTankCapacity,
      'realAdditionalContent': instance.realAdditionalContent,
      'usingOrigin': instance.usingOrigin,
      'remainQuality': instance.remainQuality,
      'numberOfKilometersUsed': instance.numberOfKilometersUsed,
      'type': instance.type,
    };
