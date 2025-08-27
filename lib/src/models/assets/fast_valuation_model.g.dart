// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fast_valuation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FastValuationModel _$FastValuationModelFromJson(Map<String, dynamic> json) =>
    FastValuationModel(
      id: json['id'] as String?,
      assetId: json['assetId'] as String?,
      assetCode: json['assetCode'] as String?,
      dataSourceName: json['dataSourceName'],
      infoSourceName: json['infoSourceName'] as String?,
      contact: json['contact'] as String?,
      transactionStatus: json['transactionStatus'] as String?,
      transactionTime: json['transactionTime'] as String?,
      appraisalTime: json['appraisalTime'] == null
          ? null
          : DateTime.parse(json['appraisalTime'] as String),
      addressProvince: json['addressProvince'] as String?,
      addressDistrict: json['addressDistrict'] as String?,
      addressWard: json['addressWard'] as String?,
      addressStreet: json['addressStreet'] as String?,
      addressDetail: json['addressDetail'] as String?,
      address: json['address'] as String?,
      positionName: json['positionName'] as String?,
      mapSheetNumber: json['mapSheetNumber'] as String?,
      landPlotNumber: json['landPlotNumber'] as String?,
      latitude: const SafeDoubleFormatConverter().fromJson(json['latitude']),
      longitude: const SafeDoubleFormatConverter().fromJson(json['longitude']),
      assetImage: json['assetImage'] as String?,
      areaWidth: const SafeDoubleFormatConverter().fromJson(json['areaWidth']),
      landLength:
          const SafeDoubleFormatConverter().fromJson(json['landLength']),
      areaInplan:
          const SafeDoubleFormatConverter().fromJson(json['areaInplan']),
      areaUnplan:
          const SafeDoubleFormatConverter().fromJson(json['areaUnplan']),
      facadeLength:
          const SafeDoubleFormatConverter().fromJson(json['facadeLength']),
      numberOfFacade: json['numberOfFacade'] as int?,
      shape: json['shape'] as String?,
      widthToMainRoad:
          const SafeDoubleFormatConverter().fromJson(json['widthToMainRoad']),
      distanceToMainRoad: const SafeDoubleFormatConverter()
          .fromJson(json['distanceToMainRoad']),
      businessAdvantage: json['businessAdvantage'] as String?,
      legal: json['legal'] as String?,
      traffic: json['traffic'] as String?,
      security: json['security'] as String?,
      infrastructure: json['infrastructure'] as String?,
      usingPurposeName: json['usingPurposeName'] as String?,
      projectName: json['projectName'] as String?,
      note: json['note'] as String?,
      transactionPrice:
          const SafeDoubleFormatConverter().fromJson(json['transactionPrice']),
      estimatePrice:
          const SafeDoubleFormatConverter().fromJson(json['estimatePrice']),
      totalFloorArea:
          const SafeDoubleFormatConverter().fromJson(json['totalFloorArea']),
      constructionUnitPrice: const SafeDoubleFormatConverter()
          .fromJson(json['constructionUnitPrice']),
      remainQuality:
          const SafeDoubleFormatConverter().fromJson(json['remainQuality']),
      constructionPrice:
          const SafeDoubleFormatConverter().fromJson(json['constructionPrice']),
      landUnitPrice:
          const SafeDoubleFormatConverter().fromJson(json['landUnitPrice']),
      landPrice: const SafeDoubleFormatConverter().fromJson(json['landPrice']),
      rentDayPrice: json['rentDayPrice'],
      rentYearPrice: json['rentYearPrice'],
      estimateRentYearPrice: json['estimateRentYearPrice'],
      rentYearUnitPrice: json['rentYearUnitPrice'],
      totalValue:
          const SafeDoubleFormatConverter().fromJson(json['totalValue']),
      coordinate: json['coordinate'] == null
          ? null
          : Coordinate.fromJson(json['coordinate'] as Map<String, dynamic>),
      whoCreate: json['whoCreate'] as String?,
      dateCreate: json['dateCreate'] == null
          ? null
          : DateTime.parse(json['dateCreate'] as String),
      approved: json['approved'] as bool?,
      sentiment: json['sentiment'],
      sentimentApproved: json['sentimentApproved'],
      storedTypeId: json['storedTypeId'] as int?,
      storedType: json['storedType'] as String?,
      customerName: json['customerName'] as String?,
      customerIdentity: json['customerIdentity'] as String?,
      codeBook: json['codeBook'],
      isFastValuation: json['isFastValuation'],
      valuationIds: (json['valuationIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      valuations: (json['valuations'] as List<dynamic>?)
              ?.map(
                  (e) => FastValuationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      valuationHistories: json['valuationHistories'],
      constructions: (json['constructions'] as List<dynamic>?)
              ?.map((e) =>
                  FastValueConstruction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      provinces: json['provinces'] == null
          ? null
          : Provinces.fromJson(json['provinces'] as Map<String, dynamic>),
      districts: json['districts'] == null
          ? null
          : Districts.fromJson(json['districts'] as Map<String, dynamic>),
      wards: json['wards'] == null
          ? null
          : Wards.fromJson(json['wards'] as Map<String, dynamic>),
      roadContiguousTypeId: json['roadContiguousTypeId'],
      roadInPriceRange: json['roadInPriceRange'],
      description: json['description'],
      priceInPlan:
          const SafeDoubleFormatConverter().fromJson(json['priceInPlan']),
      roadInPriceRangeId: json['roadInPriceRangeId'],
      structure: json['structure'],
      frontage: json['frontage'],
      addressStreetFrom: json['addressStreetFrom'],
      addressStreetTo: json['addressStreetTo'],
      unPlanPrice:
          const SafeDoubleFormatConverter().fromJson(json['unPlanPrice']),
      geographicDescription: json['geographicDescription'],
      roadContiguousTypeName: json['roadContiguousTypeName'],
      optimizePrice:
          const SafeDoubleFormatConverter().fromJson(json['optimizePrice']),
      radius: const SafeDoubleFormatConverter().fromJson(json['radius']),
      optimizePrices: json['optimizePrices'],
      provinceId: json['provinceId'] as String?,
      districtId: json['districtId'] as String?,
      wardId: json['wardId'] as String?,
      positionId: json['positionId'] as int?,
      usingPurposeId: json['usingPurposeId'] as int?,
      dataSourceId: json['dataSourceId'] as int?,
      infoSourceId: json['infoSourceId'] as int?,
      areaUnPlanPrice:
          const SafeDoubleFormatConverter().fromJson(json['areaUnPlanPrice']),
      areaInPlanPrice:
          const SafeDoubleFormatConverter().fromJson(json['areaInPlanPrice']),
      areaInPlanValue:
          const SafeDoubleFormatConverter().fromJson(json['areaInPlanValue']),
      logs:
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
    );

Map<String, dynamic> _$FastValuationModelToJson(FastValuationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'assetId': instance.assetId,
      'assetCode': instance.assetCode,
      'dataSourceName': instance.dataSourceName,
      'infoSourceName': instance.infoSourceName,
      'contact': instance.contact,
      'transactionStatus': instance.transactionStatus,
      'transactionTime': instance.transactionTime,
      'appraisalTime': instance.appraisalTime?.toIso8601String(),
      'addressProvince': instance.addressProvince,
      'addressDistrict': instance.addressDistrict,
      'addressWard': instance.addressWard,
      'addressStreet': instance.addressStreet,
      'addressDetail': instance.addressDetail,
      'address': instance.address,
      'positionName': instance.positionName,
      'mapSheetNumber': instance.mapSheetNumber,
      'landPlotNumber': instance.landPlotNumber,
      'latitude': const SafeDoubleFormatConverter().toJson(instance.latitude),
      'longitude': const SafeDoubleFormatConverter().toJson(instance.longitude),
      'assetImage': instance.assetImage,
      'areaWidth': const SafeDoubleFormatConverter().toJson(instance.areaWidth),
      'landLength':
          const SafeDoubleFormatConverter().toJson(instance.landLength),
      'areaInplan':
          const SafeDoubleFormatConverter().toJson(instance.areaInplan),
      'areaUnplan':
          const SafeDoubleFormatConverter().toJson(instance.areaUnplan),
      'facadeLength':
          const SafeDoubleFormatConverter().toJson(instance.facadeLength),
      'numberOfFacade': instance.numberOfFacade,
      'shape': instance.shape,
      'widthToMainRoad':
          const SafeDoubleFormatConverter().toJson(instance.widthToMainRoad),
      'distanceToMainRoad':
          const SafeDoubleFormatConverter().toJson(instance.distanceToMainRoad),
      'businessAdvantage': instance.businessAdvantage,
      'legal': instance.legal,
      'traffic': instance.traffic,
      'security': instance.security,
      'infrastructure': instance.infrastructure,
      'usingPurposeName': instance.usingPurposeName,
      'projectName': instance.projectName,
      'note': instance.note,
      'transactionPrice':
          const SafeDoubleFormatConverter().toJson(instance.transactionPrice),
      'estimatePrice':
          const SafeDoubleFormatConverter().toJson(instance.estimatePrice),
      'totalFloorArea':
          const SafeDoubleFormatConverter().toJson(instance.totalFloorArea),
      'constructionUnitPrice': const SafeDoubleFormatConverter()
          .toJson(instance.constructionUnitPrice),
      'remainQuality':
          const SafeDoubleFormatConverter().toJson(instance.remainQuality),
      'constructionPrice':
          const SafeDoubleFormatConverter().toJson(instance.constructionPrice),
      'landUnitPrice':
          const SafeDoubleFormatConverter().toJson(instance.landUnitPrice),
      'landPrice': const SafeDoubleFormatConverter().toJson(instance.landPrice),
      'rentDayPrice': instance.rentDayPrice,
      'rentYearPrice': instance.rentYearPrice,
      'estimateRentYearPrice': instance.estimateRentYearPrice,
      'rentYearUnitPrice': instance.rentYearUnitPrice,
      'totalValue':
          const SafeDoubleFormatConverter().toJson(instance.totalValue),
      'coordinate': instance.coordinate,
      'whoCreate': instance.whoCreate,
      'dateCreate': instance.dateCreate?.toIso8601String(),
      'approved': instance.approved,
      'sentiment': instance.sentiment,
      'sentimentApproved': instance.sentimentApproved,
      'storedTypeId': instance.storedTypeId,
      'storedType': instance.storedType,
      'customerName': instance.customerName,
      'customerIdentity': instance.customerIdentity,
      'codeBook': instance.codeBook,
      'isFastValuation': instance.isFastValuation,
      'valuationIds': instance.valuationIds,
      'valuations': instance.valuations,
      'valuationHistories': instance.valuationHistories,
      'constructions': instance.constructions,
      'roadContiguousTypeId': instance.roadContiguousTypeId,
      'roadInPriceRangeId': instance.roadInPriceRangeId,
      'roadInPriceRange': instance.roadInPriceRange,
      'description': instance.description,
      'priceInPlan':
          const SafeDoubleFormatConverter().toJson(instance.priceInPlan),
      'structure': instance.structure,
      'frontage': instance.frontage,
      'addressStreetFrom': instance.addressStreetFrom,
      'addressStreetTo': instance.addressStreetTo,
      'unPlanPrice':
          const SafeDoubleFormatConverter().toJson(instance.unPlanPrice),
      'geographicDescription': instance.geographicDescription,
      'roadContiguousTypeName': instance.roadContiguousTypeName,
      'optimizePrice':
          const SafeDoubleFormatConverter().toJson(instance.optimizePrice),
      'radius': const SafeDoubleFormatConverter().toJson(instance.radius),
      'optimizePrices': instance.optimizePrices,
      'provinceId': instance.provinceId,
      'districtId': instance.districtId,
      'wardId': instance.wardId,
      'positionId': instance.positionId,
      'usingPurposeId': instance.usingPurposeId,
      'dataSourceId': instance.dataSourceId,
      'infoSourceId': instance.infoSourceId,
      'areaUnPlanPrice':
          const SafeDoubleFormatConverter().toJson(instance.areaUnPlanPrice),
      'areaInPlanPrice':
          const SafeDoubleFormatConverter().toJson(instance.areaInPlanPrice),
      'areaInPlanValue':
          const SafeDoubleFormatConverter().toJson(instance.areaInPlanValue),
      'logs': instance.logs,
    };

Coordinate _$CoordinateFromJson(Map<String, dynamic> json) => Coordinate(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CoordinateToJson(Coordinate instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

Provinces _$ProvincesFromJson(Map<String, dynamic> json) => Provinces(
      code: json['code'] as String?,
      name: json['name'] as String?,
      nameEn: json['nameEn'] as String?,
      fullName: json['fullName'] as String?,
      fullNameEn: json['fullNameEn'] as String?,
      codeName: json['codeName'] as String?,
      administrativeUnitId: json['administrativeUnitId'] as int?,
      administrativeRegionId: json['administrativeRegionId'] as int?,
    );

Map<String, dynamic> _$ProvincesToJson(Provinces instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'nameEn': instance.nameEn,
      'fullName': instance.fullName,
      'fullNameEn': instance.fullNameEn,
      'codeName': instance.codeName,
      'administrativeUnitId': instance.administrativeUnitId,
      'administrativeRegionId': instance.administrativeRegionId,
    };

Districts _$DistrictsFromJson(Map<String, dynamic> json) => Districts(
      code: json['code'] as String?,
      name: json['name'] as String?,
      nameEn: json['nameEn'] as String?,
      fullName: json['fullName'] as String?,
      fullNameEn: json['fullNameEn'] as String?,
      codeName: json['codeName'] as String?,
      provinceCode: json['provinceCode'] as String?,
      administrativeUnitId: json['administrativeUnitId'] as int?,
    );

Map<String, dynamic> _$DistrictsToJson(Districts instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'nameEn': instance.nameEn,
      'fullName': instance.fullName,
      'fullNameEn': instance.fullNameEn,
      'codeName': instance.codeName,
      'provinceCode': instance.provinceCode,
      'administrativeUnitId': instance.administrativeUnitId,
    };

Wards _$WardsFromJson(Map<String, dynamic> json) => Wards(
      code: json['code'] as String?,
      name: json['name'] as String?,
      nameEn: json['nameEn'] as String?,
      fullName: json['fullName'] as String?,
      fullNameEn: json['fullNameEn'] as String?,
      codeName: json['codeName'] as String?,
      districtCode: json['districtCode'] as String?,
      administrativeUnitId: json['administrativeUnitId'] as int?,
    );

Map<String, dynamic> _$WardsToJson(Wards instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'nameEn': instance.nameEn,
      'fullName': instance.fullName,
      'fullNameEn': instance.fullNameEn,
      'codeName': instance.codeName,
      'districtCode': instance.districtCode,
      'administrativeUnitId': instance.administrativeUnitId,
    };

OptimizePrices _$OptimizePricesFromJson(Map<String, dynamic> json) =>
    OptimizePrices(
      assetId: json['assetId'] as String? ?? '',
      optimizePrice: json['optimizePrice'] as int?,
    );

Map<String, dynamic> _$OptimizePricesToJson(OptimizePrices instance) =>
    <String, dynamic>{
      'assetId': instance.assetId,
      'optimizePrice': instance.optimizePrice,
    };

FastValueConstruction _$FastValueConstructionFromJson(
        Map<String, dynamic> json) =>
    FastValueConstruction(
      id: json['id'] as String?,
      assetId: json['assetId'] as String?,
      typeId: json['typeId'],
      nameId: json['nameId'] as String?,
      area: dynamicToDoubleConvert(json['area']),
      clcl: const StringToNumConverter().fromJson(json['clcl']),
      mdht: const StringToNumConverter().fromJson(json['mdht']),
      unitPrice: (json['unitPrice'] as num?)?.toDouble(),
      value: (json['value'] as num?)?.toDouble(),
      name: json['name'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$FastValueConstructionToJson(
        FastValueConstruction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'assetId': instance.assetId,
      'typeId': instance.typeId,
      'nameId': instance.nameId,
      'area': instance.area,
      'clcl': const StringToNumConverter().toJson(instance.clcl),
      'mdht': const StringToNumConverter().toJson(instance.mdht),
      'unitPrice': instance.unitPrice,
      'value': instance.value,
      'name': instance.name,
      'type': instance.type,
    };

ConstructionProps _$ConstructionPropsFromJson(Map<String, dynamic> json) =>
    ConstructionProps(
      constructionName: json['constructionName'] as String?,
      constructionNameId: json['constructionNameId'] as int?,
      constructionTypeId: json['constructionTypeId'] as int?,
      highPrice: (json['highPrice'] as num?)?.toDouble(),
      lowPrice: (json['lowPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ConstructionPropsToJson(ConstructionProps instance) =>
    <String, dynamic>{
      'constructionName': instance.constructionName,
      'constructionNameId': instance.constructionNameId,
      'constructionTypeId': instance.constructionTypeId,
      'highPrice': instance.highPrice,
      'lowPrice': instance.lowPrice,
    };

FastValuationInfoResponse _$FastValuationInfoResponseFromJson(
        Map<String, dynamic> json) =>
    FastValuationInfoResponse(
      unPlanPrice: (json['unPlanPrice'] as num?)?.toDouble() ?? 0.0,
      data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => FastValuationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
      logs:
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
    );

Map<String, dynamic> _$FastValuationInfoResponseToJson(
        FastValuationInfoResponse instance) =>
    <String, dynamic>{
      'unPlanPrice': instance.unPlanPrice,
      'data': instance.data,
      'value': instance.value,
      'logs': instance.logs,
    };

FindByLOSResponse _$FindByLOSResponseFromJson(Map<String, dynamic> json) =>
    FindByLOSResponse(
      totalValue: (json['totalValue'] as num?)?.toDouble(),
      roadInPriceRange: json['roadInPriceRange'] as String?,
      landPrice: (json['landPrice'] as num?)?.toDouble(),
      areaUnPlanValue: (json['areaUnPlanValue'] as num?)?.toDouble(),
      address: json['address'] as String?,
      assetTypeName: json['assetTypeName'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      areaUnPlanPrice: (json['areaUnPlanPrice'] as num?)?.toDouble(),
      areaUnPlan: (json['areaUnPlan'] as num?)?.toDouble(),
      areaWidth: json['areaWidth'] as String?,
      areaInPlanPrice: (json['areaInPlanPrice'] as num?)?.toDouble(),
      constructionPrice: (json['constructionPrice'] as num?)?.toDouble(),
      areaInPlanValue: (json['areaInPlanValue'] as num?)?.toDouble(),
      value: (json['value'] as num?)?.toDouble(),
      areaInPlan: (json['areaInPlan'] as num?)?.toDouble(),
      valuations: (json['valuations'] as List<dynamic>?)
              ?.map(
                  (e) => FastValuationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$FindByLOSResponseToJson(FindByLOSResponse instance) =>
    <String, dynamic>{
      'totalValue': instance.totalValue,
      'roadInPriceRange': instance.roadInPriceRange,
      'landPrice': instance.landPrice,
      'areaUnPlanValue': instance.areaUnPlanValue,
      'address': instance.address,
      'assetTypeName': instance.assetTypeName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'areaUnPlanPrice': instance.areaUnPlanPrice,
      'areaUnPlan': instance.areaUnPlan,
      'areaWidth': instance.areaWidth,
      'areaInPlanPrice': instance.areaInPlanPrice,
      'constructionPrice': instance.constructionPrice,
      'areaInPlanValue': instance.areaInPlanValue,
      'value': instance.value,
      'areaInPlan': instance.areaInPlan,
      'valuations': instance.valuations,
    };
