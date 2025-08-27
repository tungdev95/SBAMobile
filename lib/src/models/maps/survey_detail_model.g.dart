// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyDetailData _$SurveyDetailDataFromJson(Map<String, dynamic> json) =>
    SurveyDetailData(
      startAddress: json['startAddress'] as String?,
      desAddress: json['desAddress'] as String?,
      startLocation: SurveyDetailData._localLatLngFromJson(
          json['startLocation'] as Map<String, dynamic>?),
      desLocation: SurveyDetailData._localLatLngFromJson(
          json['desLocation'] as Map<String, dynamic>?),
      distance: (json['distance'] as num?)?.toDouble(),
      begin: json['begin'] as bool? ?? false,
      minutesId: json['minutesId'] as String?,
      imageId: json['imageId'] as String?,
      isFinish: json['isFinish'] as bool?,
      doanDuong: json['doanDuong'] as String?,
    );

Map<String, dynamic> _$SurveyDetailDataToJson(SurveyDetailData instance) =>
    <String, dynamic>{
      'startAddress': instance.startAddress,
      'desAddress': instance.desAddress,
      'startLocation': instance.startLocation,
      'desLocation': instance.desLocation,
      'distance': instance.distance,
      'begin': instance.begin,
      'minutesId': instance.minutesId,
      'imageId': instance.imageId,
      'isFinish': instance.isFinish,
      'doanDuong': instance.doanDuong,
    };

LocalLatLng _$LocalLatLngFromJson(Map<String, dynamic> json) => LocalLatLng(
      json['latitude'] as String?,
      json['longitude'] as String?,
    );

Map<String, dynamic> _$LocalLatLngToJson(LocalLatLng instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
