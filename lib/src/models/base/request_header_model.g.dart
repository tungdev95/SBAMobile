// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_header_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestHeaderModel _$RequestHeaderModelFromJson(Map<String, dynamic> json) =>
    RequestHeaderModel(
      oS: json['oS'] as String?,
      deviceName: json['deviceName'] as String?,
      deviceId: json['deviceId'] as String?,
      token: json['token'] as String?,
      appID: json['appID'] as String? ?? 'APIVinor2021',
      publicKey: json['publicKey'] as String? ?? 'VHlOLkFwcC5BcGkuMjAyMQ==',
    );

Map<String, dynamic> _$RequestHeaderModelToJson(RequestHeaderModel instance) =>
    <String, dynamic>{
      'oS': instance.oS,
      'deviceName': instance.deviceName,
      'deviceId': instance.deviceId,
      'token': instance.token,
      'appID': instance.appID,
      'publicKey': instance.publicKey,
    };
