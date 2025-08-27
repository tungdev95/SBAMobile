import 'package:sba/src/models/assets/assets.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:sba/src/models/base/serializer.dart';

part 'ptdb_model.g.dart';

@JsonSerializable()
class PTDBModel extends BaseDetailModel {
  String? noteLegalSBA;
  String? legalVehicleBrand;
  String? legalVehicleModel;
  String? legalColor;
  int? legalYearMfg;
  int? legalCountryMfgId;
  int? legalGearBoxId;
  int? legalWheelFormulaId;
  int? legalFuelId;
  String? legalVehicleIdNumber;
  String? legalEngineNumber;
  String? legalPlateNumber;
  String? legalOverallDims;
  double? legalWeightBase;
  String? legalWeightAll;
  String? legalWheelBase;
  String? legalPersonCarry;
  double? legalEngineDisp;
  String? legalMaxOutputRpm;
  String? legalNumberOfTires;
  String? legalVehicleTrunkSize;
  String? legalVolumeOfGoodsTransported;
  String? legalVolumeOfTowedGoods;
  String? legalTankCapacity;
  String? legalAdditionalContent;

  String? realVehicleBrand;
  String? realVehicleModel;
  String? realColor;
  int? realYearMfg;
  int? realCountryMfgId;
  int? realGearBoxId;
  int? realWheelFormulaId;
  int? realFuelId;
  String? realVehicleIdNumber;
  String? realEngineNumber;
  String? realPlateNumber;
  String? realOverallDims;
  double? realWeightBase;
  String? realWeightAll;
  String? realWheelBase;
  String? realPersonCarry;
  double? realEngineDisp;
  String? realMaxOutputRpm;
  String? realNumberOfTires;
  String? realVehicleTrunkSize;
  String? realVolumeOfGoodsTransported;
  String? realVolumeOfTowedGoods;
  String? realTankCapacity;
  String? realAdditionalContent;
  String? usingOrigin;
  double? remainQuality;
  double? numberOfKilometersUsed;
  int? type;

  PTDBModel({
    this.legalVehicleBrand,
    this.legalVehicleModel,
    this.legalColor,
    this.legalYearMfg,
    this.legalCountryMfgId,
    this.legalGearBoxId,
    this.legalWheelFormulaId,
    this.legalFuelId,
    this.legalVehicleIdNumber,
    this.legalEngineNumber,
    this.legalPlateNumber,
    this.legalOverallDims,
    this.legalWeightBase,
    this.legalWeightAll,
    this.legalWheelBase,
    this.legalPersonCarry,
    this.legalEngineDisp,
    this.legalMaxOutputRpm,
    this.legalNumberOfTires,
    this.legalVehicleTrunkSize,
    this.legalVolumeOfGoodsTransported,
    this.legalVolumeOfTowedGoods,
    this.legalTankCapacity,
    this.realVehicleBrand,
    this.realVehicleModel,
    this.realColor,
    this.realYearMfg,
    this.realCountryMfgId,
    this.realGearBoxId,
    this.realWheelFormulaId,
    this.realFuelId,
    this.realVehicleIdNumber,
    this.realEngineNumber,
    this.realPlateNumber,
    this.realOverallDims,
    this.realWeightBase,
    this.realWeightAll,
    this.realWheelBase,
    this.realPersonCarry,
    this.realEngineDisp,
    this.realMaxOutputRpm,
    this.realNumberOfTires,
    this.realVehicleTrunkSize,
    this.realVolumeOfGoodsTransported,
    this.realVolumeOfTowedGoods,
    this.realTankCapacity,
    this.usingOrigin,
    this.remainQuality,
    this.numberOfKilometersUsed,
    this.type,
    this.noteLegalSBA,
    required super.riskDetails,
    required super.legalInformations,
    required super.assetId,
    required super.assetCode,
    this.legalAdditionalContent,
    this.realAdditionalContent,
  });

  factory PTDBModel.fromJson(Map<String, dynamic> json) {
    final result = _$PTDBModelFromJson(
        Serializer.moveToExtraDataFromRoot(json, topLevelFields));
    //Gán tính thanh khoản => trung bình
    result.liquidity ??= '2';
    //Thông tin tranh chấp => không
    result.disputeInfor ??= '0';
    return result;
  }
  Map<String, dynamic> toJson() =>
      Serializer.moveFromExtraDataToRoot(_$PTDBModelToJson(this));

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
    'legalVehicleBrand',
    'legalVehicleModel',
    'legalColor',
    'legalYearMfg',
    'legalCountryMfgId',
    'legalGearBoxId',
    'legalWheelFormulaId',
    'legalFuelId',
    'legalVehicleIdNumber',
    'legalEngineNumber',
    'legalPlateNumber',
    'legalOverallDims',
    'legalWeightBase',
    'legalWeightAll',
    'legalWheelBase',
    'legalPersonCarry',
    'legalEngineDisp',
    'legalMaxOutputRpm',
    'legalNumberOfTires',
    'legalVehicleTrunkSize',
    'legalVolumeOfGoodsTransported',
    'legalVolumeOfTowedGoods',
    'legalTankCapacity',
    'realVehicleBrand',
    'realVehicleModel',
    'realColor',
    'realYearMfg',
    'realCountryMfgId',
    'realGearBoxId',
    'realWheelFormulaId',
    'realFuelId',
    'realVehicleIdNumber',
    'realEngineNumber',
    'realPlateNumber',
    'realOverallDims',
    'realWeightBase',
    'realWeightAll',
    'realWheelBase',
    'realPersonCarry',
    'realEngineDisp',
    'realMaxOutputRpm',
    'realNumberOfTires',
    'realVehicleTrunkSize',
    'realVolumeOfGoodsTransported',
    'realVolumeOfTowedGoods',
    'realTankCapacity',
    'usingOrigin',
    'remainQuality',
    'numberOfKilometersUsed',
    'type',
    'noteLegalSBA',
    'realAdditionalContent',
    'legalAdditionalContent',
  ];
}
