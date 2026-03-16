// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeModel _$TreeModelFromJson(Map<String, dynamic> json) => TreeModel(
      treeTypeId: (json['treeTypeId'] as num?)?.toInt(),
      treeDetail: json['treeDetail'] as String?,
      yearOld: (json['yearOld'] as num?)?.toInt(),
      density: (json['density'] as num?)?.toDouble(),
      area: (json['area'] as num?)?.toDouble(),
      lossRate: (json['lossRate'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TreeModelToJson(TreeModel instance) => <String, dynamic>{
      'treeTypeId': instance.treeTypeId,
      'treeDetail': instance.treeDetail,
      'yearOld': instance.yearOld,
      'density': instance.density,
      'area': instance.area,
      'lossRate': instance.lossRate,
      'amount': instance.amount,
    };
