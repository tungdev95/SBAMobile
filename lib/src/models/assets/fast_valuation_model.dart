// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:sba/src/services/conveter/safe_double_format.dart';
import 'package:sba/src/services/conveter/string_to_num_converter.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/utils/uuid.dart';

part 'fast_valuation_model.g.dart';

@JsonSerializable()
@SafeDoubleFormatConverter()
class FastValuationModel {
  String? id;
  String? assetId;
  String? assetCode;
  dynamic dataSourceName;
  String? infoSourceName;
  String? contact;
  String? transactionStatus;
  String? transactionTime;
  DateTime? appraisalTime;
  String? addressProvince;
  String? addressDistrict;
  String? addressWard;
  String? addressStreet;
  String? addressDetail;
  String? address;
  String? positionName;
  String? mapSheetNumber;
  String? landPlotNumber;
  double? latitude;
  double? longitude;
  String? assetImage;
  double? areaWidth;
  double? landLength;
  double? areaInplan;
  double? areaUnplan;
  double? facadeLength;
  int? numberOfFacade;
  String? shape;
  double? widthToMainRoad;
  double? distanceToMainRoad;
  String? businessAdvantage;
  String? legal;
  String? traffic;
  String? security;
  String? infrastructure;
  String? usingPurposeName;
  String? projectName;
  String? note;
  double? transactionPrice;
  double? estimatePrice;
  double? totalFloorArea;
  double? constructionUnitPrice;
  double? remainQuality;
  double? constructionPrice;
  double? landUnitPrice;
  double? landPrice;
  dynamic rentDayPrice;
  dynamic rentYearPrice;
  dynamic estimateRentYearPrice;
  dynamic rentYearUnitPrice;
  double? totalValue;
  Coordinate? coordinate;
  String? whoCreate;
  DateTime? dateCreate;
  bool? approved;
  dynamic sentiment;
  dynamic sentimentApproved;
  int? storedTypeId;
  String? storedType;
  String? customerName;
  String? customerIdentity;
  dynamic codeBook;
  dynamic isFastValuation;
  List<String>? valuationIds;
  @JsonKey(defaultValue: [])
  List<FastValuationModel> valuations;
  dynamic valuationHistories;
  @JsonKey(defaultValue: [])
  List<FastValueConstruction> constructions;
  @JsonKey(includeToJson: false)
  Provinces? provinces;
  @JsonKey(includeToJson: false)
  Districts? districts;
  @JsonKey(includeToJson: false)
  Wards? wards;
  dynamic roadContiguousTypeId;
  dynamic roadInPriceRangeId;
  dynamic roadInPriceRange;
  dynamic description;
  double? priceInPlan;
  dynamic structure;
  dynamic frontage;
  dynamic addressStreetFrom;
  dynamic addressStreetTo;
  double? unPlanPrice;
  dynamic geographicDescription;
  dynamic roadContiguousTypeName;
  double? optimizePrice;
  double? radius;
  dynamic optimizePrices;
  String? provinceId;
  String? districtId;
  String? wardId;
  int? positionId;
  int? usingPurposeId;
  int? dataSourceId;
  int? infoSourceId;
  double? areaUnPlanPrice;
  double? areaInPlanPrice;
  double? areaInPlanValue;
  @JsonKey(defaultValue: [])
  List<String> logs;

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool isNew = false;

