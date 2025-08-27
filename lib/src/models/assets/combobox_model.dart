// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:sba/src/models/base/base.dart';

part 'combobox_model.g.dart';

@JsonSerializable()
class LegalComboModel {
  final int legalInformationTypeId;
  final String legalInformationTypeName;
  LegalComboModel({
    required this.legalInformationTypeId,
    required this.legalInformationTypeName,
  });

  factory LegalComboModel.fromJson(Map<String, dynamic> json) =>
      _$LegalComboModelFromJson(json);
  Map<String, dynamic> toJson() => _$LegalComboModelToJson(this);
}

@JsonSerializable()
class RoadContiguousType {
  final int? roadContiguousTypeId;
  final String? roadContiguousTypeName;
  RoadContiguousType({
    this.roadContiguousTypeId,
    this.roadContiguousTypeName,
  });

  factory RoadContiguousType.fromJson(Map<String, dynamic> json) =>
      _$RoadContiguousTypeFromJson(json);
  Map<String, dynamic> toJson() => _$RoadContiguousTypeToJson(this);
}

@JsonSerializable()
class PositionModel {
  final int? positionId;
  final String? positionName;

  PositionModel({
    this.positionId,
    this.positionName,
  });

  factory PositionModel.fromJson(Map<String, dynamic> json) =>
      _$PositionModelFromJson(json);
  Map<String, dynamic> toJson() => _$PositionModelToJson(this);
}

@JsonSerializable()
class ZoneModel {
  final int? zoneId;
  final String? zone;
  ZoneModel({
    this.zoneId,
    this.zone,
  });

  factory ZoneModel.fromJson(Map<String, dynamic> json) =>
      _$ZoneModelFromJson(json);
  Map<String, dynamic> toJson() => _$ZoneModelToJson(this);
}

@JsonSerializable()
class PositionInPriceRange {
  final int? positionInPriceRangeId;
  final String? positionInPriceRangeName;
  PositionInPriceRange({
    this.positionInPriceRangeId,
    this.positionInPriceRangeName,
  });

  factory PositionInPriceRange.fromJson(Map<String, dynamic> json) =>
      _$PositionInPriceRangeFromJson(json);
  Map<String, dynamic> toJson() => _$PositionInPriceRangeToJson(this);
}

@JsonSerializable()
class UsingPurposeResponse {
  List<UsingPurpose>? content;
  UsingPurposeResponse({
    this.content,
  });

  factory UsingPurposeResponse.fromJson(Map<String, dynamic> json) =>
      _$UsingPurposeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UsingPurposeResponseToJson(this);
}

@JsonSerializable()
class UsingPurpose {
  final int? usingPurposeId;
  final String? usingPurposeName;
  final int? insideOutside;
  final bool? status;
  UsingPurpose({
    this.usingPurposeId,
    this.usingPurposeName,
    this.insideOutside,
    this.status,
  });

  String? get title {
    if (insideOutside == 1) {
      return '$usingPurposeName (Trong khu CN)';
    } else if (insideOutside == 2) {
      return '$usingPurposeName (Ngoài khu CN)';
    } else {
      return usingPurposeName ?? '';
    }
  }

  factory UsingPurpose.fromJson(Map<String, dynamic> json) =>
      _$UsingPurposeFromJson(json);
  Map<String, dynamic> toJson() => _$UsingPurposeToJson(this);
}

@JsonSerializable()
class ConstructionType {
  final int? constructionTypeId;
  final String? constructionTypeName;
  ConstructionType({
    this.constructionTypeId,
    this.constructionTypeName,
  });

  factory ConstructionType.fromJson(Map<String, dynamic> json) =>
      _$ConstructionTypeFromJson(json);
  Map<String, dynamic> toJson() => _$ConstructionTypeToJson(this);
}

@JsonSerializable()
class ConstructionName {
  int? constructionNameId;
  String? constructionName;
  int? constructionTypeId;
  double? lowPrice;
  double? highPrice;
  ConstructionName({
    this.constructionNameId,
    this.constructionName,
    this.lowPrice,
    this.highPrice,
    this.constructionTypeId,
  });

