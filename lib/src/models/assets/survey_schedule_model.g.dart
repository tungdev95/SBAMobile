// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyScheduleModel _$SurveyScheduleModelFromJson(Map<String, dynamic> json) =>
    SurveyScheduleModel(
      surveyScheduleId: json['surveyScheduleId'] as int?,
      appraisalFileId: json['appraisalFileId'] as String?,
      timeStart: json['timeStart'] == null
          ? null
          : DateTime.parse(json['timeStart'] as String),
      timeEnd: json['timeEnd'] == null
          ? null
          : DateTime.parse(json['timeEnd'] as String),
      note: json['note'] as String?,
      whoCreate: json['whoCreate'] as String?,
      isMetCustomer: json['isMetCustomer'] as bool?,
      extraData: json['extraData'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$SurveyScheduleModelToJson(
        SurveyScheduleModel instance) =>
    <String, dynamic>{
      'surveyScheduleId': instance.surveyScheduleId,
      'appraisalFileId': instance.appraisalFileId,
      'timeStart': instance.timeStart?.toIso8601String(),
      'timeEnd': instance.timeEnd?.toIso8601String(),
      'note': instance.note,
      'whoCreate': instance.whoCreate,
      'isMetCustomer': instance.isMetCustomer,
      'extraData': instance.extraData,
    };
