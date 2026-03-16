// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmissionDetailModel _$SubmissionDetailModelFromJson(
        Map<String, dynamic> json) =>
    SubmissionDetailModel(
      tablePP: (json['tablePP'] as List<dynamic>?)
              ?.map((e) => AssetMethodModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      tableKQDat: (json['tableKQDat'] as List<dynamic>?)
              ?.map((e) => KQDatModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      tableKQCTXD: (json['tableKQCTXD'] as List<dynamic>?)
              ?.map((e) => KQCTXDModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      tableKQ: (json['tableKQ'] as List<dynamic>?)
              ?.map((e) => KQDatModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      tableTong: json['tableTong'] == null
          ? null
          : TongModel.fromJson(json['tableTong'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubmissionDetailModelToJson(
        SubmissionDetailModel instance) =>
    <String, dynamic>{
      'tablePP': instance.tablePP,
      'tableKQDat': instance.tableKQDat,
      'tableKQCTXD': instance.tableKQCTXD,
      'tableKQ': instance.tableKQ,
      'tableTong': instance.tableTong,
    };

AssetMethodModel _$AssetMethodModelFromJson(Map<String, dynamic> json) =>
    AssetMethodModel(
      assetValuationMethodId: (json['assetValuationMethodId'] as num?)?.toInt(),
      appraisalFileId: json['appraisalFileId'] as String?,
      assetId: json['assetId'] as String?,
      assetName: json['assetName'] as String?,
      assetChildId: (json['assetChildId'] as num?)?.toInt(),
      assetChildName: json['assetChildName'] as String?,
      assetGrandChildId: (json['assetGrandChildId'] as num?)?.toInt(),
      assetGrandChildName: json['assetGrandChildName'] as String?,
      assetLevelTwoId: (json['assetLevelTwoId'] as num?)?.toInt(),
      valuationMethodDetails: (json['valuationMethodDetails'] as List<dynamic>?)
              ?.map((e) => MethodItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AssetMethodModelToJson(AssetMethodModel instance) =>
    <String, dynamic>{
      'assetValuationMethodId': instance.assetValuationMethodId,
      'appraisalFileId': instance.appraisalFileId,
      'assetId': instance.assetId,
      'assetName': instance.assetName,
      'assetChildId': instance.assetChildId,
      'assetChildName': instance.assetChildName,
      'assetGrandChildId': instance.assetGrandChildId,
      'assetGrandChildName': instance.assetGrandChildName,
      'assetLevelTwoId': instance.assetLevelTwoId,
      'valuationMethodDetails': instance.valuationMethodDetails,
    };

MethodItemModel _$MethodItemModelFromJson(Map<String, dynamic> json) =>
    MethodItemModel(
      valuationMethodDetailId:
          (json['valuationMethodDetailId'] as num?)?.toInt(),
      assetValuationMethodId: (json['assetValuationMethodId'] as num?)?.toInt(),
      valuationMethodId: (json['valuationMethodId'] as num?)?.toInt(),
      unitPriceInPlan: (json['unitPriceInPlan'] as num?)?.toInt(),
      unitPriceUnPlan: (json['unitPriceUnPlan'] as num?)?.toInt(),
      unitPrice: (json['unitPrice'] as num?)?.toDouble(),
      isCurrent: json['isCurrent'] as bool?,
      appendixAssetValues: json['appendixAssetValues'] as List<dynamic>? ?? [],
      assetLandRentFlows: json['assetLandRentFlows'] as List<dynamic>? ?? [],
    );

Map<String, dynamic> _$MethodItemModelToJson(MethodItemModel instance) =>
    <String, dynamic>{
      'valuationMethodDetailId': instance.valuationMethodDetailId,
      'assetValuationMethodId': instance.assetValuationMethodId,
      'valuationMethodId': instance.valuationMethodId,
      'unitPriceInPlan': instance.unitPriceInPlan,
      'unitPriceUnPlan': instance.unitPriceUnPlan,
      'unitPrice': instance.unitPrice,
      'isCurrent': instance.isCurrent,
      'appendixAssetValues': instance.appendixAssetValues,
      'assetLandRentFlows': instance.assetLandRentFlows,
    };

KQDatModel _$KQDatModelFromJson(Map<String, dynamic> json) => KQDatModel(
      valuationResultLandEstateId:
          (json['valuationResultLandEstateId'] as num?)?.toInt(),
      appraisalFileId: json['appraisalFileId'] as String?,
      assetId: json['assetId'] as String?,
      assetChildId: (json['assetChildId'] as num?)?.toInt(),
      assetGrandChildId: (json['assetGrandChildId'] as num?)?.toInt(),
      name: json['name'] as String?,
      type: (json['type'] as num?)?.toInt(),
      totalArea: (json['totalArea'] as num?)?.toDouble(),
      totalAreaApprovaled: (json['totalAreaApprovaled'] as num?)?.toDouble(),
      unitPrice: (json['unitPrice'] as num?)?.toInt(),
      totalValue: (json['totalValue'] as num?)?.toInt(),
      unitPriceApprovaled: (json['unitPriceApprovaled'] as num?)?.toInt(),
      totalValueApprovaled: (json['totalValueApprovaled'] as num?)?.toInt(),
      realCommonMachine: (json['realCommonMachine'] as num?)?.toInt(),
      valuationResultWaterwayVehicleId:
          (json['valuationResultWaterwayVehicleId'] as num?)?.toInt(),
      valuationResultRoadVehicleId:
          (json['valuationResultRoadVehicleId'] as num?)?.toInt(),
      productLineName: json['productLineName'] as String?,
      isValuationResultProject: json['isValuationResultProject'] as bool?,
    );

Map<String, dynamic> _$KQDatModelToJson(KQDatModel instance) =>
    <String, dynamic>{
      'valuationResultLandEstateId': instance.valuationResultLandEstateId,
      'appraisalFileId': instance.appraisalFileId,
      'assetId': instance.assetId,
      'assetChildId': instance.assetChildId,
      'assetGrandChildId': instance.assetGrandChildId,
      'name': instance.name,
      'type': instance.type,
      'totalArea': instance.totalArea,
      'totalAreaApprovaled': instance.totalAreaApprovaled,
      'unitPrice': instance.unitPrice,
      'totalValue': instance.totalValue,
      'unitPriceApprovaled': instance.unitPriceApprovaled,
      'totalValueApprovaled': instance.totalValueApprovaled,
      'realCommonMachine': instance.realCommonMachine,
      'valuationResultWaterwayVehicleId':
          instance.valuationResultWaterwayVehicleId,
      'valuationResultRoadVehicleId': instance.valuationResultRoadVehicleId,
      'productLineName': instance.productLineName,
      'isValuationResultProject': instance.isValuationResultProject,
    };

TongModel _$TongModelFromJson(Map<String, dynamic> json) => TongModel(
      totalValueLandEstateId: (json['totalValueLandEstateId'] as num?)?.toInt(),
      appraisalFileId: json['appraisalFileId'] as String?,
      landValue: (json['landValue'] as num?)?.toInt(),
      constructionValue: (json['constructionValue'] as num?)?.toInt(),
      constructionReferValue: (json['constructionReferValue'] as num?)?.toInt(),
      constructionFutureValue:
          (json['constructionFutureValue'] as num?)?.toInt(),
      constructionFutureValueApprovaled:
          (json['constructionFutureValueApprovaled'] as num?)?.toInt(),
      totalValue: (json['totalValue'] as num?)?.toInt(),
      totalValueRounded: (json['totalValueRounded'] as num?)?.toInt(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$TongModelToJson(TongModel instance) => <String, dynamic>{
      'totalValueLandEstateId': instance.totalValueLandEstateId,
      'appraisalFileId': instance.appraisalFileId,
      'landValue': instance.landValue,
      'constructionValue': instance.constructionValue,
      'constructionReferValue': instance.constructionReferValue,
      'constructionFutureValue': instance.constructionFutureValue,
      'constructionFutureValueApprovaled':
          instance.constructionFutureValueApprovaled,
      'totalValue': instance.totalValue,
      'totalValueRounded': instance.totalValueRounded,
      'note': instance.note,
    };

KQCTXDModel _$KQCTXDModelFromJson(Map<String, dynamic> json) => KQCTXDModel(
      constructionId: (json['constructionId'] as num?)?.toInt(),
      assetLandInforId: (json['assetLandInforId'] as num?)?.toInt(),
      constructionTypeId: (json['constructionTypeId'] as num?)?.toInt(),
      constructionType: json['constructionType'] == null
          ? null
          : ConstructionType.fromJson(
              json['constructionType'] as Map<String, dynamic>),
      constructionNameId: (json['constructionNameId'] as num?)?.toInt(),
      constructionName: json['constructionName'] == null
          ? null
          : ConstructionName.fromJson(
              json['constructionName'] as Map<String, dynamic>),
      constructionArea: (json['constructionArea'] as num?)?.toDouble(),
      constructionLegalTypeId:
          (json['constructionLegalTypeId'] as num?)?.toInt(),
      floors: (json['floors'] as num?)?.toDouble(),
      baseFloors: (json['baseFloors'] as num?)?.toDouble(),
      furnitures: json['furnitures'] as String?,
      constructionYear: (json['constructionYear'] as num?)?.toInt(),
      repairYear: (json['repairYear'] as num?)?.toInt(),
      remainingQuality: (json['remainingQuality'] as num?)?.toDouble(),
      mdht: (json['mdht'] as num?)?.toDouble(),
      unitPrice: (json['unitPrice'] as num?)?.toInt(),
      totalValue: (json['totalValue'] as num?)?.toInt(),
      unitPriceApprovaled: (json['unitPriceApprovaled'] as num?)?.toInt(),
      totalValueApprovaled: (json['totalValueApprovaled'] as num?)?.toInt(),
    );

Map<String, dynamic> _$KQCTXDModelToJson(KQCTXDModel instance) =>
    <String, dynamic>{
      'constructionId': instance.constructionId,
      'assetLandInforId': instance.assetLandInforId,
      'constructionTypeId': instance.constructionTypeId,
      'constructionType': instance.constructionType,
      'constructionNameId': instance.constructionNameId,
      'constructionName': instance.constructionName,
      'constructionArea': instance.constructionArea,
      'constructionLegalTypeId': instance.constructionLegalTypeId,
      'floors': instance.floors,
      'baseFloors': instance.baseFloors,
      'furnitures': instance.furnitures,
      'constructionYear': instance.constructionYear,
      'repairYear': instance.repairYear,
      'remainingQuality': instance.remainingQuality,
      'mdht': instance.mdht,
      'unitPrice': instance.unitPrice,
      'totalValue': instance.totalValue,
      'unitPriceApprovaled': instance.unitPriceApprovaled,
      'totalValueApprovaled': instance.totalValueApprovaled,
    };
