// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:sba/src/models/assets/assets.dart';

part 'submission_detail_model.g.dart';

@JsonSerializable()
class SubmissionDetailModel {
  @JsonKey(defaultValue: [])
  List<AssetMethodModel> tablePP;
  @JsonKey(defaultValue: [])
  List<KQDatModel> tableKQDat;
  @JsonKey(defaultValue: [])
  List<KQCTXDModel> tableKQCTXD;
  @JsonKey(defaultValue: [])
  List<KQDatModel> tableKQ;
  TongModel? tableTong;
  SubmissionDetailModel({
    required this.tablePP,
    required this.tableKQDat,
    required this.tableKQCTXD,
    required this.tableKQ,
    this.tableTong,
  });
  factory SubmissionDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SubmissionDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubmissionDetailModelToJson(this);

  /// Tổng giá trị tài sản BDS
  int tongGiaTriTaiSanBDS([int level = 0]) {
    final result = tableKQCTXD.fold<int>(
          0,
          (previousValue, element) =>
              previousValue + (element.totalValueApprovaled ?? 0),
        ) +
        tableKQDat.fold<int>(
          0,
          (previousValue, element) =>
              previousValue + (element.totalValueApprovaled ?? 0),
        ) +
        (tableTong?.constructionFutureValueApprovaled ?? 0);

    return result;
  }

  /// Tổng giá trị tài sản du toan
  int tongGiaTriTaiSanDuToan([int level = 0]) {
    final result = tableKQCTXD.fold<int>(
          0,
          (previousValue, element) =>
              previousValue + (element.totalValueApprovaled ?? 0),
        ) +
        tableKQDat.fold<int>(
          0,
          (previousValue, element) =>
              previousValue + (element.totalValueApprovaled ?? 0),
        ) +
        (tableTong?.constructionFutureValueApprovaled ?? 0);

    return result;
  }

  /// Tổng giá trị tài sản PTDB với DT
  int tongGiaTriTaiSanDBDT([int level = 0]) {
    final result = tableKQDat.fold(
      0,
      (previousValue, element) =>
          previousValue + (element.totalValueApprovaled ?? 0),
    );

    return result;
  }

  /// Tổng giá trị tài sản CHCC
  int tongGiaTriTaiSanCHCC([int level = 0]) {
    final result = tableKQ.fold(
      0,
      (previousValue, element) =>
          previousValue + (element.totalValueApprovaled ?? 0),
    );

    return result;
  }

  /// Tổng giá trị tài sản MMTB
  int tongGiaTriTaiSanMMTB([int level = 0]) {
    final result = tableKQ.fold(
      0,
      (previousValue, element) =>
          previousValue + (element.totalValueApprovaled ?? 0),
    );

    return result;
  }

  /// Tổng giá trị tài sản Du An
  int tongGiaTriTaiSanDuAn([int level = 0]) {
    final result = tableKQCTXD.fold<int>(
          0,
          (previousValue, element) =>
              previousValue + (element.totalValueApprovaled ?? 0),
        ) +
        tableKQDat.fold<int>(
          0,
          (previousValue, element) =>
              previousValue + (element.totalValueApprovaled ?? 0),
        ) +
        (tableTong?.constructionFutureValueApprovaled ?? 0);

    return result;
  }
}

@JsonSerializable()
class AssetMethodModel {
  int? assetValuationMethodId;
  String? appraisalFileId;
  String? assetId;
  String? assetName;
  int? assetChildId;
  String? assetChildName;
  int? assetGrandChildId;
  String? assetGrandChildName;
  int? assetLevelTwoId;
  @JsonKey(defaultValue: [])
  List<MethodItemModel> valuationMethodDetails;
  AssetMethodModel({
    this.assetValuationMethodId,
    this.appraisalFileId,
    this.assetId,
    this.assetName,
    this.assetChildId,
    this.assetChildName,
    this.assetGrandChildId,
    this.assetGrandChildName,
    this.assetLevelTwoId,
    required this.valuationMethodDetails,
  });

  factory AssetMethodModel.fromJson(Map<String, dynamic> json) =>
      _$AssetMethodModelFromJson(json);
  Map<String, dynamic> toJson() => _$AssetMethodModelToJson(this);
}

@JsonSerializable()
class MethodItemModel {
  int? valuationMethodDetailId;
  int? assetValuationMethodId;
  int? valuationMethodId;
  int? unitPriceInPlan;
  int? unitPriceUnPlan;
  double? unitPrice;
  bool? isCurrent;
  // ValuationMethod? valuationMethod;
  @JsonKey(defaultValue: [])
  List<dynamic> appendixAssetValues;
  @JsonKey(defaultValue: [])
  List<dynamic> assetLandRentFlows;

  MethodItemModel({
    this.valuationMethodDetailId,
    this.assetValuationMethodId,
    this.valuationMethodId,
    this.unitPriceInPlan,
    this.unitPriceUnPlan,
    this.unitPrice,
    this.isCurrent,
    required this.appendixAssetValues,
    required this.assetLandRentFlows,
  });

  factory MethodItemModel.fromJson(Map<String, dynamic> json) =>
      _$MethodItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$MethodItemModelToJson(this);
}

