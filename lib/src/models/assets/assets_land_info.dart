/// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/utils/uuid.dart';

part 'assets_land_info.g.dart';

@JsonSerializable()
class AssetLandInfo extends Equatable {
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? id;

  String? assetId;

  int? assetLandInforId;

  /// Số thửa
  String? landPlotNumber;

  /// Số tờ bản đồ
  String? mapSheetNumber;

  /// Địa chỉ chi tiết thực tế
  String? realAddressDetail;

  /// Đường phố thực tế
  String? realAddressStreet;

  /// Xã thực tế
  String? realAddressWard;

  /// Huyện thực tế
  String? realAddressDistrict;

  /// Tỉnh thực tế
  String? realAddressProvince;

  /// Địa chỉ chi tiết pháp lý
  String? legalAddressDetail;

  /// Đường phố pháp lý
  String? legalAddressStreet;

  /// Xã pháp lý
  String? legalAddressWard;

  /// Huyện pháp lý
  String? legalAddressDistrict;

  /// Tỉnh pháp lý
  String? legalAddressProvince;

  /// Đoạn đường trong khung giá ID
  int? roadInPriceRange;

  /// Khoảng cách tới đường chính
  double? distanceToMainRoad;

  /// loại đường tiếp giáp
  int? roadContiguousTypeId;

  /// Int	Vị trí ID
  int? positionId;

  /// Độ rộng đường nhỏ nhất
  double? minWidthToMainRoad;

  /// Độ rộng đường lớn nhất
  double? maxWidthToMainRoad;

  /// Ghi chú
  String? note;

  /// Khu vực ID
  int? zoneId;

  /// Vị trí trong khung giá ID
  int? positionInPriceRangeId;

  /// Hướng chính pháp lý
  String? legalMainDirection;

  /// Hình dạng pháp lý
  String? legalShape;

  /// Số mặt tiền pháp lý
  int? legalNumberOfFacade;

  /// Kích thước mặt tiền pháp lý
  double? legalFacadeLength;

  /// Kích thước chiều dài pháp lý
  double? legalLandLength;

  String? legalLandLengthDetail;

  /// Diện tích khuôn viên pháp lý
  double? legalAreaWidth;

  /// Diện tích phù hợp quy hoạch pháp lý
  @JsonKey(defaultValue: 0)
  double? legalAreaInPlan;

  /// Diện tích không phù hợp quy hoạch pháp lý
  double? legalAreaUnPlan;

  /// Diện tích sử dụng riêng pháp lý
  double? legalPrivateArea;

  /// Diện tích sử dụng chung pháp lý
  double? legalCommonArea;

  double? legalAreaNotConsiderValue;

  /// Hiện trạng sử dụng riêng pháp lý
  String? legalCurrentPrivateUsing;

  /// Hướng chính thực tế
  String? realMainDirection;

  /// Hình dạng thực tế
  String? realShape;

  /// Số mặt tiền thực tế
  int? realNumberOfFacade;

  /// Kích thước mặt tiền thực tế
  double? realFacadeLength;

  /// Kích thước chiều dài thực tế
  double? realLandLength;

  /// Diện tích khuôn viên thực tế
  double? realAreaWidth;

  /// Diện tích phù hợp quy hoạch thực tế
  @JsonKey(defaultValue: 0)
  double? realAreaInPlan;

  /// Diện tích không phù hợp quy hoạch thực tế
  double? realAreaUnPlan;

  double? realAreaNotConsiderValue;

  /// Diện tích sử dụng riêng thực tế
  double? realPrivateArea;

  /// Diện tích sử dụng chung thực tế
  double? realCommonArea;

  String? realCurrentPrivateUsing;

  /// Chi tiết kích thước chiều dài thực tế
  String? realLandLengthDetail;

  @JsonKey(defaultValue: [])
  List<LandingPurposeModel> assetLandUsingPurposes;

  @JsonKey(defaultValue: [])
  List<ConstructionModel> constructions;

