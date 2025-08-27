// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/models/base/serializer.dart';
import 'package:sba/src/utils/base_flutter_extensions.dart';
import 'package:sba/src/utils/uuid.dart';

part 'mmtb_model.g.dart';

@JsonSerializable()
class MMTBModel extends BaseDetailModel {
  String? legalInformationFull;
  String? usingOrigin;
  String? workingPrinciple;
  double? remainQuality;
  int? dayUse;
  String? productLineName;
  @JsonKey(defaultValue: [])
  List<MachineInfo> assetMachineInfors;

  MMTBModel({
    this.legalInformationFull,
    this.usingOrigin,
    this.workingPrinciple,
    this.remainQuality,
    this.dayUse,
    this.productLineName,
    required this.assetMachineInfors,
    required super.riskDetails,
    required super.legalInformations,
    required super.assetId,
    required super.assetCode,
  });

  factory MMTBModel.fromJson(Map<String, dynamic> json) => _$MMTBModelFromJson(
      Serializer.moveToExtraDataFromRoot(json, topLevelFields));
  Map<String, dynamic> toJson() =>
      Serializer.moveFromExtraDataToRoot(_$MMTBModelToJson(this));

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
    'legalInformationFull',
    'usingOrigin',
    'workingPrinciple',
    'remainQuality',
    'dayUse',
    'productLineName',
    'assetMachineInfors',
    'repairHistories',
  ];
}

@JsonSerializable()
class MachineInfo {
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? id;
  int? assetMachineInforId;
  String assetId;
  String? legalName;
  String? legalBrand;
  String? legalModel;
  String? legalColor;
  int? legalYearMfg;
  int? legalCountryMfgId;
  String? legalMfr;
  double? legalPower;
  String? legalControlType;
  String? legalSize;
  String? legalSpecs;
  String? legalEngine;
  String? legalElectricEngine;
  String? legalMainEngine;
  String? legalEngineSystem;
  String? legalEngineNo;
  int? legalCommonMachine;
  String? legalOtherContent;
  String? realName;
  String? realBrand;
  String? realModel;
  String? realColor;
  int? realYearMfg;
  int? realCountryMfgId;
  String? realMfr;
  double? realPower;
  String? realControlType;
  String? realSize;
  String? realSpecs;
  String? realEngine;
  String? realElectricEngine;
  String? realEngineNo;
  String? realMainEngine;
  String? realEngineSystem;
  int? realCommonMachine;
  String? realOtherContent;

  String? usingOrigin;
  String? currentUseSituation;
  String? liquidity;
  double? remainQuality;
  String? disputeInfor;
  String? note;
  int? dayUse;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? realCountryMfgName;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? legalCountryMfgName;
  @JsonKey(defaultValue: [])
  List<RepairHistory> repairHistories;

  MachineInfo({
    this.id,
    this.assetMachineInforId,
    required this.assetId,
    this.legalName,
    this.legalBrand,
    this.legalModel,
    this.legalColor,
    this.legalYearMfg,
    this.legalCountryMfgId,
    this.legalMfr,
    this.legalPower,
    this.legalControlType,
    this.legalSize,
    this.legalSpecs,
    this.legalEngine,
    this.legalElectricEngine,
    this.legalMainEngine,
    this.legalEngineSystem,
    this.legalCommonMachine,
    this.legalOtherContent,
    this.realName,
    this.realBrand,
    this.realModel,
    this.realColor,
    this.realYearMfg,
    this.realCountryMfgId,
    this.realMfr,
    this.realPower,
    this.realControlType,
    this.realSize,
    this.realSpecs,
    this.realEngine,
    this.realElectricEngine,
    this.realMainEngine,
    this.realEngineSystem,
    this.realCommonMachine,
    this.realOtherContent,
    required this.repairHistories,
    this.usingOrigin,
    this.currentUseSituation,
    this.liquidity,
    this.remainQuality,
    this.disputeInfor,
    this.note,
    this.dayUse,
    this.legalEngineNo,
    this.realEngineNo,
    this.realCountryMfgName,
    this.legalCountryMfgName,
  }) {
    id = Uuid().generateV4();
    liquidity ??= '2';
    disputeInfor ??= '0';
  }

  factory MachineInfo.fromJson(Map<String, dynamic> json) {
    final result = _$MachineInfoFromJson(
        Serializer.moveToExtraDataFromRoot(json, topLevelFields));
    //Gán tính thanh khoản => trung bình
    result.liquidity ??= '2';
    //Thông tin tranh chấp => không
    result.disputeInfor ??= '0';
    return result;
  }

