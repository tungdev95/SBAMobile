// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetsDetailModel<T> _$AssetsDetailModelFromJson<T>(
        Map<String, dynamic> json) =>
    AssetsDetailModel<T>(
      assetCode: json['assetCode'] as String?,
      assetLevelThreeId: json['assetLevelThreeId'] as int?,
      assetLevelTwoId: json['assetLevelTwoId'] as int?,
      assetObject: _Converter<T?>().fromJson(json['assetObject']),
      assetImages: (json['assetImages'] as List<dynamic>?)
              ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      diagramImages: (json['diagramImages'] as List<dynamic>?)
              ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      otherImages: (json['otherImages'] as List<dynamic>?)
              ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AssetsDetailModelToJson<T>(
        AssetsDetailModel<T> instance) =>
    <String, dynamic>{
      'assetCode': instance.assetCode,
      'assetLevelThreeId': instance.assetLevelThreeId,
      'assetLevelTwoId': instance.assetLevelTwoId,
      'assetObject': _Converter<T?>().toJson(instance.assetObject),
    };