  FastValuationModel({
    this.id,
    this.assetId,
    this.assetCode,
    this.dataSourceName,
    this.infoSourceName,
    this.contact,
    this.transactionStatus,
    this.transactionTime,
    this.appraisalTime,
    this.addressProvince,
    this.addressDistrict,
    this.addressWard,
    this.addressStreet,
    this.addressDetail,
    this.address,
    this.positionName,
    this.mapSheetNumber,
    this.landPlotNumber,
    this.latitude,
    this.longitude,
    this.assetImage,
    this.areaWidth,
    this.landLength,
    this.areaInplan,
    this.areaUnplan,
    this.facadeLength,
    this.numberOfFacade,
    this.shape,
    this.widthToMainRoad,
    this.distanceToMainRoad,
    this.businessAdvantage,
    this.legal,
    this.traffic,
    this.security,
    this.infrastructure,
    this.usingPurposeName,
    this.projectName,
    this.note,
    this.transactionPrice,
    this.estimatePrice,
    this.totalFloorArea,
    this.constructionUnitPrice,
    this.remainQuality,
    this.constructionPrice,
    this.landUnitPrice,
    this.landPrice,
    this.rentDayPrice,
    this.rentYearPrice,
    this.estimateRentYearPrice,
    this.rentYearUnitPrice,
    this.totalValue,
    this.coordinate,
    this.whoCreate,
    this.dateCreate,
    this.approved,
    this.sentiment,
    this.sentimentApproved,
    this.storedTypeId,
    this.storedType,
    this.customerName,
    this.customerIdentity,
    this.codeBook,
    this.isFastValuation,
    this.valuationIds,
    required this.valuations,
    this.valuationHistories,
    required this.constructions,
    this.provinces,
    this.districts,
    this.wards,
    this.roadContiguousTypeId,
    this.roadInPriceRange,
    this.description,
    this.priceInPlan,
    this.roadInPriceRangeId,
    this.structure,
    this.frontage,
    this.addressStreetFrom,
    this.addressStreetTo,
    this.unPlanPrice,
    this.geographicDescription,
    this.roadContiguousTypeName,
    this.optimizePrice,
    this.radius,
    this.optimizePrices,
    this.provinceId,
    this.districtId,
    this.wardId,
    this.positionId,
    this.usingPurposeId,
    this.dataSourceId,
    this.infoSourceId,
    this.areaUnPlanPrice,
    this.areaInPlanPrice,
    this.areaInPlanValue,
    required this.logs,
  }) {
    id ??= Uuid().generateV4();
  }

  factory FastValuationModel.fromJson(Map<String, dynamic> json) =>
      _$FastValuationModelFromJson(json);

  Map<String, dynamic> toJson() => _$FastValuationModelToJson(this);

  String get fullAddress =>
      address ??
      [
        addressDetail,
        addressStreet,
        wards?.name,
        districts?.name,
        provinces?.name,
      ].where((element) => (element ?? '').isNotEmpty).join(',');

  String? get giaTriDatCongNhanPhuHopQuyHoach {
    return ((areaInplan ?? 0.0) * (estimatePrice ?? 0.0)).toPriceFormat(true);
  }

  String? get giaTriDatKhongCongNhanPhuHopQuyHoach {
    return ((areaUnplan ?? 0.0) * (unPlanPrice ?? 0.0)).toPriceFormat(true);
  }

  String titleItem() {
    return assetCode ?? '';
  }

  @JsonKey(includeToJson: false, includeFromJson: false)
  double get getConstructionPrice {
    if ((constructionPrice ?? 0.0) > 0) return (constructionPrice ?? 0.0);
    final totalConstructionPrice = constructions.fold(0.0,
        (previousValue, element) => previousValue + (element.value ?? 0.0));
    return max(totalConstructionPrice, (constructionPrice ?? 0.0));
  }
}

@JsonSerializable()
class Coordinate {
  double? latitude;
  double? longitude;
  Coordinate({
    this.latitude,
    this.longitude,
  });
  factory Coordinate.fromJson(Map<String, dynamic> json) =>
      _$CoordinateFromJson(json);
  Map<String, dynamic> toJson() => _$CoordinateToJson(this);
}

@JsonSerializable()
class Provinces {
  String? code;
  String? name;
  String? nameEn;
  String? fullName;
  String? fullNameEn;
  String? codeName;
  int? administrativeUnitId;
  int? administrativeRegionId;
  Provinces({
    this.code,
    this.name,
    this.nameEn,
    this.fullName,
    this.fullNameEn,
    this.codeName,
    this.administrativeUnitId,
    this.administrativeRegionId,
  });

  factory Provinces.fromJson(Map<String, dynamic> json) =>
      _$ProvincesFromJson(json);
  Map<String, dynamic> toJson() => _$ProvincesToJson(this);
}

@JsonSerializable()
class Districts {
  String? code;
  String? name;
  String? nameEn;
  String? fullName;
  String? fullNameEn;
  String? codeName;
  String? provinceCode;
  int? administrativeUnitId;
  Districts({
    this.code,
    this.name,
    this.nameEn,
    this.fullName,
    this.fullNameEn,
    this.codeName,
    this.provinceCode,
    this.administrativeUnitId,
  });

  factory Districts.fromJson(Map<String, dynamic> json) =>
      _$DistrictsFromJson(json);
  Map<String, dynamic> toJson() => _$DistrictsToJson(this);
}