  Map<String, dynamic> toJson() =>
      Serializer.moveFromExtraDataToRoot(_$MachineInfoToJson(this));

  String get tenMMTB {
    return legalName ?? realName ?? '';
  }

  String get brand {
    return legalBrand ?? realBrand ?? '';
  }

  static const topLevelFields = [
    'assetMachineInforId',
    'assetId',
    'legalName',
    'legalBrand',
    'legalModel',
    'legalColor',
    'legalYearMfg',
    'legalCountryMfgId',
    'legalMfr',
    'legalPower',
    'legalControlType',
    'legalSize',
    'legalSpecs',
    'legalEngine',
    'legalElectricEngine',
    'legalMainEngine',
    'legalEngineSystem',
    'legalCommonMachine',
    'legalOtherContent',
    'realName',
    'realBrand',
    'realModel',
    'realColor',
    'realYearMfg',
    'realCountryMfgId',
    'realMfr',
    'realPower',
    'realControlType',
    'realSize',
    'realSpecs',
    'realEngine',
    'realElectricEngine',
    'realMainEngine',
    'realEngineSystem',
    'realCommonMachine',
    'realOtherContent',
    'repairHistories',
    'usingOrigin',
    'currentUseSituation',
    'liquidity',
    'remainQuality',
    'disputeInfor',
    'note',
    'dayUse',
    'legalEngineNo',
    'realEngineNo',
    'realCountryMfgName',
    'legalCountryMfgName',
  ];

  MachineInfo copyWith({
    String? id,
    int? assetMachineInforId,
    String? assetId,
    String? legalName,
    String? legalBrand,
    String? legalModel,
    String? legalColor,
    int? legalYearMfg,
    int? legalCountryMfgId,
    String? legalMfr,
    double? legalPower,
    String? legalControlType,
    String? legalSize,
    String? legalSpecs,
    String? legalEngine,
    String? legalElectricEngine,
    String? legalMainEngine,
    String? legalEngineSystem,
    String? legalEngineNumber,
    int? legalCommonMachine,
    String? legalOtherContent,
    String? realName,
    String? realBrand,
    String? realModel,
    String? realColor,
    int? realYearMfg,
    int? realCountryMfgId,
    String? realMfr,
    double? realPower,
    String? realControlType,
    String? realSize,
    String? realSpecs,
    String? realEngine,
    String? realElectricEngine,
    String? realEngineNumber,
    String? realMainEngine,
    String? realEngineSystem,
    int? realCommonMachine,
    String? realOtherContent,
    String? usingOrigin,
    String? currentUseSituation,
    String? liquidity,
    double? remainQuality,
    String? disputeInfor,
    String? note,
    int? dayUse,
    String? realCountryMfgName,
    String? legalCountryMfgName,
    List<RepairHistory>? repairHistories,
  }) {
    return MachineInfo(
      id: id ?? this.id,
      assetMachineInforId: assetMachineInforId ?? this.assetMachineInforId,
      assetId: assetId ?? this.assetId,
      legalName: legalName ?? this.legalName,
      legalBrand: legalBrand ?? this.legalBrand,
      legalModel: legalModel ?? this.legalModel,
      legalColor: legalColor ?? this.legalColor,
      legalYearMfg: legalYearMfg ?? this.legalYearMfg,
      legalCountryMfgId: legalCountryMfgId ?? this.legalCountryMfgId,
      legalMfr: legalMfr ?? this.legalMfr,
      legalPower: legalPower ?? this.legalPower,
      legalControlType: legalControlType ?? this.legalControlType,
      legalSize: legalSize ?? this.legalSize,
      legalSpecs: legalSpecs ?? this.legalSpecs,
      legalEngine: legalEngine ?? this.legalEngine,
      legalElectricEngine: legalElectricEngine ?? this.legalElectricEngine,
      legalMainEngine: legalMainEngine ?? this.legalMainEngine,
      legalEngineSystem: legalEngineSystem ?? this.legalEngineSystem,
      legalEngineNo: legalEngineNumber ?? this.legalEngineNo,
      legalCommonMachine: legalCommonMachine ?? this.legalCommonMachine,
      legalOtherContent: legalOtherContent ?? this.legalOtherContent,
      realName: realName ?? this.realName,
      realBrand: realBrand ?? this.realBrand,
      realModel: realModel ?? this.realModel,
      realColor: realColor ?? this.realColor,
      realYearMfg: realYearMfg ?? this.realYearMfg,
      realCountryMfgId: realCountryMfgId ?? this.realCountryMfgId,
      realMfr: realMfr ?? this.realMfr,
      realPower: realPower ?? this.realPower,
      realControlType: realControlType ?? this.realControlType,
      realSize: realSize ?? this.realSize,
      realSpecs: realSpecs ?? this.realSpecs,
      realEngine: realEngine ?? this.realEngine,
      realElectricEngine: realElectricEngine ?? this.realElectricEngine,
      realEngineNo: realEngineNumber ?? this.realEngineNo,
      realMainEngine: realMainEngine ?? this.realMainEngine,
      realEngineSystem: realEngineSystem ?? this.realEngineSystem,
      realCommonMachine: realCommonMachine ?? this.realCommonMachine,
      realOtherContent: realOtherContent ?? this.realOtherContent,
      usingOrigin: usingOrigin ?? this.usingOrigin,
      currentUseSituation: currentUseSituation ?? this.currentUseSituation,
      liquidity: liquidity ?? this.liquidity,
      remainQuality: remainQuality ?? this.remainQuality,
      disputeInfor: disputeInfor ?? this.disputeInfor,
      note: note ?? this.note,
      dayUse: dayUse ?? this.dayUse,
      realCountryMfgName: realCountryMfgName ?? this.realCountryMfgName,
      legalCountryMfgName: legalCountryMfgName ?? this.legalCountryMfgName,
      repairHistories: repairHistories ?? this.repairHistories,
    );
  }
}