  @JsonKey(defaultValue: [])
  List<TreeModel> assetTrees;

  bool get haveLandingPurpose => assetLandUsingPurposes.isNotEmpty;

  bool get haveCayTrong => assetTrees.isNotEmpty;

  bool get haveCTXD => constructions.isNotEmpty;

  @JsonKey(includeToJson: false)
  List<LandingPurposeModel> get getMucDichSDDat {
    try {
      return assetLandUsingPurposes
          .where((value) => value.isConsolidationPurposeParent == false)
          .toList();
    } catch (e) {
      return assetLandUsingPurposes;
    }
  }

  ///Hợp thửa
  @JsonKey(defaultValue: false)
  bool isConsolidation;

  ///Mục đích hỗn hợp
  @JsonKey(defaultValue: false)
  bool isConsolidationPurpose;

  ///Thông tin dự toán
  String? contructionFutureText;
  double? totalArea;
  double? buildingDensity;
  double? coeffcientsUsed;
  double? height;
  double? totalApartments;
  double? numOfFloors;
  double? underTankArea;
  double? wasteTankArea;
  double? numOfUnderFloors;
  String? basementFloor;
  double? totalFloorArea;
  double? depth;
  String? constructionFloor;
  double? constructionArea;
  String? turnPart;
  String? solePart;
  String? towerPart;
  String? constructionTitle;
  String? structuralSolution;
  String? architectualSolution;
  String? systemEngineering;
  String? systemTraffic;
  String? interior;
  String? estimateComment;
  @JsonKey(defaultValue: [])
  List<ConstructionCheckList> constructionChecklists;

  /// Chỉ tiêu
  @JsonKey(defaultValue: [])
  List<ConstructionFutureInfo> constructionFutureInfors;

  int? orderBy;

  AssetLandInfo({
    this.id,
    this.assetId,
    this.assetLandInforId,
    this.landPlotNumber,
    this.mapSheetNumber,
    this.realAddressDetail,
    this.realAddressStreet,
    this.realAddressWard,
    this.realAddressDistrict,
    this.realAddressProvince,
    this.legalAddressDetail,
    this.legalAddressStreet,
    this.legalAddressWard,
    this.legalAddressDistrict,
    this.legalAddressProvince,
    this.roadInPriceRange,
    this.distanceToMainRoad,
    this.roadContiguousTypeId,
    this.positionId,
    this.minWidthToMainRoad,
    this.maxWidthToMainRoad,
    this.note,
    this.zoneId,
    this.positionInPriceRangeId,
    this.legalMainDirection,
    this.legalShape,
    this.legalNumberOfFacade,
    this.legalFacadeLength,
    this.legalLandLength,
    this.legalAreaWidth,
    this.legalAreaInPlan,
    this.legalAreaUnPlan,
    this.legalPrivateArea,
    this.legalCommonArea,
    this.realMainDirection,
    this.realShape,
    this.realNumberOfFacade,
    this.realFacadeLength,
    this.realLandLength,
    this.realAreaWidth,
    this.realAreaInPlan,
    this.realAreaUnPlan,
    this.realPrivateArea,
    this.realCommonArea,
    this.realCurrentPrivateUsing,
    required this.assetLandUsingPurposes,
    required this.constructions,
    required this.assetTrees,
    this.contructionFutureText,
    this.totalArea,
    this.buildingDensity,
    this.coeffcientsUsed,
    this.height,
    this.totalApartments,
    this.numOfFloors,
    this.underTankArea,
    this.wasteTankArea,
    this.numOfUnderFloors,
    this.basementFloor,
    this.totalFloorArea,
    this.depth,
    this.constructionFloor,
    this.constructionArea,
    this.turnPart,
    this.solePart,
    this.towerPart,
    this.constructionTitle,
    this.structuralSolution,
    this.architectualSolution,
    this.systemEngineering,
    this.systemTraffic,
    this.interior,
    this.estimateComment,
    required this.constructionChecklists,
    required this.constructionFutureInfors,
    required this.isConsolidation,
    required this.isConsolidationPurpose,
    this.orderBy,
    this.legalAreaNotConsiderValue,
    this.realAreaNotConsiderValue,
    this.legalCurrentPrivateUsing,
    this.legalLandLengthDetail,
    this.realLandLengthDetail,
  }) {
    id ??= Uuid().generateV4();
  }

