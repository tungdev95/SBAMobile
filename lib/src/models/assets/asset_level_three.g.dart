// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_level_three.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetLevelThreeModel _$AssetLevelThreeModelFromJson(
        Map<String, dynamic> json) =>
    AssetLevelThreeModel(
      assetLevelThreeId: json['assetLevelThreeId'] as int?,
      assetLevelThreeName: json['assetLevelThreeName'] as String?,
      assetLevelTwoId: json['assetLevelTwoId'] as String?,
    );

Map<String, dynamic> _$AssetLevelThreeModelToJson(
        AssetLevelThreeModel instance) =>
    <String, dynamic>{
      'assetLevelThreeId': instance.assetLevelThreeId,
      'assetLevelThreeName': instance.assetLevelThreeName,
      'assetLevelTwoId': instance.assetLevelTwoId,
    };