@JsonSerializable()
class RepairHistory {
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? id;
  int? repairHistoryId;
  String? assetId;
  String? note;
  DateTime? dateRepair;
  int? repairStatusId;
  String? repairDocument;
  String? ecmId;
  String? filename;
  String? mediaType;
  DateTime? dateUpload;
  String? whoUpload;
  @JsonKey(includeFromJson: false, includeToJson: false)
  AttachmentFile? fileAttach;

  RepairHistory({
    this.repairHistoryId,
    this.assetId,
    this.note,
    this.dateRepair,
    this.repairStatusId,
    this.repairDocument,
    this.ecmId,
    this.filename,
    this.mediaType,
    this.dateUpload,
    this.whoUpload,
  }) {
    id ??= repairHistoryId?.toString() ?? Uuid().generateV4();
  }

  factory RepairHistory.fromJson(Map<String, dynamic> json) =>
      _$RepairHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$RepairHistoryToJson(this);

  RepairHistory copyWith({
    int? repairHistoryId,
    String? assetId,
    String? note,
    DateTime? dateRepair,
    int? repairStatusId,
    String? repairDocument,
    String? ecmId,
    String? filename,
    String? mediaType,
    DateTime? dateUpload,
    String? whoUpload,
  }) {
    return RepairHistory(
      repairHistoryId: repairHistoryId ?? this.repairHistoryId,
      assetId: assetId ?? this.assetId,
      note: note ?? this.note,
      dateRepair: dateRepair ?? this.dateRepair,
      repairStatusId: repairStatusId ?? this.repairStatusId,
      repairDocument: repairDocument ?? this.repairDocument,
      ecmId: ecmId ?? this.ecmId,
      filename: filename ?? this.filename,
      mediaType: mediaType ?? this.mediaType,
      dateUpload: dateUpload ?? this.dateUpload,
      whoUpload: whoUpload ?? this.whoUpload,
    );
  }

  String get tenTaiLieu {
    if (fileAttach != null) {
      return fileAttach?.name ?? '';
    }
    return filename ?? '';
  }

  Future<void> addAttachmentResult(List<XFile> fileResult) async {
    if (fileResult.isEmpty) return;
    final attachFile = await (fileResult.first.toAttachmentFile);
    fileAttach = attachFile;
  }

  void uploadFileComplete(Attachment result) {
    ecmId = result.ecmId;
    filename = result.filename;
    mediaType = result.mediaType;
    whoUpload = result.whoUpload;
    dateUpload = DateTime.now().toUtc();
  }

  KeyValueModel? get trangThai {
    return lsTrangThai
        .firstWhereOrNull((element) => element.id == repairStatusId);
  }

  static final lsTrangThai = [
    KeyValueModel(id: 1, title: 'Chờ thực hiện'),
    KeyValueModel(id: 2, title: 'Đang thực hiện'),
    KeyValueModel(id: 3, title: 'Đã thực hiện'),
  ];
}
