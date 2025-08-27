// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ptdt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PTDTModel _$PTDTModelFromJson(Map<String, dynamic> json) => PTDTModel(
      noteLegalSBA: json['noteLegalSBA'] as String?,
      legalName: json['legalName'] as String?,
      legalRegisterNumber: json['legalRegisterNumber'] as String?,
      legalModel: json['legalModel'] as String?,
      legalImoNumber: json['legalImoNumber'] as String?,
      legalBrand: json['legalBrand'] as String?,
      legalYearMfg: json['legalYearMfg'] as int?,
      legalCountryMfg: json['legalCountryMfg'] as int?,
      legalShipbuildingBrand: json['legalShipbuildingBrand'] as String?,
      legalRegisterCountry: json['legalRegisterCountry'] as int?,
      legalShipType: json['legalShipType'] as String?,
      legalPersonCarry: json['legalPersonCarry'] as String?,
      legalDesignLength: (json['legalDesignLength'] as num?)?.toDouble(),
      legalDesignWidth: (json['legalDesignWidth'] as num?)?.toDouble(),
      legalMaxLength: (json['legalMaxLength'] as num?)?.toDouble(),
      legalBoardHeight: (json['legalBoardHeight'] as num?)?.toDouble(),
      legalSink: (json['legalSink'] as num?)?.toDouble(),
      legalFreeBoard: (json['legalFreeBoard'] as num?)?.toDouble(),
      legalSkinMaterial: json['legalSkinMaterial'] as String?,
      legalMachineNum: json['legalMachineNum'] as int?,
      legalMachinePower: (json['legalMachinePower'] as num?)?.toDouble(),
      legalDeadWeight: (json['legalDeadWeight'] as num?)?.toDouble(),
      legalGrossTonnage: (json['legalGrossTonnage'] as num?)?.toDouble(),
      legalUseTonnage: (json['legalUseTonnage'] as num?)?.toDouble(),
      legalSpeed: (json['legalSpeed'] as num?)?.toDouble(),
      realName: json['realName'] as String?,
      realRegisterNumber: json['realRegisterNumber'] as String?,
      realModel: json['realModel'] as String?,
      realImoNumber: json['realImoNumber'] as String?,
      realBrand: json['realBrand'] as String?,
      realYearMfg: json['realYearMfg'] as int?,
      realCountryMfg: json['realCountryMfg'] as int?,
      realShipbuildingBrand: json['realShipbuildingBrand'] as String?,
      realRegisterCountry: json['realRegisterCountry'] as int?,
      realShipType: json['realShipType'] as String?,
      realPersonCarry: json['realPersonCarry'] as String?,
      realDesignLength: (json['realDesignLength'] as num?)?.toDouble(),
      realDesignWidth: (json['realDesignWidth'] as num?)?.toDouble(),
      realMaxLength: (json['realMaxLength'] as num?)?.toDouble(),
      realBoardHeight: (json['realBoardHeight'] as num?)?.toDouble(),
      realSink: (json['realSink'] as num?)?.toDouble(),
      realFreeBoard: (json['realFreeBoard'] as num?)?.toDouble(),
      realSkinMaterial: json['realSkinMaterial'] as String?,
      realMachineNum: json['realMachineNum'] as int?,
      realMachinePower: (json['realMachinePower'] as num?)?.toDouble(),
      realDeadWeight: (json['realDeadWeight'] as num?)?.toDouble(),
      realGrossTonnage: (json['realGrossTonnage'] as num?)?.toDouble(),
      realUseTonnage: (json['realUseTonnage'] as num?)?.toDouble(),
      realSpeed: (json['realSpeed'] as num?)?.toDouble(),
      numberOfKmUsed: (json['numberOfKmUsed'] as num?)?.toDouble(),
      realYearReconstructed: json['realYearReconstructed'] as int?,
      legalYearReconstructed: json['legalYearReconstructed'] as int?,
      legalAdditionalContent: json['legalAdditionalContent'] as String?,
      realAdditionalContent: json['realAdditionalContent'] as String?,
      usingOrigin: json['usingOrigin'] as String?,
      odo: json['odo'] as int?,
      remainQuality: (json['remainQuality'] as num?)?.toDouble(),
      legalManufacturingLocation: json['legalManufacturingLocation'] as String?,
      realManufacturingLocation: json['realManufacturingLocation'] as String?,
      numberOfDaysUsed: json['numberOfDaysUsed'] as int?,
      legalShipUtilities: json['legalShipUtilities'] as String?,
      realShipUtilities: json['realShipUtilities'] as String?,
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

