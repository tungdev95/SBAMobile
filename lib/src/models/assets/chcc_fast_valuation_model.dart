// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:sba/generated/l10n.dart';

import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/assets/fast_valuation_model.dart';

part 'chcc_fast_valuation_model.g.dart';

@JsonSerializable()
class CHCCFastValModel extends FastValuationModel {
  String? building;
  String? apartmentCode;
  int? floorNo;
  String? facades;
  String? furniture;
  String? otherFactor;
  double? privateUseArea;
  double? clearanceArea;
  double? buildupArea;
  double? extendArea;
  double? unitPrice;
  int? bedrooms;
  @JsonKey(defaultValue: 1)
  int? surfaces;
  int? toilets;
  int? totalFloor;
  String? appraisalUnit;
  String? numberApartment;
  String? singlePriceExchangeArea;
  int? kitchens;
  String? addressProvinceName;
  String? addressDistrictName;
  String? addressWardName;
  dynamic orderBy;
  dynamic stt;
  String? utilities;
  double? value;
  String? block;
  @JsonKey(
    fromJson: null,
    toJson: null,
  )
  List<CHCCFastValuationDetail>? details;
  String? projectId;
  String? buildingId;
  String? blockId;
  bool? getDetail = false;

  CHCCFastValModel({
    this.building,
    this.apartmentCode,
    this.floorNo,
    this.facades,
    this.furniture,
    this.otherFactor,
    this.privateUseArea,
    this.clearanceArea,
    this.buildupArea,
    this.extendArea,
    this.unitPrice,
    this.bedrooms,
    this.surfaces,
    this.toilets,
    this.totalFloor,
    this.appraisalUnit,
    this.numberApartment,
    this.singlePriceExchangeArea,
    this.kitchens,
    this.addressProvinceName,
    this.addressDistrictName,
    this.addressWardName,
    this.utilities,
    required super.valuations,
    required super.constructions,
    required super.logs,
    this.value,
    this.details,
    this.block,
    this.projectId,
    this.buildingId,
    this.blockId,
  });

  factory CHCCFastValModel.fromJson(Map<String, dynamic> json) {
    final result = _$CHCCFastValModelFromJson(json);
    result.provinceId ??= result.provinces?.code;
    result.wardId ??= result.wards?.code;
    result.districtId ??= result.districts?.code;
    result.details = (json['valuations'] as List<dynamic>?)
        ?.map((e) => CHCCFastValuationDetail.fromJson(e))
        .toList();
    return result;
  }

  List<String> get listUtilities => (utilities ?? '').split(',');

  double get tongGiaTri {
    return (donGia * (privateUseArea ?? 1)).roundToDouble();
  }

  double get donGia {
    try {
      final lsTSSS = details ?? [];
      if (lsTSSS.isEmpty) {
        return 0.0;
      }
      final total = lsTSSS.fold(
          0.0,
          (previousValue, element) =>
              previousValue + (element.optimizePrice ?? 0.0));
      return (total / lsTSSS.length).roundToDouble();
    } catch (e) {
      return 0.0;
    }
  }

  void addNewUtils(String name) {
    utilities = [...listUtilities, name].join(',');
  }

  void removeUtils(String name) {
    utilities = ([...listUtilities]..removeWhere((element) => element == name))
        .join(',');
  }

  void updateUtils(bool? isCheck, String name) {
    if (isCheck == true) {
      addNewUtils(name);
    } else {
      removeUtils(name);
    }
  }

  bool? get garage {
    return utilities?.contains(UtilitiesApartment.garage.name);
  }

  bool? get pool {
    return utilities?.contains(UtilitiesApartment.pool.name);
  }

  bool? get innerPark {
    return utilities?.contains(UtilitiesApartment.innerPark.name);
  }

  bool? get commercialServiceArea {
    return utilities?.contains(UtilitiesApartment.commercialServiceArea.name);
  }

  bool? get elevator {
    return utilities?.contains(UtilitiesApartment.elevator.name);
  }

  bool? get hospitalSchoolPreschool {
    return utilities?.contains(UtilitiesApartment.hospitalSchoolPreschool.name);
  }

  bool? get receptionHall {
    return utilities?.contains(UtilitiesApartment.receptionHall.name);
  }

  @override
  Map<String, dynamic> toJson() {
    final result = _$CHCCFastValModelToJson(this);
    result['valuationIds'] = details?.map((e) => e.assetId).toList();
    result['valuations'] = details?.map((e) => e.toJson()).toList();
    result['optimizePrice'] = tongGiaTri;

    return result;
  }
}

@JsonSerializable()
class DinhGiaCHCCResponse {
  @JsonKey(defaultValue: 0.0)
  double value;
  @JsonKey(defaultValue: [])
  List<CHCCFastValuationDetail> data;

  DinhGiaCHCCResponse({
    required this.value,
    required this.data,
  });

  factory DinhGiaCHCCResponse.fromJson(Map<String, dynamic> json) =>
      _$DinhGiaCHCCResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DinhGiaCHCCResponseToJson(this);
}

