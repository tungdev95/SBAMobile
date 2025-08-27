// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveAssetResponse _$SaveAssetResponseFromJson(Map<String, dynamic> json) =>
    SaveAssetResponse(
      body: json['body'] == null
          ? null
          : SaveAssetBody.fromJson(json['body'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaveAssetResponseToJson(SaveAssetResponse instance) =>
    <String, dynamic>{
      'body': instance.body,
    };

SaveAssetBody _$SaveAssetBodyFromJson(Map<String, dynamic> json) =>
    SaveAssetBody(
      code: json['code'] as int? ?? 200,
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$SaveAssetBodyToJson(SaveAssetBody instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