  factory ConstructionName.fromJson(Map<String, dynamic> json) =>
      _$ConstructionNameFromJson(json);
  Map<String, dynamic> toJson() => _$ConstructionNameToJson(this);
}

@JsonSerializable()
class TreeType {
  @JsonKey(defaultValue: 0)
  final int assetTreeTypeId;
  @JsonKey(defaultValue: '')
  final String assetTreeTypeName;
  TreeType({
    required this.assetTreeTypeId,
    required this.assetTreeTypeName,
  });

  factory TreeType.fromJson(Map<String, dynamic> json) =>
      _$TreeTypeFromJson(json);
  Map<String, dynamic> toJson() => _$TreeTypeToJson(this);
}

@JsonSerializable()
class RoadInPrice {
  @JsonKey(defaultValue: 0)
  final int roadInPriceRangeId;
  @JsonKey(defaultValue: '')
  final String provinceCode;
  @JsonKey(defaultValue: '')
  final String districts;
  @JsonKey(defaultValue: '')
  final String road;
  @JsonKey(defaultValue: '')
  final String doanDuongTu;
  @JsonKey(defaultValue: '')
  final String doanDuongDen;

  String getRoadTitle() {
    return 'Đường $road (từ $doanDuongTu đến $doanDuongDen), $districts';
  }

  RoadInPrice({
    required this.roadInPriceRangeId,
    required this.provinceCode,
    required this.districts,
    required this.road,
    required this.doanDuongTu,
    required this.doanDuongDen,
  });

  factory RoadInPrice.fromJson(Map<String, dynamic> json) =>
      _$RoadInPriceFromJson(json);
  Map<String, dynamic> toJson() => _$RoadInPriceToJson(this);
}

@JsonSerializable()
class RiskModel {
  final int? riskTypeId;
  final String? riskTypeName;
  RiskModel({
    this.riskTypeId,
    this.riskTypeName,
  });

  factory RiskModel.fromJson(Map<String, dynamic> json) =>
      _$RiskModelFromJson(json);
  Map<String, dynamic> toJson() => _$RiskModelToJson(this);
}

@JsonSerializable()
class RiskContentModel {
  final int? riskAssetId;
  final String? riskContent;
  final int? assetLevelTwoId;
  final int? riskLevel;
  RiskContentModel({
    this.riskAssetId,
    this.riskContent,
    this.assetLevelTwoId,
    this.riskLevel,
  });

  factory RiskContentModel.fromJson(Map<String, dynamic> json) =>
      _$RiskContentModelFromJson(json);
  Map<String, dynamic> toJson() => _$RiskContentModelToJson(this);
}

@JsonSerializable()
class DuAnChungCuModel {
  String? id;
  String? name;
  String? provinceId;
  String? districtId;
  String? wardId;
  DuAnChungCuModel({
    this.id,
    this.name,
    this.provinceId,
    this.districtId,
    this.wardId,
  });

  factory DuAnChungCuModel.fromJson(Map<String, dynamic>? json) =>
      _$DuAnChungCuModelFromJson(json ?? {});
  Map<String, dynamic> toJson() => _$DuAnChungCuModelToJson(this);

  KeyValueModel toKeyValueModel() {
    return KeyValueModel(
      key: id ?? '',
      title: name ?? '',
      otherField: {
        'provinceId': provinceId,
        'districtId': districtId,
        'wardId': wardId,
      },
    );
  }
}

@JsonSerializable()
class ToaNhaThucTeModel {
  String? id;
  String? name;
  String? projectId;
  String? provinceId;
  String? districtId;
  String? wardId;
  ToaNhaThucTeModel({
    this.id,
    this.name,
    this.projectId,
    this.provinceId,
    this.districtId,
    this.wardId,
  });

  factory ToaNhaThucTeModel.fromJson(Map<String, dynamic>? json) =>
      _$ToaNhaThucTeModelFromJson(json ?? {});
  Map<String, dynamic> toJson() => _$ToaNhaThucTeModelToJson(this);

  KeyValueModel toKeyValueModel() {
    return KeyValueModel(
      key: id ?? '',
      title: name ?? '',
      otherField: {
        'projectId': projectId,
        'provinceId': provinceId,
        'districtId': districtId,
        'wardId': wardId,
      },
    );
  }
}
