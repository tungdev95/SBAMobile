// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:sba/src/utils/uuid.dart';
part 'detail_describe_model.g.dart';

@JsonSerializable()
class DetailDescribeModel {
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? id;
  int? detailDescribeId;
  int? assetLandInforId;
  String? categoryName;
  String? feature;
  String? area;
  DetailDescribeModel({
    this.detailDescribeId,
    this.assetLandInforId,
    this.categoryName,
    this.feature,
    this.area,
  }) {
    id ??= Uuid().generateV4();
  }

  factory DetailDescribeModel.fromJson(Map<String, dynamic>? json) =>
      _$DetailDescribeModelFromJson(json ?? {});
  Map<String, dynamic> toJson() => _$DetailDescribeModelToJson(this);
}