@JsonSerializable()
class CHCCFastValuationDetail {
  String? assetId;
  String? assetCode;
  String? assetChildId;
  String? dataSourceName;
  String? infoSourceName;
  dynamic contact;
  dynamic transactionStatus;
  dynamic transactionTime;
  String? appraisalTime;
  String? addressProvince;
  String? addressDistrict;
  String? addressWard;
  String? addressStreet;
  String? addressDetail;
  String? address;
  dynamic positionName;
  dynamic mapSheetNumber;
  dynamic landPlotNumber;
  double? latitude;
  double? longitude;
  dynamic assetImage;
  String? projectName;
  dynamic building;
  String? apartmentCode;
  int? floorNo;
  dynamic facades;
  String? furniture;
  String? businessAdvantage;
  String? otherFactor;
  double? privateUseArea;
  double? clearanceArea;
  double? buildupArea;
  double? extendArea;
  double? transactionPrice;
  double? estimatePrice;
  int? unitPrice;
  String? whoCreate;
  DateTime? dateCreate;
  bool? approved;
  dynamic sentiment;
  dynamic sentimentApproved;
  Coordinate? coordinate;
  int? storedTypeId;
  dynamic storedTypeName;
  String? storedType;
  dynamic customerName;
  dynamic customerIdentity;
  dynamic codeBook;
  dynamic isFastValuation;
  dynamic valuationIds;
  dynamic valuations;
  dynamic valuationHistories;
  Provinces? provinces;
  Districts? districts;
  Wards? wards;
  int? bedrooms;
  double? surfaces;
  double? toilets;
  int? totalFloor;
  double? totalValue;
  dynamic description;
  dynamic appraisalUnit;
  dynamic totalFloorArea;
  dynamic usingPurposeName;
  double? numberApartment;
  dynamic singlePriceExchangeArea;
  dynamic priceInPlan;
  String? legal;
  double? kitchens;
  dynamic addressProvinceName;
  dynamic addressDistrictName;
  dynamic addressWardName;
  dynamic positionId;
  dynamic usingPurposeId;
  int? dataSourceId;
  int? infoSourceId;
  int? optimizePrice;
  int? adjustPrice;
  String? priceOwnerApartment;
  dynamic optimizePrices;
  String? utilities;
  dynamic orderBy;
  dynamic stt;
  bool? hasGarage;
  bool? hasElevator;
  bool? hasPool;
  bool? hasCommercialServiceArea;
  bool? hasInnerPark;
  bool? hasHospitalSchoolPreschool;
  bool? hasReceptionHall;
  dynamic distanceToAsset;
  String? blockName;
  String? buildingName;
  CHCCFastValuationDetail({
    this.assetId,
    this.assetCode,
    this.assetChildId,
    this.dataSourceName,
    this.infoSourceName,
    required this.contact,
    required this.transactionStatus,
    required this.transactionTime,
    this.appraisalTime,
    this.addressProvince,
    this.addressDistrict,
    this.addressWard,
    this.addressStreet,
    this.addressDetail,
    this.address,
    required this.positionName,
    required this.mapSheetNumber,
    required this.landPlotNumber,
    this.latitude,
    this.longitude,
    required this.assetImage,
    this.projectName,
    required this.building,
    this.apartmentCode,
    this.floorNo,
    required this.facades,
    required this.furniture,
    required this.businessAdvantage,
    required this.otherFactor,
    this.privateUseArea,
    this.clearanceArea,
    required this.buildupArea,
    required this.extendArea,
    required this.transactionPrice,
    required this.estimatePrice,
    this.unitPrice,
    this.whoCreate,
    this.dateCreate,
    this.approved,
    required this.sentiment,
    required this.sentimentApproved,
    this.coordinate,
    this.storedTypeId,
    required this.storedTypeName,
    this.storedType,
    required this.customerName,
    required this.customerIdentity,
    required this.codeBook,
    required this.isFastValuation,
    required this.valuationIds,
    required this.valuations,
    required this.valuationHistories,
    this.provinces,
    this.districts,
    this.wards,
    this.bedrooms,
    required this.surfaces,
    required this.toilets,
    this.totalFloor,
    this.totalValue,
    required this.description,
    required this.appraisalUnit,
    required this.totalFloorArea,
    required this.usingPurposeName,
    required this.numberApartment,
    required this.singlePriceExchangeArea,
    required this.priceInPlan,
    this.legal,
    required this.kitchens,
    required this.addressProvinceName,
    required this.addressDistrictName,
    required this.addressWardName,
    required this.positionId,
    required this.usingPurposeId,
    this.dataSourceId,
    this.infoSourceId,
    this.optimizePrice,
    this.adjustPrice,
    this.priceOwnerApartment,
    required this.optimizePrices,
    required this.utilities,
    required this.orderBy,
    required this.stt,
    this.hasGarage,
    this.hasElevator,
    this.hasPool,
    this.hasCommercialServiceArea,
    this.hasInnerPark,
    this.hasHospitalSchoolPreschool,
    this.hasReceptionHall,
    required this.distanceToAsset,
    this.blockName,
    this.buildingName,
  });

  factory CHCCFastValuationDetail.fromJson(Map<String, dynamic>? json) =>
      _$CHCCFastValuationDetailFromJson(json ?? {});
  Map<String, dynamic> toJson() => _$CHCCFastValuationDetailToJson(this);

  List<String> get listUtilities => (utilities ?? '').split(',');

  String get utilitiesName {
    return listUtilities.map((e) => getUtilitiesName(e)).join(', ');
  }

  String getUtilitiesName(String name) => switch (name) {
        'garage' => S.current.ham_de_xe,
        'elevator' => S.current.thang_may,
        'pool' => S.current.ho_boi,
        'commercialServiceArea' => S.current.khu_thuong_mai,
        'innerPark' => S.current.cong_vien_noi_khu,
        'hospitalSchoolPreschool' => S.current.benh_vien,
        'receptionHall' => S.current.sanh_le_tan,
        _ => '',
      };
}