Map<String, dynamic> _$PTDTModelToJson(PTDTModel instance) => <String, dynamic>{
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
      'legalName': instance.legalName,
      'legalRegisterNumber': instance.legalRegisterNumber,
      'legalModel': instance.legalModel,
      'legalImoNumber': instance.legalImoNumber,
      'legalBrand': instance.legalBrand,
      'legalYearMfg': instance.legalYearMfg,
      'legalCountryMfg': instance.legalCountryMfg,
      'legalShipbuildingBrand': instance.legalShipbuildingBrand,
      'legalRegisterCountry': instance.legalRegisterCountry,
      'legalShipUtilities': instance.legalShipUtilities,
      'legalShipType': instance.legalShipType,
      'legalPersonCarry': instance.legalPersonCarry,
      'legalDesignLength': instance.legalDesignLength,
      'legalDesignWidth': instance.legalDesignWidth,
      'legalMaxLength': instance.legalMaxLength,
      'legalBoardHeight': instance.legalBoardHeight,
      'legalSink': instance.legalSink,
      'legalFreeBoard': instance.legalFreeBoard,
      'legalSkinMaterial': instance.legalSkinMaterial,
      'legalMachineNum': instance.legalMachineNum,
      'legalMachinePower': instance.legalMachinePower,
      'legalDeadWeight': instance.legalDeadWeight,
      'legalGrossTonnage': instance.legalGrossTonnage,
      'legalUseTonnage': instance.legalUseTonnage,
      'legalSpeed': instance.legalSpeed,
      'realName': instance.realName,
      'realRegisterNumber': instance.realRegisterNumber,
      'realModel': instance.realModel,
      'realImoNumber': instance.realImoNumber,
      'realBrand': instance.realBrand,
      'realYearMfg': instance.realYearMfg,
      'realCountryMfg': instance.realCountryMfg,
      'realShipbuildingBrand': instance.realShipbuildingBrand,
      'realRegisterCountry': instance.realRegisterCountry,
      'realShipType': instance.realShipType,
      'realShipUtilities': instance.realShipUtilities,
      'realPersonCarry': instance.realPersonCarry,
      'realDesignLength': instance.realDesignLength,
      'realDesignWidth': instance.realDesignWidth,
      'realMaxLength': instance.realMaxLength,
      'realBoardHeight': instance.realBoardHeight,
      'realSink': instance.realSink,
      'realFreeBoard': instance.realFreeBoard,
      'realSkinMaterial': instance.realSkinMaterial,
      'realMachineNum': instance.realMachineNum,
      'realMachinePower': instance.realMachinePower,
      'realDeadWeight': instance.realDeadWeight,
      'realGrossTonnage': instance.realGrossTonnage,
      'realUseTonnage': instance.realUseTonnage,
      'realSpeed': instance.realSpeed,
      'numberOfKmUsed': instance.numberOfKmUsed,
      'realYearReconstructed': instance.realYearReconstructed,
      'legalYearReconstructed': instance.legalYearReconstructed,
      'legalAdditionalContent': instance.legalAdditionalContent,
      'realAdditionalContent': instance.realAdditionalContent,
      'usingOrigin': instance.usingOrigin,
      'odo': instance.odo,
      'remainQuality': instance.remainQuality,
      'legalManufacturingLocation': instance.legalManufacturingLocation,
      'realManufacturingLocation': instance.realManufacturingLocation,
      'numberOfDaysUsed': instance.numberOfDaysUsed,
    };