  factory AssetLandInfo.fromJson(Map<String, dynamic> json) =>
      _$AssetLandInfoFromJson(json);

  Map<String, dynamic> toJson() {
    assetLandUsingPurposes.forEachIndexed((index, element) {
      element.orderBy = index;
    });
    constructions.forEachIndexed((index, element) {
      element.orderBy = index;
    });
    return _$AssetLandInfoToJson(this);
  }

  @override
  List<Object?> get props => [id];

  AssetLandInfo copyWith({
    String? id,
    String? assetId,
    int? assetLandInforId,
    String? landPlotNumber,
    String? mapSheetNumber,
    String? realAddressDetail,
    String? realAddressStreet,
    String? realAddressWard,
    String? realAddressDistrict,
    String? realAddressProvince,
    String? legalAddressDetail,
    String? legalAddressStreet,
    String? legalAddressWard,
    String? legalAddressDistrict,
    String? legalAddressProvince,
    int? roadInPriceRange,
    double? distanceToMainRoad,
    int? roadContiguousTypeId,
    int? positionId,
    double? minWidthToMainRoad,
    double? maxWidthToMainRoad,
    String? note,
    int? zoneId,
    int? positionInPriceRangeId,
    String? legalMainDirection,
    String? legalShape,
    int? legalNumberOfFacade,
    double? legalFacadeLength,
    double? legalLandLength,
    double? legalAreaWidth,
    double? legalAreaInPlan,
    double? legalAreaUnPlan,
    double? legalPrivateArea,
    double? legalCommonArea,
    double? legalAreaNotConsiderValue,
    String? realMainDirection,
    String? realShape,
    int? realNumberOfFacade,
    double? realFacadeLength,
    double? realLandLength,
    double? realAreaWidth,
    double? realAreaInPlan,
    double? realAreaUnPlan,
    double? realAreaNotConsiderValue,
    double? realPrivateArea,
    double? realCommonArea,
    List<LandingPurposeModel>? assetLandUsingPurposes,
    List<ConstructionModel>? constructions,
    List<TreeModel>? assetTrees,
    bool? isConsolidation,
    bool? isConsolidationPurpose,
    String? contructionFutureText,
    double? totalArea,
    double? buildingDensity,
    double? coeffcientsUsed,
    double? height,
    double? totalApartments,
    double? numOfFloors,
    double? underTankArea,
    double? wasteTankArea,
    double? numOfUnderFloors,
    String? basementFloor,
    double? totalFloorArea,
    double? depth,
    String? constructionFloor,
    double? constructionArea,
    String? turnPart,
    String? solePart,
    String? towerPart,
    String? constructionTitle,
    String? structuralSolution,
    String? architectualSolution,
    String? systemEngineering,
    String? systemTraffic,
    String? interior,
    String? estimateComment,
    List<ConstructionCheckList>? constructionChecklists,
    List<ConstructionFutureInfo>? constructionFutureInfors,
    int? orderBy,
    String? realCurrentPrivateUsing,
    String? legalCurrentPrivateUsing,
    String? legalLandLengthDetail,
    String? realLandLengthDetail,
  }) {
    return AssetLandInfo(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      assetLandInforId: assetLandInforId ?? this.assetLandInforId,
      landPlotNumber: landPlotNumber ?? this.landPlotNumber,
      mapSheetNumber: mapSheetNumber ?? this.mapSheetNumber,
      realAddressDetail: realAddressDetail ?? this.realAddressDetail,
      realAddressStreet: realAddressStreet ?? this.realAddressStreet,
      realAddressWard: realAddressWard ?? this.realAddressWard,
      realAddressDistrict: realAddressDistrict ?? this.realAddressDistrict,
      realAddressProvince: realAddressProvince ?? this.realAddressProvince,
      legalAddressDetail: legalAddressDetail ?? this.legalAddressDetail,
      legalAddressStreet: legalAddressStreet ?? this.legalAddressStreet,
      legalAddressWard: legalAddressWard ?? this.legalAddressWard,
      legalAddressDistrict: legalAddressDistrict ?? this.legalAddressDistrict,
      legalAddressProvince: legalAddressProvince ?? this.legalAddressProvince,
      roadInPriceRange: roadInPriceRange ?? this.roadInPriceRange,
      distanceToMainRoad: distanceToMainRoad ?? this.distanceToMainRoad,
      roadContiguousTypeId: roadContiguousTypeId ?? this.roadContiguousTypeId,
      positionId: positionId ?? this.positionId,
      minWidthToMainRoad: minWidthToMainRoad ?? this.minWidthToMainRoad,
      maxWidthToMainRoad: maxWidthToMainRoad ?? this.maxWidthToMainRoad,
      note: note ?? this.note,
      zoneId: zoneId ?? this.zoneId,
      positionInPriceRangeId:
          positionInPriceRangeId ?? this.positionInPriceRangeId,
      legalMainDirection: legalMainDirection ?? this.legalMainDirection,
      legalShape: legalShape ?? this.legalShape,
      legalNumberOfFacade: legalNumberOfFacade ?? this.legalNumberOfFacade,
      legalFacadeLength: legalFacadeLength ?? this.legalFacadeLength,
      legalLandLength: legalLandLength ?? this.legalLandLength,
      legalAreaWidth: legalAreaWidth ?? this.legalAreaWidth,
      legalAreaInPlan: legalAreaInPlan ?? this.legalAreaInPlan,
      legalAreaUnPlan: legalAreaUnPlan ?? this.legalAreaUnPlan,
      legalPrivateArea: legalPrivateArea ?? this.legalPrivateArea,
      legalCommonArea: legalCommonArea ?? this.legalCommonArea,
      legalAreaNotConsiderValue:
          legalAreaNotConsiderValue ?? this.legalAreaNotConsiderValue,
      realMainDirection: realMainDirection ?? this.realMainDirection,
      realShape: realShape ?? this.realShape,
      realNumberOfFacade: realNumberOfFacade ?? this.realNumberOfFacade,
      realFacadeLength: realFacadeLength ?? this.realFacadeLength,
      realLandLength: realLandLength ?? this.realLandLength,
      realAreaWidth: realAreaWidth ?? this.realAreaWidth,
      realAreaInPlan: realAreaInPlan ?? this.realAreaInPlan,
      realAreaUnPlan: realAreaUnPlan ?? this.realAreaUnPlan,
      realAreaNotConsiderValue:
          realAreaNotConsiderValue ?? this.realAreaNotConsiderValue,
      realPrivateArea: realPrivateArea ?? this.realPrivateArea,
      realCommonArea: realCommonArea ?? this.realCommonArea,
      assetLandUsingPurposes:
          assetLandUsingPurposes ?? this.assetLandUsingPurposes,
      constructions: constructions ?? this.constructions,
      assetTrees: assetTrees ?? this.assetTrees,
      isConsolidation: isConsolidation ?? this.isConsolidation,
      isConsolidationPurpose:
          isConsolidationPurpose ?? this.isConsolidationPurpose,
      contructionFutureText:
          contructionFutureText ?? this.contructionFutureText,
      totalArea: totalArea ?? this.totalArea,
      buildingDensity: buildingDensity ?? this.buildingDensity,
      coeffcientsUsed: coeffcientsUsed ?? this.coeffcientsUsed,
      height: height ?? this.height,
      totalApartments: totalApartments ?? this.totalApartments,
      numOfFloors: numOfFloors ?? this.numOfFloors,
      underTankArea: underTankArea ?? this.underTankArea,
      wasteTankArea: wasteTankArea ?? this.wasteTankArea,
      numOfUnderFloors: numOfUnderFloors ?? this.numOfUnderFloors,
      basementFloor: basementFloor ?? this.basementFloor,
      totalFloorArea: totalFloorArea ?? this.totalFloorArea,
      depth: depth ?? this.depth,
      constructionFloor: constructionFloor ?? this.constructionFloor,
      constructionArea: constructionArea ?? this.constructionArea,
      turnPart: turnPart ?? this.turnPart,
      solePart: solePart ?? this.solePart,
      towerPart: towerPart ?? this.towerPart,
      constructionTitle: constructionTitle ?? this.constructionTitle,
      structuralSolution: structuralSolution ?? this.structuralSolution,
      architectualSolution: architectualSolution ?? this.architectualSolution,
      systemEngineering: systemEngineering ?? this.systemEngineering,
      systemTraffic: systemTraffic ?? this.systemTraffic,
      interior: interior ?? this.interior,
      estimateComment: estimateComment ?? this.estimateComment,
      constructionChecklists:
          constructionChecklists ?? this.constructionChecklists,
      constructionFutureInfors:
          constructionFutureInfors ?? this.constructionFutureInfors,
      orderBy: orderBy ?? this.orderBy,
      realCurrentPrivateUsing:
          realCurrentPrivateUsing ?? this.realCurrentPrivateUsing,
      legalCurrentPrivateUsing:
          legalCurrentPrivateUsing ?? this.legalCurrentPrivateUsing,
      legalLandLengthDetail:
          legalLandLengthDetail ?? this.legalLandLengthDetail,
      realLandLengthDetail: realLandLengthDetail ?? this.realLandLengthDetail,
    );
  }

