// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chcc_fast_valuation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CHCCFastValModel _$CHCCFastValModelFromJson(Map<String, dynamic> json) =>
    CHCCFastValModel(
      building: json['building'] as String?,
      apartmentCode: json['apartmentCode'] as String?,
      floorNo: json['floorNo'] as int?,
      facades: json['facades'] as String?,
      furniture: json['furniture'] as String?,
      otherFactor: json['otherFactor'] as String?,
      privateUseArea: (json['privateUseArea'] as num?)?.toDouble(),
      clearanceArea: (json['clearanceArea'] as num?)?.toDouble(),
      buildupArea: (json['buildupArea'] as num?)?.toDouble(),
      extendArea: (json['extendArea'] as num?)?.toDouble(),
      unitPrice: (json['unitPrice'] as num?)?.toDouble(),
      bedrooms: json['bedrooms'] as int?,
      surfaces: json['surfaces'] as int? ?? 1,
      toilets: json['toilets'] as int?,
      totalFloor: json['totalFloor'] as int?,
      appraisalUnit: json['appraisalUnit'] as String?,
      numberApartment: json['numberApartment'] as String?,
      singlePriceExchangeArea: json['singlePriceExchangeArea'] as String?,
      kitchens: json['kitchens'] as int?,
      addressProvinceName: json['addressProvinceName'] as String?,
      addressDistrictName: json['addressDistrictName'] as String?,
      addressWardName: json['addressWardName'] as String?,
      utilities: json['utilities'] as String?,
      valuations: (json['valuations'] as List<dynamic>?)
              ?.map(
                  (e) => FastValuationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      constructions: (json['constructions'] as List<dynamic>?)
              ?.map((e) =>
                  FastValueConstruction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      logs:
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      value: (json['value'] as num?)?.toDouble(),
      details: (json['details'] as List<dynamic>?)
          ?.map((e) =>
              CHCCFastValuationDetail.fromJson(e as Map<String, dynamic>?))
          .toList(),
      block: json['block'] as String?,
      projectId: json['projectId'] as String?,
      buildingId: json['buildingId'] as String?,
      blockId: json['blockId'] as String?,
    )
      ..id = json['id'] as String?
      ..assetId = json['assetId'] as String?
      ..assetCode = json['assetCode'] as String?
      ..dataSourceName = json['dataSourceName']
      ..infoSourceName = json['infoSourceName'] as String?
      ..contact = json['contact'] as String?
      ..transactionStatus = json['transactionStatus'] as String?
      ..transactionTime = json['transactionTime'] as String?
      ..appraisalTime = json['appraisalTime'] == null
          ? null
          : DateTime.parse(json['appraisalTime'] as String)
      ..addressProvince = json['addressProvince'] as String?
      ..addressDistrict = json['addressDistrict'] as String?
      ..addressWard = json['addressWard'] as String?
      ..addressStreet = json['addressStreet'] as String?
      ..addressDetail = json['addressDetail'] as String?
      ..address = json['address'] as String?
      ..positionName = json['positionName'] as String?
      ..mapSheetNumber = json['mapSheetNumber'] as String?
      ..landPlotNumber = json['landPlotNumber'] as String?
      ..latitude = (json['latitude'] as num?)?.toDouble()
      ..longitude = (json['longitude'] as num?)?.toDouble()
      ..assetImage = json['assetImage'] as String?
      ..areaWidth = (json['areaWidth'] as num?)?.toDouble()
      ..landLength = (json['landLength'] as num?)?.toDouble()
      ..areaInplan = (json['areaInplan'] as num?)?.toDouble()
      ..areaUnplan = (json['areaUnplan'] as num?)?.toDouble()
      ..facadeLength = (json['facadeLength'] as num?)?.toDouble()
      ..numberOfFacade = json['numberOfFacade'] as int?
      ..shape = json['shape'] as String?
      ..widthToMainRoad = (json['widthToMainRoad'] as num?)?.toDouble()
      ..distanceToMainRoad = (json['distanceToMainRoad'] as num?)?.toDouble()
      ..businessAdvantage = json['businessAdvantage'] as String?
      ..legal = json['legal'] as String?
      ..traffic = json['traffic'] as String?
      ..security = json['security'] as String?
      ..infrastructure = json['infrastructure'] as String?
      ..usingPurposeName = json['usingPurposeName'] as String?
      ..projectName = json['projectName'] as String?
      ..note = json['note'] as String?
      ..transactionPrice = (json['transactionPrice'] as num?)?.toDouble()
      ..estimatePrice = (json['estimatePrice'] as num?)?.toDouble()
      ..totalFloorArea = (json['totalFloorArea'] as num?)?.toDouble()
      ..constructionUnitPrice =
          (json['constructionUnitPrice'] as num?)?.toDouble()
      ..remainQuality = (json['remainQuality'] as num?)?.toDouble()
      ..constructionPrice = (json['constructionPrice'] as num?)?.toDouble()
      ..landUnitPrice = (json['landUnitPrice'] as num?)?.toDouble()
      ..landPrice = (json['landPrice'] as num?)?.toDouble()
      ..rentDayPrice = json['rentDayPrice']
      ..rentYearPrice = json['rentYearPrice']
      ..estimateRentYearPrice = json['estimateRentYearPrice']
      ..rentYearUnitPrice = json['rentYearUnitPrice']
      ..totalValue = (json['totalValue'] as num?)?.toDouble()
      ..coordinate = json['coordinate'] == null
          ? null
          : Coordinate.fromJson(json['coordinate'] as Map<String, dynamic>)
      ..whoCreate = json['whoCreate'] as String?
      ..dateCreate = json['dateCreate'] == null
          ? null
          : DateTime.parse(json['dateCreate'] as String)
      ..approved = json['approved'] as bool?
      ..sentiment = json['sentiment']
      ..sentimentApproved = json['sentimentApproved']
      ..storedTypeId = json['storedTypeId'] as int?
      ..storedType = json['storedType'] as String?
      ..customerName = json['customerName'] as String?
      ..customerIdentity = json['customerIdentity'] as String?
      ..codeBook = json['codeBook']
      ..isFastValuation = json['isFastValuation']
      ..valuationIds = (json['valuationIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..valuationHistories = json['valuationHistories']
      ..provinces = json['provinces'] == null
          ? null
          : Provinces.fromJson(json['provinces'] as Map<String, dynamic>)
      ..districts = json['districts'] == null
          ? null
          : Districts.fromJson(json['districts'] as Map<String, dynamic>)
      ..wards = json['wards'] == null
          ? null
          : Wards.fromJson(json['wards'] as Map<String, dynamic>)
      ..roadContiguousTypeId = json['roadContiguousTypeId']
      ..roadInPriceRangeId = json['roadInPriceRangeId']
      ..roadInPriceRange = json['roadInPriceRange']
      ..description = json['description']
      ..priceInPlan = (json['priceInPlan'] as num?)?.toDouble()
      ..structure = json['structure']
      ..frontage = json['frontage']
      ..addressStreetFrom = json['addressStreetFrom']
      ..addressStreetTo = json['addressStreetTo']
      ..unPlanPrice = (json['unPlanPrice'] as num?)?.toDouble()
      ..geographicDescription = json['geographicDescription']
      ..roadContiguousTypeName = json['roadContiguousTypeName']
      ..optimizePrice = (json['optimizePrice'] as num?)?.toDouble()
      ..radius = (json['radius'] as num?)?.toDouble()
      ..optimizePrices = json['optimizePrices']
      ..provinceId = json['provinceId'] as String?
      ..districtId = json['districtId'] as String?
      ..wardId = json['wardId'] as String?
      ..positionId = json['positionId'] as int?
      ..usingPurposeId = json['usingPurposeId'] as int?
      ..dataSourceId = json['dataSourceId'] as int?
      ..infoSourceId = json['infoSourceId'] as int?
      ..areaUnPlanPrice = (json['areaUnPlanPrice'] as num?)?.toDouble()
      ..areaInPlanPrice = (json['areaInPlanPrice'] as num?)?.toDouble()
      ..areaInPlanValue = (json['areaInPlanValue'] as num?)?.toDouble()
      ..orderBy = json['orderBy']
      ..stt = json['stt']
      ..getDetail = json['getDetail'] as bool?;

Map<String, dynamic> _$CHCCFastValModelToJson(CHCCFastValModel instance) =>
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
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'assetImage': instance.assetImage,
      'areaWidth': instance.areaWidth,
      'landLength': instance.landLength,
      'areaInplan': instance.areaInplan,
      'areaUnplan': instance.areaUnplan,
      'facadeLength': instance.facadeLength,
      'numberOfFacade': instance.numberOfFacade,
      'shape': instance.shape,
      'widthToMainRoad': instance.widthToMainRoad,
      'distanceToMainRoad': instance.distanceToMainRoad,
      'businessAdvantage': instance.businessAdvantage,
      'legal': instance.legal,
      'traffic': instance.traffic,
      'security': instance.security,
      'infrastructure': instance.infrastructure,
      'usingPurposeName': instance.usingPurposeName,
      'projectName': instance.projectName,
      'note': instance.note,
      'transactionPrice': instance.transactionPrice,
      'estimatePrice': instance.estimatePrice,
      'totalFloorArea': instance.totalFloorArea,
      'constructionUnitPrice': instance.constructionUnitPrice,
      'remainQuality': instance.remainQuality,
      'constructionPrice': instance.constructionPrice,
      'landUnitPrice': instance.landUnitPrice,
      'landPrice': instance.landPrice,
      'rentDayPrice': instance.rentDayPrice,
      'rentYearPrice': instance.rentYearPrice,
      'estimateRentYearPrice': instance.estimateRentYearPrice,
      'rentYearUnitPrice': instance.rentYearUnitPrice,
      'totalValue': instance.totalValue,
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
      'priceInPlan': instance.priceInPlan,
      'structure': instance.structure,
      'frontage': instance.frontage,
      'addressStreetFrom': instance.addressStreetFrom,
      'addressStreetTo': instance.addressStreetTo,
      'unPlanPrice': instance.unPlanPrice,
      'geographicDescription': instance.geographicDescription,
      'roadContiguousTypeName': instance.roadContiguousTypeName,
      'optimizePrice': instance.optimizePrice,
      'radius': instance.radius,
      'optimizePrices': instance.optimizePrices,
      'provinceId': instance.provinceId,
      'districtId': instance.districtId,
      'wardId': instance.wardId,
      'positionId': instance.positionId,
      'usingPurposeId': instance.usingPurposeId,
      'dataSourceId': instance.dataSourceId,
      'infoSourceId': instance.infoSourceId,
      'areaUnPlanPrice': instance.areaUnPlanPrice,
      'areaInPlanPrice': instance.areaInPlanPrice,
      'areaInPlanValue': instance.areaInPlanValue,
      'logs': instance.logs,
      'building': instance.building,
      'apartmentCode': instance.apartmentCode,
      'floorNo': instance.floorNo,
      'facades': instance.facades,
      'furniture': instance.furniture,
      'otherFactor': instance.otherFactor,
      'privateUseArea': instance.privateUseArea,
      'clearanceArea': instance.clearanceArea,
      'buildupArea': instance.buildupArea,
      'extendArea': instance.extendArea,
      'unitPrice': instance.unitPrice,
      'bedrooms': instance.bedrooms,
      'surfaces': instance.surfaces,
      'toilets': instance.toilets,
      'totalFloor': instance.totalFloor,
      'appraisalUnit': instance.appraisalUnit,
      'numberApartment': instance.numberApartment,
      'singlePriceExchangeArea': instance.singlePriceExchangeArea,
      'kitchens': instance.kitchens,
      'addressProvinceName': instance.addressProvinceName,
      'addressDistrictName': instance.addressDistrictName,
      'addressWardName': instance.addressWardName,
      'orderBy': instance.orderBy,
      'stt': instance.stt,
      'utilities': instance.utilities,
      'value': instance.value,
      'block': instance.block,
      'details': instance.details,
      'projectId': instance.projectId,
      'buildingId': instance.buildingId,
      'blockId': instance.blockId,
      'getDetail': instance.getDetail,
    };

DinhGiaCHCCResponse _$DinhGiaCHCCResponseFromJson(Map<String, dynamic> json) =>
    DinhGiaCHCCResponse(
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  CHCCFastValuationDetail.fromJson(e as Map<String, dynamic>?))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DinhGiaCHCCResponseToJson(
        DinhGiaCHCCResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.data,
    };

CHCCFastValuationDetail _$CHCCFastValuationDetailFromJson(
        Map<String, dynamic> json) =>
    CHCCFastValuationDetail(
      assetId: json['assetId'] as String?,
      assetCode: json['assetCode'] as String?,
      assetChildId: json['assetChildId'] as String?,
      dataSourceName: json['dataSourceName'] as String?,
      infoSourceName: json['infoSourceName'] as String?,
      contact: json['contact'],
      transactionStatus: json['transactionStatus'],
      transactionTime: json['transactionTime'],
      appraisalTime: json['appraisalTime'] as String?,
      addressProvince: json['addressProvince'] as String?,
      addressDistrict: json['addressDistrict'] as String?,
      addressWard: json['addressWard'] as String?,
      addressStreet: json['addressStreet'] as String?,
      addressDetail: json['addressDetail'] as String?,
      address: json['address'] as String?,
      positionName: json['positionName'],
      mapSheetNumber: json['mapSheetNumber'],
      landPlotNumber: json['landPlotNumber'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      assetImage: json['assetImage'],
      projectName: json['projectName'] as String?,
      building: json['building'],
      apartmentCode: json['apartmentCode'] as String?,
      floorNo: json['floorNo'] as int?,
      facades: json['facades'],
      furniture: json['furniture'] as String?,
      businessAdvantage: json['businessAdvantage'] as String?,
      otherFactor: json['otherFactor'] as String?,
      privateUseArea: (json['privateUseArea'] as num?)?.toDouble(),
      clearanceArea: (json['clearanceArea'] as num?)?.toDouble(),
      buildupArea: (json['buildupArea'] as num?)?.toDouble(),
      extendArea: (json['extendArea'] as num?)?.toDouble(),
      transactionPrice: (json['transactionPrice'] as num?)?.toDouble(),
      estimatePrice: (json['estimatePrice'] as num?)?.toDouble(),
      unitPrice: json['unitPrice'] as int?,
      whoCreate: json['whoCreate'] as String?,
      dateCreate: json['dateCreate'] == null
          ? null
          : DateTime.parse(json['dateCreate'] as String),
      approved: json['approved'] as bool?,
      sentiment: json['sentiment'],
      sentimentApproved: json['sentimentApproved'],
      coordinate: json['coordinate'] == null
          ? null
          : Coordinate.fromJson(json['coordinate'] as Map<String, dynamic>),
      storedTypeId: json['storedTypeId'] as int?,
      storedTypeName: json['storedTypeName'],
      storedType: json['storedType'] as String?,
      customerName: json['customerName'],
      customerIdentity: json['customerIdentity'],
      codeBook: json['codeBook'],
      isFastValuation: json['isFastValuation'],
      valuationIds: json['valuationIds'],
      valuations: json['valuations'],
      valuationHistories: json['valuationHistories'],
      provinces: json['provinces'] == null
          ? null
          : Provinces.fromJson(json['provinces'] as Map<String, dynamic>),
      districts: json['districts'] == null
          ? null
          : Districts.fromJson(json['districts'] as Map<String, dynamic>),
      wards: json['wards'] == null
          ? null
          : Wards.fromJson(json['wards'] as Map<String, dynamic>),
      bedrooms: json['bedrooms'] as int?,
      surfaces: (json['surfaces'] as num?)?.toDouble(),
      toilets: (json['toilets'] as num?)?.toDouble(),
      totalFloor: json['totalFloor'] as int?,
      totalValue: (json['totalValue'] as num?)?.toDouble(),
      description: json['description'],
      appraisalUnit: json['appraisalUnit'],
      totalFloorArea: json['totalFloorArea'],
      usingPurposeName: json['usingPurposeName'],
      numberApartment: (json['numberApartment'] as num?)?.toDouble(),
      singlePriceExchangeArea: json['singlePriceExchangeArea'],
      priceInPlan: json['priceInPlan'],
      legal: json['legal'] as String?,
      kitchens: (json['kitchens'] as num?)?.toDouble(),
      addressProvinceName: json['addressProvinceName'],
      addressDistrictName: json['addressDistrictName'],
      addressWardName: json['addressWardName'],
      positionId: json['positionId'],
      usingPurposeId: json['usingPurposeId'],
      dataSourceId: json['dataSourceId'] as int?,
      infoSourceId: json['infoSourceId'] as int?,
      optimizePrice: json['optimizePrice'] as int?,
      adjustPrice: json['adjustPrice'] as int?,
      priceOwnerApartment: json['priceOwnerApartment'] as String?,
      optimizePrices: json['optimizePrices'],
      utilities: json['utilities'] as String?,
      orderBy: json['orderBy'],
      stt: json['stt'],
      hasGarage: json['hasGarage'] as bool?,
      hasElevator: json['hasElevator'] as bool?,
      hasPool: json['hasPool'] as bool?,
      hasCommercialServiceArea: json['hasCommercialServiceArea'] as bool?,
      hasInnerPark: json['hasInnerPark'] as bool?,
      hasHospitalSchoolPreschool: json['hasHospitalSchoolPreschool'] as bool?,
      hasReceptionHall: json['hasReceptionHall'] as bool?,
      distanceToAsset: json['distanceToAsset'],
      blockName: json['blockName'] as String?,
      buildingName: json['buildingName'] as String?,
    );

Map<String, dynamic> _$CHCCFastValuationDetailToJson(
        CHCCFastValuationDetail instance) =>
    <String, dynamic>{
      'assetId': instance.assetId,
      'assetCode': instance.assetCode,
      'assetChildId': instance.assetChildId,
      'dataSourceName': instance.dataSourceName,
      'infoSourceName': instance.infoSourceName,
      'contact': instance.contact,
      'transactionStatus': instance.transactionStatus,
      'transactionTime': instance.transactionTime,
      'appraisalTime': instance.appraisalTime,
      'addressProvince': instance.addressProvince,
      'addressDistrict': instance.addressDistrict,
      'addressWard': instance.addressWard,
      'addressStreet': instance.addressStreet,
      'addressDetail': instance.addressDetail,
      'address': instance.address,
      'positionName': instance.positionName,
      'mapSheetNumber': instance.mapSheetNumber,
      'landPlotNumber': instance.landPlotNumber,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'assetImage': instance.assetImage,
      'projectName': instance.projectName,
      'building': instance.building,
      'apartmentCode': instance.apartmentCode,
      'floorNo': instance.floorNo,
      'facades': instance.facades,
      'furniture': instance.furniture,
      'businessAdvantage': instance.businessAdvantage,
      'otherFactor': instance.otherFactor,
      'privateUseArea': instance.privateUseArea,
      'clearanceArea': instance.clearanceArea,
      'buildupArea': instance.buildupArea,
      'extendArea': instance.extendArea,
      'transactionPrice': instance.transactionPrice,
      'estimatePrice': instance.estimatePrice,
      'unitPrice': instance.unitPrice,
      'whoCreate': instance.whoCreate,
      'dateCreate': instance.dateCreate?.toIso8601String(),
      'approved': instance.approved,
      'sentiment': instance.sentiment,
      'sentimentApproved': instance.sentimentApproved,
      'coordinate': instance.coordinate,
      'storedTypeId': instance.storedTypeId,
      'storedTypeName': instance.storedTypeName,
      'storedType': instance.storedType,
      'customerName': instance.customerName,
      'customerIdentity': instance.customerIdentity,
      'codeBook': instance.codeBook,
      'isFastValuation': instance.isFastValuation,
      'valuationIds': instance.valuationIds,
      'valuations': instance.valuations,
      'valuationHistories': instance.valuationHistories,
      'provinces': instance.provinces,
      'districts': instance.districts,
      'wards': instance.wards,
      'bedrooms': instance.bedrooms,
      'surfaces': instance.surfaces,
      'toilets': instance.toilets,
      'totalFloor': instance.totalFloor,
      'totalValue': instance.totalValue,
      'description': instance.description,
      'appraisalUnit': instance.appraisalUnit,
      'totalFloorArea': instance.totalFloorArea,
      'usingPurposeName': instance.usingPurposeName,
      'numberApartment': instance.numberApartment,
      'singlePriceExchangeArea': instance.singlePriceExchangeArea,
      'priceInPlan': instance.priceInPlan,
      'legal': instance.legal,
      'kitchens': instance.kitchens,
      'addressProvinceName': instance.addressProvinceName,
      'addressDistrictName': instance.addressDistrictName,
      'addressWardName': instance.addressWardName,
      'positionId': instance.positionId,
      'usingPurposeId': instance.usingPurposeId,
      'dataSourceId': instance.dataSourceId,
      'infoSourceId': instance.infoSourceId,
      'optimizePrice': instance.optimizePrice,
      'adjustPrice': instance.adjustPrice,
      'priceOwnerApartment': instance.priceOwnerApartment,
      'optimizePrices': instance.optimizePrices,
      'utilities': instance.utilities,
      'orderBy': instance.orderBy,
      'stt': instance.stt,
      'hasGarage': instance.hasGarage,
      'hasElevator': instance.hasElevator,
      'hasPool': instance.hasPool,
      'hasCommercialServiceArea': instance.hasCommercialServiceArea,
      'hasInnerPark': instance.hasInnerPark,
      'hasHospitalSchoolPreschool': instance.hasHospitalSchoolPreschool,
      'hasReceptionHall': instance.hasReceptionHall,
      'distanceToAsset': instance.distanceToAsset,
      'blockName': instance.blockName,
      'buildingName': instance.buildingName,
    };
