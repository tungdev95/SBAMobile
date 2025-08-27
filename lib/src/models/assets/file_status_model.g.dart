// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileStatusModel _$FileStatusModelFromJson(Map<String, dynamic> json) =>
    FileStatusModel(
      filesStatusId: json['filesStatusId'] as int,
      filesStatus: json['filesStatus'] as String,
    );

Map<String, dynamic> _$FileStatusModelToJson(FileStatusModel instance) =>
    <String, dynamic>{
      'filesStatusId': instance.filesStatusId,
      'filesStatus': instance.filesStatus,
    };