  bool isValid() {
    var isLandUsingPurposeHasFalse =
        assetLandUsingPurposes.any((element) => element.isValid() == false);
    if (isLandUsingPurposeHasFalse) {
      return false;
    }
    var isCTXDHasFalse =
        constructions.any((element) => element.isValid() == false);
    return realAreaWidth != null && isCTXDHasFalse == false;
  }
}

@JsonSerializable()
class ConstructionCheckList {
  String? id;
  int? constructionFutureCheckListId; //": 2,
  // int? assetLandInforId; //": 523,
  String? name; //": "Tên công trình",
  double? groundFloorArea; //": 22,
  double? totalFloorArea; //": 33,
  double? height; //": 44,
  double? numOfFloor; //": 55,
  double? length; //": 66,
  double? depth; //": 77
  ConstructionCheckList({
    this.id,
    this.constructionFutureCheckListId,
    // this.assetLandInforId,
    this.name,
    this.groundFloorArea,
    this.totalFloorArea,
    this.height,
    this.numOfFloor,
    this.length,
    this.depth,
  }) {
    id ??= Uuid().generateV4();
  }

  factory ConstructionCheckList.fromJson(Map<String, dynamic> json) =>
      _$ConstructionCheckListFromJson(json);
  Map<String, dynamic> toJson() => _$ConstructionCheckListToJson(this);
}

@JsonSerializable()
class ConstructionFutureInfo {
  String? id;
  int? contructionFutureInforId; //": 21,
  // int? assetLandInforId; //": 523,
  String? name; //": "Tên chỉ tiêu",
  String? basicDesign; //": "Thiết kế cơ sở/Quy hoạch\t",
  String? decision; //": "Quyết định\t"
  ConstructionFutureInfo({
    this.id,
    this.contructionFutureInforId,
    // this.assetLandInforId,
    this.name,
    this.basicDesign,
    this.decision,
  }) {
    id ??= Uuid().generateV4();
  }

  factory ConstructionFutureInfo.fromJson(dynamic json) =>
      _$ConstructionFutureInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ConstructionFutureInfoToJson(this);
}
