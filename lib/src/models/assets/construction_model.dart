// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sba/src/utils/uuid.dart';
part 'construction_model.g.dart';

//Công trình xây dựng
@JsonSerializable()
class ConstructionModel extends Equatable {
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? id;

  /// Loại CTXD
  int? constructionTypeId;

  /// hspl
  int? constructionLegalTypeId;

  /// Tên CTXD
  int? constructionNameId;

  /// Diện tích xây dựng
  double? constructionArea;

  /// Loại hồ sơ pháp lý ID
  int? legalInformationTypeId;

  /// Số tầng
  double? floors;

  /// Số tầng hầm
  double? baseFloors;

  /// Năm xây dựng
  int? constructionYear;

  /// Năm sửa chữa
  int? repairYear;

  /// Chất lượng còn lại
  double? remainingQuality;

  /// Mô tả
  String? describe;

  ///Nội thất
  String? furnitures;

  double? mdht;

  int? orderBy;

  ConstructionModel({
    this.id,
    this.constructionTypeId,
    this.constructionLegalTypeId,
    this.constructionNameId,
    this.constructionArea,
    this.legalInformationTypeId,
    this.floors,
    this.baseFloors,
    this.constructionYear,
    this.repairYear,
    this.remainingQuality,
    this.describe,
    this.furnitures,
    this.mdht,
    this.orderBy,
  }) {
    id ??= Uuid().generateV4();
  }

  factory ConstructionModel.fromJson(dynamic json) =>
      _$ConstructionModelFromJson(json);
  Map<String, dynamic> toJson() => _$ConstructionModelToJson(this);

  @override
  List<Object?> get props => [id];

  bool isValid() {
    return constructionTypeId != null &&
        constructionNameId != null &&
        constructionArea != null &&
        constructionLegalTypeId != null &&
        remainingQuality != null &&
        furnitures != null;
  }
}
