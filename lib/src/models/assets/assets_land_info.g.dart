// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_land_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetLandInfo _$AssetLandInfoFromJson(Map<String, dynamic> json) =>
    AssetLandInfo(
      assetId: json['assetId'] as String?,
      assetLandInforId: json['assetLandInforId'] as int?,
      landPlotNumber: json['landPlotNumber'] as String?,
      mapSheetNumber: json['mapSheetNumber'] as String?,
      realAddressDetail: json['realAddressDetail'] as String?,
      realAddressStreet: json['realAddressStreet'] as String?,
      realAddressWard: json['realAddressWard'] as String?,
      realAddressDistrict: json['realAddressDistrict'] as String?,
      realAddressProvince: json['realAddressProvince'] as String?,
      legalAddressDetail: json['legalAddressDetail'] as String?,
      legalAddressStreet: json['legalAddressStreet'] as String?,
      legalAddressWard: json['legalAddressWard'] as String?,
      legalAddressDistrict: json['legalAddressDistrict'] as String?,
      legalAddressProvince: json['legalAddressProvince'] as String?,
      roadInPriceRange: json['roadInPriceRange'] as int?,
      distanceToMainRoad: (json['distanceToMainRoad'] as num?)?.toDouble(),
      roadContiguousTypeId: json['roadContiguousTypeId'] as int?,
      positionId: json['positionId'] as int?,
      minWidthToMainRoad: (json['minWidthToMainRoad'] as num?)?.toDouble(),
      maxWidthToMainRoad: (json['maxWidthToMainRoad'] as num?)?.toDouble(),
      note: json['note'] as String?,
      zoneId: json['zoneId'] as int?,
      positionInPriceRangeId: json['positionInPriceRangeId'] as int?,
      legalMainDirection: json['legalMainDirection'] as String?,
      legalShape: json['legalShape'] as String?,
      legalNumberOfFacade: json['legalNumberOfFacade'] as int?,
      legalFacadeLength: (json['legalFacadeLength'] as num?)?.toDouble(),
      legalLandLength: (json['legalLandLength'] as num?)?.toDouble(),
      legalAreaWidth: (json['legalAreaWidth'] as num?)?.toDouble(),
      legalAreaInPlan: (json['legalAreaInPlan'] as num?)?.toDouble() ?? 0,
      legalAreaUnPlan: (json['legalAreaUnPlan'] as num?)?.toDouble(),
      legalPrivateArea: (json['legalPrivateArea'] as num?)?.toDouble(),
      legalCommonArea: (json['legalCommonArea'] as num?)?.toDouble(),
      realMainDirection: json['realMainDirection'] as String?,
      realShape: json['realShape'] as String?,
      realNumberOfFacade: json['realNumberOfFacade'] as int?,
      realFacadeLength: (json['realFacadeLength'] as num?)?.toDouble(),
      realLandLength: (json['realLandLength'] as num?)?.toDouble(),
      realAreaWidth: (json['realAreaWidth'] as num?)?.toDouble(),
      realAreaInPlan: (json['realAreaInPlan'] as num?)?.toDouble() ?? 0,
      realAreaUnPlan: (json['realAreaUnPlan'] as num?)?.toDouble(),
      realPrivateArea: (json['realPrivateArea'] as num?)?.toDouble(),
      realCommonArea: (json['realCommonArea'] as num?)?.toDouble(),
      realCurrentPrivateUsing: json['realCurrentPrivateUsing'] as String?,
      assetLandUsingPurposes: (json['assetLandUsingPurposes'] as List<dynamic>?)
              ?.map(LandingPurposeModel.fromJson)
              .toList() ??
          [],
      constructions: (json['constructions'] as List<dynamic>?)
              ?.map(ConstructionModel.fromJson)
              .toList() ??
          [],
      assetTrees: (json['assetTrees'] as List<dynamic>?)
              ?.map(TreeModel.fromJson)
              .toList() ??
          [],
      contructionFutureText: json['contructionFutureText'] as String?,
      totalArea: (json['totalArea'] as num?)?.toDouble(),
      buildingDensity: (json['buildingDensity'] as num?)?.toDouble(),
      coeffcientsUsed: (json['coeffcientsUsed'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      totalApartments: (json['totalApartments'] as num?)?.toDouble(),
      numOfFloors: (json['numOfFloors'] as num?)?.toDouble(),
      underTankArea: (json['underTankArea'] as num?)?.toDouble(),
      wasteTankArea: (json['wasteTankArea'] as num?)?.toDouble(),
      numOfUnderFloors: (json['numOfUnderFloors'] as num?)?.toDouble(),
      basementFloor: json['basementFloor'] as String?,
      totalFloorArea: (json['totalFloorArea'] as num?)?.toDouble(),
      depth: (json['depth'] as num?)?.toDouble(),
      constructionFloor: json['constructionFloor'] as String?,
      constructionArea: (json['constructionArea'] as num?)?.toDouble(),
      turnPart: json['turnPart'] as String?,
      solePart: json['solePart'] as String?,
      towerPart: json['towerPart'] as String?,
      constructionTitle: json['constructionTitle'] as String?,
      structuralSolution: json['structuralSolution'] as String?,
      architectualSolution: json['architectualSolution'] as String?,
      systemEngineering: json['systemEngineering'] as String?,
      systemTraffic: json['systemTraffic'] as String?,
      interior: json['interior'] as String?,
      estimateComment: json['estimateComment'] as String?,
      constructionChecklists: (json['constructionChecklists'] as List<dynamic>?)
              ?.map((e) =>
                  ConstructionCheckList.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      constructionFutureInfors:
          (json['constructionFutureInfors'] as List<dynamic>?)
                  ?.map(ConstructionFutureInfo.fromJson)
                  .toList() ??
              [],
      isConsolidation: json['isConsolidation'] as bool? ?? false,
      isConsolidationPurpose: json['isConsolidationPurpose'] as bool? ?? false,
      orderBy: json['orderBy'] as int?,
      legalAreaNotConsiderValue:
          (json['legalAreaNotConsiderValue'] as num?)?.toDouble(),
      realAreaNotConsiderValue:
          (json['realAreaNotConsiderValue'] as num?)?.toDouble(),
      legalCurrentPrivateUsing: json['legalCurrentPrivateUsing'] as String?,
      legalLandLengthDetail: json['legalLandLengthDetail'] as String?,
      realLandLengthDetail: json['realLandLengthDetail'] as String?,
    );

Map<String, dynamic> _$AssetLandInfoToJson(AssetLandInfo instance) =>
    <String, dynamic>{
      'assetId': instance.assetId,
      'assetLandInforId': instance.assetLandInforId,
      'landPlotNumber': instance.landPlotNumber,
      'mapSheetNumber': instance.mapSheetNumber,
      'realAddressDetail': instance.realAddressDetail,
      'realAddressStreet': instance.realAddressStreet,
      'realAddressWard': instance.realAddressWard,
      'realAddressDistrict': instance.realAddressDistrict,
      'realAddressProvince': instance.realAddressProvince,
      'legalAddressDetail': instance.legalAddressDetail,
      'legalAddressStreet': instance.legalAddressStreet,
      'legalAddressWard': instance.legalAddressWard,
      'legalAddressDistrict': instance.legalAddressDistrict,
      'legalAddressProvince': instance.legalAddressProvince,
      'roadInPriceRange': instance.roadInPriceRange,
      'distanceToMainRoad': instance.distanceToMainRoad,
      'roadContiguousTypeId': instance.roadContiguousTypeId,
      'positionId': instance.positionId,
      'minWidthToMainRoad': instance.minWidthToMainRoad,
      'maxWidthToMainRoad': instance.maxWidthToMainRoad,
      'note': instance.note,
      'zoneId': instance.zoneId,
      'positionInPriceRangeId': instance.positionInPriceRangeId,
      'legalMainDirection': instance.legalMainDirection,
      'legalShape': instance.legalShape,
      'legalNumberOfFacade': instance.legalNumberOfFacade,
      'legalFacadeLength': instance.legalFacadeLength,
      'legalLandLength': instance.legalLandLength,
      'legalLandLengthDetail': instance.legalLandLengthDetail,
      'legalAreaWidth': instance.legalAreaWidth,
      'legalAreaInPlan': instance.legalAreaInPlan,
      'legalAreaUnPlan': instance.legalAreaUnPlan,
      'legalPrivateArea': instance.legalPrivateArea,
      'legalCommonArea': instance.legalCommonArea,
      'legalAreaNotConsiderValue': instance.legalAreaNotConsiderValue,
      'legalCurrentPrivateUsing': instance.legalCurrentPrivateUsing,
      'realMainDirection': instance.realMainDirection,
      'realShape': instance.realShape,
      'realNumberOfFacade': instance.realNumberOfFacade,
      'realFacadeLength': instance.realFacadeLength,
      'realLandLength': instance.realLandLength,
      'realAreaWidth': instance.realAreaWidth,
      'realAreaInPlan': instance.realAreaInPlan,
      'realAreaUnPlan': instance.realAreaUnPlan,
      'realAreaNotConsiderValue': instance.realAreaNotConsiderValue,
      'realPrivateArea': instance.realPrivateArea,
      'realCommonArea': instance.realCommonArea,
      'realCurrentPrivateUsing': instance.realCurrentPrivateUsing,
      'realLandLengthDetail': instance.realLandLengthDetail,
      'assetLandUsingPurposes': instance.assetLandUsingPurposes,
      'constructions': instance.constructions,
      'assetTrees': instance.assetTrees,
      'isConsolidation': instance.isConsolidation,
      'isConsolidationPurpose': instance.isConsolidationPurpose,
      'contructionFutureText': instance.contructionFutureText,
      'totalArea': instance.totalArea,
      'buildingDensity': instance.buildingDensity,
      'coeffcientsUsed': instance.coeffcientsUsed,
      'height': instance.height,
      'totalApartments': instance.totalApartments,
      'numOfFloors': instance.numOfFloors,
      'underTankArea': instance.underTankArea,
      'wasteTankArea': instance.wasteTankArea,
      'numOfUnderFloors': instance.numOfUnderFloors,
      'basementFloor': instance.basementFloor,
      'totalFloorArea': instance.totalFloorArea,
      'depth': instance.depth,
      'constructionFloor': instance.constructionFloor,
      'constructionArea': instance.constructionArea,
      'turnPart': instance.turnPart,
      'solePart': instance.solePart,
      'towerPart': instance.towerPart,
      'constructionTitle': instance.constructionTitle,
      'structuralSolution': instance.structuralSolution,
      'architectualSolution': instance.architectualSolution,
      'systemEngineering': instance.systemEngineering,
      'systemTraffic': instance.systemTraffic,
      'interior': instance.interior,
      'estimateComment': instance.estimateComment,
      'constructionChecklists': instance.constructionChecklists,
      'constructionFutureInfors': instance.constructionFutureInfors,
      'orderBy': instance.orderBy,
    };

ConstructionCheckList _$ConstructionCheckListFromJson(
        Map<String, dynamic> json) =>
    ConstructionCheckList(
      id: json['id'] as String?,
      constructionFutureCheckListId:
          json['constructionFutureCheckListId'] as int?,
      name: json['name'] as String?,
      groundFloorArea: (json['groundFloorArea'] as num?)?.toDouble(),
      totalFloorArea: (json['totalFloorArea'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      numOfFloor: (json['numOfFloor'] as num?)?.toDouble(),
      length: (json['length'] as num?)?.toDouble(),
      depth: (json['depth'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ConstructionCheckListToJson(
        ConstructionCheckList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'constructionFutureCheckListId': instance.constructionFutureCheckListId,
      'name': instance.name,
      'groundFloorArea': instance.groundFloorArea,
      'totalFloorArea': instance.totalFloorArea,
      'height': instance.height,
      'numOfFloor': instance.numOfFloor,
      'length': instance.length,
      'depth': instance.depth,
    };

ConstructionFutureInfo _$ConstructionFutureInfoFromJson(
        Map<String, dynamic> json) =>
    ConstructionFutureInfo(
      id: json['id'] as String?,
      contructionFutureInforId: json['contructionFutureInforId'] as int?,
      name: json['name'] as String?,
      basicDesign: json['basicDesign'] as String?,
      decision: json['decision'] as String?,
    );

Map<String, dynamic> _$ConstructionFutureInfoToJson(
        ConstructionFutureInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contructionFutureInforId': instance.contructionFutureInforId,
      'name': instance.name,
      'basicDesign': instance.basicDesign,
      'decision': instance.decision,
    };
