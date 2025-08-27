// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/detail_describe_model.dart';
import 'package:sba/src/models/base/serializer.dart';
import 'package:sba/src/utils/uuid.dart';

part 'duan_model.g.dart';

@JsonSerializable()
class DuAnModel extends BaseDetailModel {
  String? apartmentNote;
  String? landForRentNote;
  String? typeService;
  String? groundNote;
  AssetProjectInfo? assetProjectInfor;
  bool? haveApartment;
  bool? haveLandForRent;
  bool? haveGround;

  DuAnModel({
    this.haveApartment,
    this.apartmentNote,
    this.haveLandForRent,
    this.landForRentNote,
    this.typeService,
    this.haveGround,
    this.groundNote,
    this.assetProjectInfor,
    required super.assetId,
    required super.assetCode,
    required super.riskDetails,
    required super.legalInformations,
  }) {
    //Gán tính thanh khoản => trung bình
    liquidity ??= '2';
    //Thông tin tranh chấp => không
    if (disputeInfor?.isEmpty ?? true) {
      disputeInfor = '0';
    }
  }

  factory DuAnModel.fromJson(Map<String, dynamic> json) {
    final result = _$DuAnModelFromJson(
        Serializer.moveToExtraDataFromRoot(json, topLevelFields));
//Gán tính thanh khoản => trung bình
    result.liquidity ??= '2';
    //Thông tin tranh chấp => không
    if (result.disputeInfor?.isEmpty ?? true) {
      result.disputeInfor = '0';
    }
    return result;
  }

  Map<String, dynamic> toJson() =>
      Serializer.moveFromExtraDataToRoot(_$DuAnModelToJson(this));

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
    'haveApartment',
    'apartmentNote',
    'haveLandForRent',
    'landForRentNote',
    'typeService',
    'haveGround',
    'groundNote',
    'assetProjectInfor',
  ];
}

@JsonSerializable()
class AssetProjectInfo {
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? id;
  int? assetProjectInforId;
  String? assetId;
  String? provinceCode;
  String? provinceName;
  String? districtCode;
  String? districtName;
  String? wardCode;
  String? wardName;
  String? appraisalLocation;
  double? areaWidth;
  String? currentAsset;
  String? description;
  @JsonKey(defaultValue: [])
  List<LandingPurposeModel> assetLandUsingPurposes;
  @JsonKey(defaultValue: [])
  List<TreeModel> assetTrees;
  @JsonKey(defaultValue: [])
  List<ConstructionModel> constructions;
  @JsonKey(defaultValue: [])
  List<DetailDescribeModel> detailDescribes;

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool haveLandingPurpose = false;

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool haveCayTrong = false;

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool haveCTXD = false;

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool haveMoTaChiTiet = false;

  AssetProjectInfo({
    this.id,
    this.assetProjectInforId,
    this.assetId,
    this.provinceCode,
    this.provinceName,
    this.districtCode,
    this.districtName,
    this.wardCode,
    this.wardName,
    this.appraisalLocation,
    this.areaWidth,
    this.currentAsset,
    this.description,
    required this.assetLandUsingPurposes,
    required this.assetTrees,
    required this.constructions,
    required this.detailDescribes,
  }) {
    id ??= Uuid().generateV4();
    haveLandingPurpose = assetLandUsingPurposes.isNotEmpty;
    haveCayTrong = assetTrees.isNotEmpty;
    haveCTXD = constructions.isNotEmpty;
    haveMoTaChiTiet = detailDescribes.isNotEmpty;
  }

  factory AssetProjectInfo.fromJson(Map<String, dynamic> json) =>
      _$AssetProjectInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AssetProjectInfoToJson(this);

  AssetProjectInfo copyWith({
    String? id,
    int? assetProjectInforId,
    String? assetId,
    String? provinceCode,
    String? provinceName,
    String? districtCode,
    String? districtName,
    String? wardCode,
    String? wardName,
    String? appraisalLocation,
    double? areaWidth,
    String? currentAsset,
    String? description,
    List<LandingPurposeModel>? assetLandUsingPurposes,
    List<TreeModel>? assetTrees,
    List<ConstructionModel>? constructions,
    List<DetailDescribeModel>? detailDescribes,
    bool? haveLandingPurpose,
  }) {
    return AssetProjectInfo(
      id: id ?? this.id,
      assetProjectInforId: assetProjectInforId ?? this.assetProjectInforId,
      assetId: assetId ?? this.assetId,
      provinceCode: provinceCode ?? this.provinceCode,
      provinceName: provinceName ?? this.provinceName,
      districtCode: districtCode ?? this.districtCode,
      districtName: districtName ?? this.districtName,
      wardCode: wardCode ?? this.wardCode,
      wardName: wardName ?? this.wardName,
      appraisalLocation: appraisalLocation ?? this.appraisalLocation,
      areaWidth: areaWidth ?? this.areaWidth,
      currentAsset: currentAsset ?? this.currentAsset,
      description: description ?? this.description,
      assetLandUsingPurposes:
          assetLandUsingPurposes ?? this.assetLandUsingPurposes,
      assetTrees: assetTrees ?? this.assetTrees,
      constructions: constructions ?? this.constructions,
      detailDescribes: detailDescribes ?? this.detailDescribes,
    );
  }
}
