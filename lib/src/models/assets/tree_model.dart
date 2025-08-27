// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:sba/src/utils/uuid.dart';
part 'tree_model.g.dart';

//Cây trồng
@JsonSerializable()
class TreeModel {
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? id;

  ///	Loại cây trồng
  int? treeTypeId;

  ///	Chi tiết cây trồng
  String? treeDetail;

  ///	Năm tuổi
  int? yearOld;

  ///	Mật độ
  double? density;

  ///	Diện tích
  double? area;

  ///	Tỉ lệ hao hụt
  double? lossRate;

  ///	Số lượng cây
  int? amount;
  TreeModel({
    this.treeTypeId,
    this.treeDetail,
    this.yearOld,
    this.density,
    this.area,
    this.lossRate,
    this.amount,
  }) {
    id ??= Uuid().generateV4();
  }

  factory TreeModel.fromJson(dynamic json) =>
      _$TreeModelFromJson(json);
  Map<String, dynamic> toJson() => _$TreeModelToJson(this);
}
