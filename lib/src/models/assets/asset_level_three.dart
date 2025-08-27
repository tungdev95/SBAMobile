// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'asset_level_three.g.dart';

@JsonSerializable()
class AssetLevelThreeModel {
  final int? assetLevelThreeId;
  final String? assetLevelThreeName;
  final String? assetLevelTwoId;
  
  const AssetLevelThreeModel({
    this.assetLevelThreeId,
    this.assetLevelThreeName,
    this.assetLevelTwoId,
  });

  factory AssetLevelThreeModel.fromJson(Map<String, dynamic> json) =>
      _$AssetLevelThreeModelFromJson(json);
  Map<String, dynamic> toJson() => _$AssetLevelThreeModelToJson(this);
}