@JsonSerializable()
class Wards {
  String? code;
  String? name;
  String? nameEn;
  String? fullName;
  String? fullNameEn;
  String? codeName;
  String? districtCode;
  int? administrativeUnitId;
  Wards({
    this.code,
    this.name,
    this.nameEn,
    this.fullName,
    this.fullNameEn,
    this.codeName,
    this.districtCode,
    this.administrativeUnitId,
  });

  factory Wards.fromJson(Map<String, dynamic> json) => _$WardsFromJson(json);
  Map<String, dynamic> toJson() => _$WardsToJson(this);
}

@JsonSerializable()
class OptimizePrices {
  @JsonKey(defaultValue: '')
  String assetId;
  int? optimizePrice;
  OptimizePrices({
    required this.assetId,
    this.optimizePrice,
  });

  factory OptimizePrices.fromJson(Map<String, dynamic> json) =>
      _$OptimizePricesFromJson(json);
  Map<String, dynamic> toJson() => _$OptimizePricesToJson(this);
}

@JsonSerializable()
class FastValueConstruction extends Equatable {
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? itemId;
  String? id;
  String? assetId;
  dynamic typeId;
  String? nameId;
  @JsonKey(fromJson: dynamicToDoubleConvert)
  double? area;
  @StringToNumConverter()
  double? clcl;
  @StringToNumConverter()
  double? mdht;
  double? unitPrice;
  double? value;
  String? name;
  String? type;
  FastValueConstruction({
    this.id,
    this.assetId,
    this.typeId,
    this.nameId,
    this.area,
    this.clcl,
    this.mdht,
    this.unitPrice,
    this.value,
    this.name,
    this.type,
  }) {
    itemId ??= Uuid().generateV4();
  }

  factory FastValueConstruction.fromJson(Map<String, dynamic> json) =>
      _$FastValueConstructionFromJson(json);
  Map<String, dynamic> toJson() => _$FastValueConstructionToJson(this);

  @override
  List<Object?> get props => [itemId];
}

@JsonSerializable()
class ConstructionProps {
  String? constructionName;
  int? constructionNameId;
  int? constructionTypeId;
  double? highPrice;
  double? lowPrice;

  ConstructionProps({
    this.constructionName,
    this.constructionNameId,
    this.constructionTypeId,
    this.highPrice,
    this.lowPrice,
  });

  factory ConstructionProps.fromJson(Map<String, dynamic> json) =>
      _$ConstructionPropsFromJson(json);
  Map<String, dynamic> toJson() => _$ConstructionPropsToJson(this);
}

@JsonSerializable()
class FastValuationInfoResponse {
  @JsonKey(defaultValue: 0.0)
  double unPlanPrice;
  @JsonKey(defaultValue: [])
  List<FastValuationModel> data;
  @JsonKey(defaultValue: 0.0)
  double value;
  @JsonKey(defaultValue: [])
  List<String> logs;
  FastValuationInfoResponse({
    required this.unPlanPrice,
    required this.data,
    required this.value,
    required this.logs,
  });

  factory FastValuationInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$FastValuationInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FastValuationInfoResponseToJson(this);
}

@JsonSerializable()
class FindByLOSResponse {
  double? totalValue;
  String? roadInPriceRange;
  double? landPrice;
  double? areaUnPlanValue;
  String? address;
  String? assetTypeName;
  String? latitude;
  String? longitude;
  double? areaUnPlanPrice;
  double? areaUnPlan;
  String? areaWidth;
  double? areaInPlanPrice;
  double? constructionPrice;
  double? areaInPlanValue;
  double? value;
  double? areaInPlan;
  @JsonKey(defaultValue: [])
  List<FastValuationModel> valuations;
  FindByLOSResponse({
    this.totalValue,
    this.roadInPriceRange,
    this.landPrice,
    this.areaUnPlanValue,
    this.address,
    this.assetTypeName,
    this.latitude,
    this.longitude,
    this.areaUnPlanPrice,
    this.areaUnPlan,
    this.areaWidth,
    this.areaInPlanPrice,
    this.constructionPrice,
    this.areaInPlanValue,
    this.value,
    this.areaInPlan,
    required this.valuations,
  });

  factory FindByLOSResponse.fromJson(Map<String, dynamic> json) =>
      _$FindByLOSResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FindByLOSResponseToJson(this);
}

double? dynamicToDoubleConvert(json) {
  if (json is double) return json;
  if (json is String) {
    return double.tryParse(json);
  }
  return null;
}
