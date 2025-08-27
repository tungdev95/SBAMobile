// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_describe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailDescribeModel _$DetailDescribeModelFromJson(Map<String, dynamic> json) =>
    DetailDescribeModel(
      detailDescribeId: json['detailDescribeId'] as int?,
      assetLandInforId: json['assetLandInforId'] as int?,
      categoryName: json['categoryName'] as String?,
      feature: json['feature'] as String?,
      area: json['area'] as String?,
    );

Map<String, dynamic> _$DetailDescribeModelToJson(
        DetailDescribeModel instance) =>
    <String, dynamic>{
      'detailDescribeId': instance.detailDescribeId,
      'assetLandInforId': instance.assetLandInforId,
      'categoryName': instance.categoryName,
      'feature': instance.feature,
      'area': instance.area,
    };
