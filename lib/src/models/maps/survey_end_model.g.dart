// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_end_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyEndModel _$SurveyEndModelFromJson(Map<String, dynamic> json) =>
    SurveyEndModel(
      minutesId: json['minutesId'] as String?,
      userName: json['userName'] as String?,
      imageId: json['imageId'] as String?,
      endLocation: json['endLocation'] == null
          ? null
          : LocalLatLng.fromJson(json['endLocation']),
      difference: (json['difference'] as num?)?.toDouble(),
      endAddress: json['endAddress'] as String?,
      endDistance: (json['endDistance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SurveyEndModelToJson(SurveyEndModel instance) =>
    <String, dynamic>{
      'minutesId': instance.minutesId,
      'userName': instance.userName,
      'imageId': instance.imageId,
      'endLocation': instance.endLocation,
      'difference': instance.difference,
      'endAddress': instance.endAddress,
      'endDistance': instance.endDistance,
    };
