// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/base/serializer.dart';

part 'ptdt_model.g.dart';

@JsonSerializable()
class PTDTModel extends BaseDetailModel {
  String? noteLegalSBA;
  String? legalName;
  String? legalRegisterNumber;
  String? legalModel;
  String? legalImoNumber;
  String? legalBrand;
  int? legalYearMfg;
  int? legalCountryMfg;
  String? legalShipbuildingBrand;
  int? legalRegisterCountry;
  String? legalShipUtilities;
  String? legalShipType;
  String? legalPersonCarry;
  double? legalDesignLength;
  double? legalDesignWidth;
  double? legalMaxLength;
  double? legalBoardHeight;
  double? legalSink;
  double? legalFreeBoard;
  String? legalSkinMaterial;
  int? legalMachineNum;
  double? legalMachinePower;
  double? legalDeadWeight;
  double? legalGrossTonnage;
  double? legalUseTonnage;
  double? legalSpeed;
  String? realName;
  String? realRegisterNumber;
  String? realModel;
  String? realImoNumber;
  String? realBrand;
  int? realYearMfg;
  int? realCountryMfg;
  String? realShipbuildingBrand;
  int? realRegisterCountry;
  String? realShipType;
  String? realShipUtilities;
  String? realPersonCarry;
  double? realDesignLength;
  double? realDesignWidth;
  double? realMaxLength;
  double? realBoardHeight;
  double? realSink;
  double? realFreeBoard;
  String? realSkinMaterial;
  int? realMachineNum;
  double? realMachinePower;
  double? realDeadWeight;
  double? realGrossTonnage;
  double? realUseTonnage;
  double? realSpeed;
  double? numberOfKmUsed;
  int? realYearReconstructed;
  int? legalYearReconstructed;
  String? legalAdditionalContent;
  String? realAdditionalContent;
  String? usingOrigin;
  int? odo;
  double? remainQuality;
  String? legalManufacturingLocation;
  String? realManufacturingLocation;
  int? numberOfDaysUsed;
  PTDTModel({
    this.noteLegalSBA,
    this.legalName,
    this.legalRegisterNumber,
    this.legalModel,
    this.legalImoNumber,
    this.legalBrand,
    this.legalYearMfg,
    this.legalCountryMfg,
    this.legalShipbuildingBrand,
    this.legalRegisterCountry,
    this.legalShipType,
    this.legalPersonCarry,
    this.legalDesignLength,
    this.legalDesignWidth,
    this.legalMaxLength,
    this.legalBoardHeight,
    this.legalSink,
    this.legalFreeBoard,
    this.legalSkinMaterial,
    this.legalMachineNum,
    this.legalMachinePower,
    this.legalDeadWeight,
    this.legalGrossTonnage,
    this.legalUseTonnage,
    this.legalSpeed,
    this.realName,
    this.realRegisterNumber,
    this.realModel,
    this.realImoNumber,
    this.realBrand,
    this.realYearMfg,
    this.realCountryMfg,
    this.realShipbuildingBrand,
    this.realRegisterCountry,
    this.realShipType,
    this.realPersonCarry,
    this.realDesignLength,
    this.realDesignWidth,
    this.realMaxLength,
    this.realBoardHeight,
    this.realSink,
    this.realFreeBoard,
    this.realSkinMaterial,
    this.realMachineNum,
    this.realMachinePower,
    this.realDeadWeight,
    this.realGrossTonnage,
    this.realUseTonnage,
    this.realSpeed,
    this.numberOfKmUsed,
    this.realYearReconstructed,
    this.legalYearReconstructed,
    this.legalAdditionalContent,
    this.realAdditionalContent,
    this.usingOrigin,
    this.odo,
    this.remainQuality,
    this.legalManufacturingLocation,
    this.realManufacturingLocation,
    this.numberOfDaysUsed,
    this.legalShipUtilities,
    this.realShipUtilities,
    required super.riskDetails,
    required super.legalInformations,
    required super.assetId,
    required super.assetCode,
  });

  factory PTDTModel.fromJson(Map<String, dynamic> json) {
    final result = _$PTDTModelFromJson(
        Serializer.moveToExtraDataFromRoot(json, topLevelFields));
    //Gán tính thanh khoản => trung bình
    result.liquidity ??= '2';
    //Thông tin tranh chấp => không
    result.disputeInfor ??= '0';
    return result;
  }

  Map<String, dynamic> toJson() =>
      Serializer.moveFromExtraDataToRoot(_$PTDTModelToJson(this));

  @override
  int get exportType => 0;
  static const topLevelFields = [
    'assetId',
    'assetCode',
    'whoCreate',
    'rmName',
    'rmPhone',
    'dateCreate',
    'dateModify',
    'surveyTime',
    'businessAdvantage',
    'liquidity',
    'currentUseSituation',
    'disputeInfor',
    'note',
    'planningInfor',
    'riskDetails',
    'legalInformations',
    'legalName',
    'legalRegisterNumber',
    'legalModel',
    'legalImoNumber',
    'legalBrand',
    'legalYearMfg',
    'legalCountryMfg',
    'legalShipbuildingBrand',
    'legalRegisterCountry',
    'legalShipType',
    'legalPersonCarry',
    'legalDesignLength',
    'legalDesignWidth',
    'legalMaxLength',
    'legalBoardHeight',
    'legalSink',
    'legalFreeBoard',
    'legalSkinMaterial',
    'legalMachineNum',
    'legalMachinePower',
    'legalDeadWeight',
    'legalGrossTonnage',
    'legalUseTonnage',
    'legalSpeed',
    'realName',
    'realRegisterNumber',
    'realModel',
    'realImoNumber',
    'realBrand',
    'realYearMfg',
    'realCountryMfg',
    'realShipbuildingBrand',
    'realRegisterCountry',
    'realShipType',
    'realPersonCarry',
    'realDesignLength',
    'realDesignWidth',
    'realMaxLength',
    'realBoardHeight',
    'realSink',
    'realFreeBoard',
    'realSkinMaterial',
    'realMachineNum',
    'realMachinePower',
    'realDeadWeight',
    'realGrossTonnage',
    'realUseTonnage',
    'realSpeed',
    'numberOfKmUsed',
    'realYearReconstructed',
    'legalYearReconstructed',
    'legalAdditionalContent',
    'realAdditionalContent',
    'usingOrigin',
    'odo',
    'remainQuality',
    'legalManufacturingLocation',
    'realManufacturingLocation',
    'numberOfDaysUsed',
    'legalShipUtilities',
    'realShipUtilities',
    'noteLegalSBA',
  ];
}