@JsonSerializable()
class KQDatModel extends Equatable {
  int? valuationResultLandEstateId;
  String? appraisalFileId;
  String? assetId;
  int? assetChildId;
  int? assetGrandChildId;
  String? name;
  int? type;
  double? totalArea;
  double? totalAreaApprovaled;
  int? unitPrice;
  int? totalValue;
  int? unitPriceApprovaled;
  int? totalValueApprovaled;
  int? realCommonMachine;
  int? valuationResultWaterwayVehicleId;
  int? valuationResultRoadVehicleId;
  String? productLineName;
  bool? isValuationResultProject;
  KQDatModel({
    this.valuationResultLandEstateId,
    this.appraisalFileId,
    this.assetId,
    this.assetChildId,
    this.assetGrandChildId,
    this.name,
    this.type,
    this.totalArea,
    this.totalAreaApprovaled,
    this.unitPrice,
    this.totalValue,
    this.unitPriceApprovaled,
    this.totalValueApprovaled,
    this.realCommonMachine,
    this.valuationResultWaterwayVehicleId,
    this.valuationResultRoadVehicleId,
    this.productLineName,
    this.isValuationResultProject,
  });

  String get typeString => switch (type) {
        1 => 'PHQH',
        2 => 'KPHQH',
        _ => '',
      };

  factory KQDatModel.fromJson(Map<String, dynamic> json) =>
      _$KQDatModelFromJson(json);
  Map<String, dynamic> toJson() => _$KQDatModelToJson(this);

  @override
  List<Object?> get props => [
        valuationResultLandEstateId,
        appraisalFileId,
        assetId,
        assetChildId,
        assetGrandChildId,
        name,
        type,
        totalArea,
        unitPrice,
        totalValue,
        totalValueApprovaled,
        unitPriceApprovaled,
        realCommonMachine,
      ];

  KQDatModel copyWith({
    int? valuationResultLandEstateId,
    String? appraisalFileId,
    String? assetId,
    int? assetChildId,
    int? assetGrandChildId,
    String? name,
    int? type,
    double? totalArea,
    int? unitPrice,
    int? totalValue,
    int? unitPriceApprovaled,
    int? totalValueApprovaled,
    int? realCommonMachine,
  }) {
    return KQDatModel(
      valuationResultLandEstateId:
          valuationResultLandEstateId ?? this.valuationResultLandEstateId,
      appraisalFileId: appraisalFileId ?? this.appraisalFileId,
      assetId: assetId ?? this.assetId,
      assetChildId: assetChildId ?? this.assetChildId,
      assetGrandChildId: assetGrandChildId ?? this.assetGrandChildId,
      name: name ?? this.name,
      type: type ?? this.type,
      totalArea: totalArea ?? this.totalArea,
      unitPrice: unitPrice ?? this.unitPrice,
      totalValue: totalValue ?? this.totalValue,
      unitPriceApprovaled: unitPriceApprovaled ?? this.unitPriceApprovaled,
      totalValueApprovaled: totalValueApprovaled ?? this.totalValueApprovaled,
      realCommonMachine: realCommonMachine ?? this.realCommonMachine,
    );
  }
}

@JsonSerializable()
class TongModel {
  int? totalValueLandEstateId;
  String? appraisalFileId;
  int? landValue;
  int? constructionValue;
  int? constructionReferValue;
  int? constructionFutureValue;
  int? constructionFutureValueApprovaled;
  int? totalValue;
  int? totalValueRounded;
  String? note;
  TongModel({
    this.totalValueLandEstateId,
    this.appraisalFileId,
    this.landValue,
    this.constructionValue,
    this.constructionReferValue,
    this.constructionFutureValue,
    this.constructionFutureValueApprovaled,
    this.totalValue,
    this.totalValueRounded,
    this.note,
  });

  factory TongModel.fromJson(Map<String, dynamic> json) =>
      _$TongModelFromJson(json);
  Map<String, dynamic> toJson() => _$TongModelToJson(this);
}

@JsonSerializable()
class KQCTXDModel {
  int? constructionId;
  int? assetLandInforId;
  int? constructionTypeId;
  ConstructionType? constructionType;
  int? constructionNameId;
  ConstructionName? constructionName;
  double? constructionArea;
  int? constructionLegalTypeId;
  double? floors;
  double? baseFloors;
  String? furnitures;
  int? constructionYear;
  int? repairYear;
  double? remainingQuality;
  double? mdht;
  int? unitPrice;
  int? totalValue;
  int? unitPriceApprovaled;
  int? totalValueApprovaled;
  KQCTXDModel({
    this.constructionId,
    this.assetLandInforId,
    this.constructionTypeId,
    this.constructionType,
    this.constructionNameId,
    this.constructionName,
    this.constructionArea,
    this.constructionLegalTypeId,
    this.floors,
    this.baseFloors,
    this.furnitures,
    this.constructionYear,
    this.repairYear,
    this.remainingQuality,
    this.mdht,
    this.unitPrice,
    this.totalValue,
    this.unitPriceApprovaled,
    this.totalValueApprovaled,
  });

  factory KQCTXDModel.fromJson(Map<String, dynamic> json) =>
      _$KQCTXDModelFromJson(json);
  Map<String, dynamic> toJson() => _$KQCTXDModelToJson(this);
}
